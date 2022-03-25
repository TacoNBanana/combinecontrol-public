local function stub() end
local function untab(str)
	local pref = "\n" .. string.rep("\t", math.max(#str:match("^[\r\n]*(\t*)"), 1))
	return string.gsub("\n" .. str, pref, "\n"):sub(2):gsub("[\t\r\n]*$", "")
end
local function ms(i, j)
	return (math.random(i or 25, j or 100) + math.random(i or 25, j or 100)) / 2 * 0.001
end
local COL = SERVER and Color(137, 222, 255) or Color(231, 219, 116)

dbal = {ASYNC = stub}

--[[
	dbal.new(dbtype, host, user, pass, dbname, port = 3306, aliases = {})
	Creates a new database object.
	- dbtype: "sqlite" or "mysqloo"
	- aliases: key-value table of SQL aliases, ex.
		"select * from $key" -> "select * from value"
]]
function dbal.new(dbtype, host, user, pass, name, port, aliases)
	assert(dbtype == "sqlite" or dbtype == "mysqloo", "unsupported dbtype: " .. dbtype)
	-- because mysqloo has horrible error reporting
	assert(type(host) == "string")
	assert(type(user) == "string")
	assert(type(pass) == "string")
	assert(type(name) == "string")
	assert(port == nil or type(port) == "number")
	local db = {
		Type = dbtype,
		Host = host,
		User = user,
		Pass = pass,
		Name = name,
		Port = port or 3306,
		Aliases = table.Copy(aliases or {}),
	}

	for k, v in pairs(dbal) do
		if dbal[k .. "_" .. dbtype] then
			db[k] = dbal[k .. "_" .. dbtype]
		end
	end
	-- hack?
	db.Aliases.affected_rows = db.ChangesFn
	db.Aliases.last_insert_id = db.LastInsertFn

	setmetatable(db, {
		__index = dbal,
		__call = dbal.Query,
		__tostring = dbal.__tostring
	})

	print(("SQL: Connecting to %s on %s@%s:%i. (%s)"):format(name, user, host, port or 3306, dbtype))
	db:Connect()

	return db
end

-- Called automatically to connect to the database.
-- Don't call this yourself.
function dbal:Connect()
	require("mysqloo")
	self.DB = mysqloo.connect(self.Host, self.User, self.Pass, self.Name, self.Port)

	-- kind of ghetto
	local err
	function self.DB:onConnectionFailed(e) err = e end
	self.DB:connect()
	self.DB:wait()

	if not err then
		print(("SQL: Connected to %s on %s@%s:%i. (%s)"):format(
			self.Name, self.User, self.Host, self.Port or 3306, self.Type
		))
		hook.Run("DbalConnected", self)
	elseif not hook.Run("DbalConnectionFailed", self, err) then
		error(err)
	end
end

-- Disconnects from the server.
function dbal:Disconnect()
	print(("SQL: Disconnected from %s on %s@%s:%i. (%s)"):format(self.Name, self.User, self.Host, self.Port, self.Type))
	self.DB = nil
end

dbal.Connect_sqlite = stub
dbal.Disconnect_sqlite = stub

-- Escapes a value. Used by db:Query() to escape its arguments.
function dbal:Escape(v)
	if v == true or v == false then
		return v and 1 or 0
	elseif type(v) == "number" then
		return v
	elseif v == nil or v == NULL then
		return "NULL"
	elseif type(v) == "function" then
		local fi = debug.getinfo(v)
		error(("tried to escape function: %s:%i"):format(fi.source, fi.linedefined))
	end
	return self:EscapeStr(tostring(v))
end
function dbal:EscapeStr(v) return "'" .. self.DB:escape(v) .. "'" end
function dbal:EscapeStr_sqlite(v) return sql.SQLStr(v) end

-- Substitutes table aliases, replaces ?'s with varargs.
-- Returns a ready-to-use query and how many tokens were replaced.
function dbal:Format(query, ...)
	query = query:gsub("$([a-z_]+)", self.Aliases)
	local args = {...}
	local i = 0
	local function repl()
		i = i + 1
		return self:Escape(args[i])
	end
	return query:gsub("%?", repl)
end

--[[
	Safely formats the given query and runs it. If a callback function is
	given after the format arguments, the query is run NON-BLOCKING:

		1. db:Query() returns nil
		2. when query finishes, callback is called as function(results, ...)

	Usage:

		local function cb(result, start)
			printf("Query got %i rows and took %i seconds.",
				#result, os.time() - start
			)
		end
		db:Query("SELECT * FROM $players WHERE steamid = ?",
			ply:SteamID(), cb, os.time()
		)
]]
function dbal:Query(fmt, ...)
	if type(fmt) == "table" then
		return self:DoTransaction(fmt, ...)
	end
	local query, n = self:Format(fmt, ...)
	if self.DEBUG then
		MsgC(Color(160, 0, 160), untab(query), "\n")
	end

	-- Format() removes values it uses from the table,
	-- so anything left is callback + cb args
	local args = {...}
	local cb = args[n + 1]
	assert(cb == nil or type(cb) == "function", "callback must be a function (arg #" .. n + 1 .. ")")

	return self:RawQuery(query, unpack(args, n + 1))
end

local function getResults(self, q)
	if (tonumber(mysqloo.MINOR_VERSION) or 0) >= 1 then
		local res = {}
		while q:hasMoreResults() do
			res[#res + 1] = q:getData()
			q:getNextResults()
		end
		if self.MULTIRES then
			return res
		end
		return res[#res]
	else
		local res = {q:getData()}
		while q:hasMoreResults() do
			res[#res + 1] = q:getNextResults()
		end
		if self.MULTIRES then
			return res
		end
		return res[#res]
	end
end

-- Like db:Query(), but doesn't do query formatting.
-- You probably shouldn't touch this.
function dbal:RawQuery(query, cb, ...)
	local q = self.DB:query(query)
	if not q then
		if not hook.Run("DbalCreateQueryFailed", self, query, cb, ...) then
			error("couldn\'t create MySQLOO query object! query: '" .. query .. "'")
		end
		return
	end

	local tb = debug.traceback()
	function q.onError(this, err)
		hook.Run("DbalQueryFailed", self, query, err, tb)
	end
	function q.onAborted(this)
		hook.Run("DbalQueryAborted", self, query)
	end

	if cb then
		-- callback was provided - run nonblocking
		local args = {...}

		function q.onSuccess(this)
			assert(xpcall(cb, debug.traceback, getResults(self, this), unpack(args)))
		end
		q:start()

		return nil
	else
		-- bad idea? of course!
		local cr = coroutine.running()
		if cr then
			-- running in a coroutine
			-- yield, and resume when the query completes
			function q.onSuccess(this)
				local ok, res = coroutine.resume(cr, getResults(self, this))
				if not ok then
					error("] " .. debug.traceback(cr, res))
				end
			end
			q:start()

			return coroutine.yield()
		else
			-- running normally, no callback provided
			-- block until the query finishes
			q:start()
			q:wait()
			assert(not err, err)
			return getResults(self, q)
		end
	end
end

function dbal:RawQuery_sqlite(query, cb, ...)
	local data = sql.Query(query)
	local err = sql.LastError()

	local tb = debug.traceback()
	if cb then
		local args = {...}

		timer.Simple(ms(25, 1000), function()
			-- check for errors here so we get the error, but not in this context
			if data == false then
				hook.Run("DbalQueryFailed", self, query, err, tb)
				error(err)
			end
			local ok, err = xpcall(cb, debug.traceback, data or {}, unpack(args))
			assert(ok, "] " .. tostring(err))
		end)

		return nil
	else
		-- bad idea? of course!
		local cr = coroutine.running()
		if cr then
			-- silently eat the error
			if data == false then return end
			timer.Simple(ms(), function()
				local ok, res = coroutine.resume(cr, data or {})
				if not ok then
					error("] " .. debug.traceback(cr, res))
				end
			end)

			return coroutine.yield() or {}
		else
			if data == false then
				hook.Run("DbalQueryFailed", self, query, err, tb)
				return
			end
			return data or {}
		end
	end
end

-- not using error() because most people will be using mysqloo,
-- so this will be in a C++ callback where throwing does nothing
hook.Add("DbalQueryFailed", "HandleQuery", function(db, query, err, trace)
	MsgC(COL, "--- SQL ERROR ---\n")
	MsgC(COL, "Query:\n", untab(query), "\n")
	MsgC(COL, "Error: ", err, "\n", trace, "\n")
end)

hook.Add("DbalQueryAborted", "HandleQuery", function(db, query)
	MsgC(COL, "--- SQL QUERY ABORTED ---\n")
	MsgC(COL, "Query:\n", untab(query), "\n")
end)

-- Like sql.QueryRow, returns the first row of the result set.
function dbal:QueryRow(query, ...)
	return self:Query(query, ...)[1]
end

-- Like sql.QueryValue, returns the first value in the result set.
-- You should probably only select a single column for this.
function dbal:QueryValue(query, ...)
	local _, val = next(self:Query(query, ...)[1] or {})
	return val
end

-- Transactions. Completely untested.
-- eg. db:DoTransaction({"select ?, ?", 1, 2}, {"update $tbl set col=?", "foo"}, cb, cbargs...)
function dbal:DoTransaction(...)
	local args = {...}
	local tr = self.DB:createTransaction()

	-- first few arguments should be {fmt, fmtargs...}
	local n = 0
	for i, v in ipairs(args) do
		if type(v) != "table" then break end
		local query = self:Format(table.remove(v, 1), v)
		tr:addQuery(self.DB:query(query))
		n = n + 1
	end

	local tb = debug.traceback()
	function tr:onError(err)
		hook.Run("DbalTransactionFailed", self, err, tb)
	end

	local cb = args[n]
	assert(cb == nil or type(cb) == "function", "callback must be a function")
	if cb then
		function tr.onSuccess(this)
			for i, v in ipairs(this:getQueries()) do
				table.insert(args, n + i + 1, getResults(self, v))
			end
			assert(xpcall(cb, debug.traceback, unpack(args, n + 2)))
		end
	end

	tr:start()
end

function dbal:DoTransaction_sqlite(...)
	local args = {...}
	local queries = {}

	-- first few arguments should be {fmt, fmtargs...}
	for i, v in ipairs(args) do
		if type(v) != "table" then break end
		local query = self:Format(table.remove(v, 1), v)
		queries[#queries + 1] = query
	end

	local tb = debug.traceback()
	local cb = args[#queries + 1]

	sql.Query("BEGIN")
	for i, v in ipairs(queries) do
		local res = sql.Query(v)
		if res == false then
			local err = sql.LastError()
			sql.Query("ROLLBACK")
			hook.Run("DbalTransactionFailed", self, err, tb)
			return
		end
	end
	assert(xpcall(cb, debug.traceback, unpack(args, n + 1)))
	sql.Query("COMMIT")
end

hook.Add("DbalTransactionFailed", "Notify", function(self, err, tb)
	MsgC(COL, "--- SQL TRANSACTION ERROR ---\n")
	-- MsgC(COL, "Query:\n", untab(query), "\n")
	MsgC(COL, "Error: ", err, "\n", trace, "\n")
end)

--[[
	Builds an INSERT query from the given data table, which may be

		1. A key-value table, where keys are SQL columns
		2. An array of key-value tables

	All values are escaped. If cb is given it's used as a callback similar
	to db:Query().
]]
function dbal:Insert(name, data, cb, ...)
	name = string.gsub(name, "$([a-z]+)", self.Aliases)
	assert(next(data), "data table is empty")
	local cols, rows = {}, {}
	for k, v in SortedPairs(data[1] or data) do
		cols[#cols + 1] = k
	end
	for k, row in pairs(data[1] and data or {data}) do
		local vals = {}
		for i, col in ipairs(cols) do
			vals[#vals + 1] = self:Escape(row[col])
		end
		rows[#rows + 1] = "(" .. table.concat(vals, ", ") .. ")"
	end

	local query = string.format("INSERT INTO %s (%s) VALUES\n%s;\nSELECT %s() AS id;",
		name, table.concat(cols, ", "), table.concat(rows, ",\n"), self.LastInsertFn
	)
	local res = self:RawQuery(query, cb, ...)
	if res then
		return tonumber((res[1] or {}).id)
	end
end

--[[
	Builds an UPDATE query from the given data table, which may be a key-value
	table where keys are SQL columns.
]]
function dbal:Update(name, data, cond, ...)
	if not next(data) then return end
	name = name:gsub("$([a-z]+)", self.Aliases)
	local args, n = {...}

	local cols = {}
	for k, v in pairs(data) do
		cols[#cols + 1] = ("`%s` = %s"):format(k, self:Escape(v))
	end

	if cond then
		cond, n = self:Format(cond, ...)
		cond = " WHERE " .. cond
	end

	self:RawQuery(("UPDATE %s SET %s%s"):format(name, table.concat(cols, ","), cond or ""), unpack(args, n + 1))
end

dbal.LastInsertFn = "last_insert_id"
dbal.LastInsertFn_sqlite = "last_insert_rowid"

dbal.ChangesFn = "affected_rows"
dbal.ChangesFn_sqlite = "changes"

function dbal:LastInsertID()
	return tonumber(self:RawQuery("SELECT " .. self.LastInsertFn .. "() AS id")[1].id)
end

function dbal:__tostring()
	return ("SQL: %s (%s@%s:%i)"):format(self.Name, self.User, self.Host, self.Port)
end

function dbal:__tostring_sqlite()
	return ("SQL: %s (%s@%s:%i)"):format("sv.db", "sqlite", "localhost", 0)
end

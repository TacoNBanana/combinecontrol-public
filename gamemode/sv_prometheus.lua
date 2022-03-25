if not GM.EnablePrometheus then
	return
end

function GM:InitPrometheus()
	self.PrometheusDB = dbal.new(self.MySQLType,
		self.PrometheusSQLHost,
		self.PrometheusSQLUser,
		self.PrometheusSQLPass,
		self.PrometheusSQLDB,
		self.PrometheusSQLPort, {})

	timer.Create("CheckPrometheus", 300, 0, function()
		GAMEMODE:FetchDonations()
	end)
end

function GM:FetchDonations()
	local function cb(res)
		for _, v in pairs(res) do
			self:ProcessDonation(v)
		end
	end

	self.PrometheusDB:Query("SELECT id, CAST(uid AS CHAR) AS uid, actions, expiretime, delivered, active FROM actions WHERE SERVER LIKE '%\"?\"%'", self.PrometheusServerID, cb)
end

local function run(id, ply, func, data)
	if not func then
		return
	end

	local compiled = CompileString(func, "Donation processor: " .. id)

	if not isfunction(compiled) then
		return
	end

	-- Fuck off with your own added code
	Prometheus = {}
	Prometheus.Temp = {}

	compiled(ply)

	Prometheus = nil

	GAMEMODE.PrometheusDB:Update("actions", data, "id = ?", id, stub)
end

function GM:ProcessDonation(tab)
	local target = player.GetBySteamID64(tab.uid)

	if not IsValid(target) then
		return
	end

	local actions = util.JSONToTable(tab.actions)

	if not actions or not actions.custom_action then
		return
	end

	local expire = string.gsub(tab.expiretime, " 00:00:00", "")
	local perma = expire == "1000-01-01"

	if not tobool(tab.delivered) and tobool(tab.active) then -- Deliver
		run(tab.id, target, actions.custom_action.code_when, {
			delivered = 1
		})
	elseif not tobool(tab.delivered) and not tobool(tab.active) and actions.custom_action.code_after then -- Revoke
		run(tab.id, target, actions.custom_action.code_after, {
			delivered = 1
		})
	elseif tobool(tab.active) and not perma and expire < os.date("%Y-%m-%d" , os.time()) and actions.custom_action.code_after then -- Expired
		run(tab.id, target, actions.custom_action.code_after, {
			delivered = 1,
			active = 0
		})
	end
end

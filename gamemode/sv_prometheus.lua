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

	self.PrometheusDB:Query("SELECT actions.id, CAST(actions.uid AS CHAR) AS uid, actions.actions, transactions.price FROM actions LEFT JOIN transactions ON actions.transaction = transactions.id WHERE delivered = 0 AND SERVER LIKE '%\"?\"%'", self.PrometheusServerID, cb)
end

function GM:ProcessDonation(tab)
	local ply = player.GetBySteamID64(tab.uid)

	if not ply then
		return
	end

	tab.actions = util.JSONToTable(tab.actions)

	if not tab.actions.custom_action or not tab.actions.custom_action.code_when then
		return
	end

	local func = CompileString(tab.actions.custom_action.code_when, "Donation processor: " .. tab.id)

	tab.price = tab.price or 0

	-- Fuck off with your own added code
	Prometheus = {}
	Prometheus.Temp = {}

	func(ply, tab.price)

	Prometheus = nil

	self.PrometheusDB:Update("actions", {delivered = 1}, "id = ?", tab.id, stub)
end
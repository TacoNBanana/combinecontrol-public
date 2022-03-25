util.AddNetworkString("nRequestArmoryData")
util.AddNetworkString("nArmoryList")
util.AddNetworkString("nArmoryLogs")

util.AddNetworkString("nSpawnTempArmoryItem")
util.AddNetworkString("nSpawnArmoryItem")

GM.ArmoryData = GM.ArmoryData or {}
GM.ArmoryItems = GM.ArmoryItems or {}
GM.ArmoryLogs = GM.ArmoryLogs or {}
GM.ArmoryLookup = GM.ArmoryLookup or {}

function GM:LoadArmoryData()
	if file.Exists("combinecontrol/armorydata.json", "DATA") then
		self.ArmoryData = util.JSONToTable(file.Read("combinecontrol/armorydata.json", "DATA"))

		local save = false

		for _, armory in pairs(self.ArmoryData) do
			for item in pairs(table.Copy(armory)) do
				if not GAMEMODE.ItemClasses[item] then
					save = true

					armory[item] = nil
				end
			end
		end

		if save then
			self:SaveArmoryData()
		end
	else
		self.ArmoryData = {}
	end
end

function GM:SaveArmoryData()
	file.Write("combinecontrol/armorydata.json", util.TableToJSON(self.ArmoryData, true))
end

function GM:ArmoryExists(name, create)
	local data = self.ArmoryData[name]

	if data then
		return data
	elseif not create then
		return false
	end

	self.ArmoryData[name] = {}

	return self.ArmoryData[name]
end

function GM:DeleteArmory(name)
	self.ArmoryData[name] = nil
	self.ArmorItems[name] = nil

	for _, v in pairs(player.GetAll()) do
		if v:ArmoryAccess() == name then
			v:SetArmoryAccess("")
			v:UpdateCharacterField("ArmoryAccess", "")
		end
	end

	GAMEMODE.SQL:Update("$chars", {ArmoryAccess = ""}, "ArmoryAccess = ?", name, stub)
end

function GM:SetArmoryStock(name, item, stock)
	local data = self:ArmoryExists(name, true)

	if stock == 0 then
		data[item] = nil
	else
		data[item] = stock
	end

	self:SaveArmoryData()
end

function GM:GetArmoryStock(name, item)
	local data = self:ArmoryExists(name)

	if not data then
		return 0
	end

	return data[item] or 0
end

function GM:GetIssuedArmoryItems(name, item)
	local data = self.ArmoryItems[name]

	if not data then
		return 0
	end

	if not data[item] then
		return 0
	end

	local count = 0

	for _, v in pairs(data[item]) do
		if self:GetItem(v) then
			count = count + 1
		end
	end

	return count
end

function GM:CanSpawnArmoryItem(name, item)
	local stock = self:GetArmoryStock(name, item)

	if not stock then
		return false
	end

	if stock == -1 then -- Infinite
		return true, false
	end

	if self:GetIssuedArmoryItems(name, item) >= stock then
		return false
	end

	return true, true
end

function GM:WriteArmoryLog(ply, name, item, temp)
	self.ArmoryLogs[name] = self.ArmoryLogs[name] or {}

	local logs = self.ArmoryLogs[name]
	local log = string.format("%s has %schecked out: %s", ply:VisibleRPName(), temp and "" or "permanently ", GAMEMODE:GetDefaultItemKey(item, "Name"))

	table.insert(logs, log)

	net.Start("nArmoryLogs")
		net.WriteString(log)
	net.Send(ply)
end

function GM:SpawnArmoryItem(ply, name, item)
	local data = self:ArmoryExists(name)

	if not data then
		return
	end

	local stock = data[item]

	if not stock then
		return
	end

	local ok, temp = self:CanSpawnArmoryItem(name, item)

	if not ok then
		return
	end

	if temp then
		local inst = self:CreateTempItem(item, ITEM_WORLD, GAMEMODE:GetItemDropLocation(ply))

		self.ArmoryItems[name] = self.ArmoryItems[name] or {}
		self.ArmoryItems[name][item] = self.ArmoryItems[name][item] or {}

		table.insert(self.ArmoryItems[name][item], inst.ID)

		self:WriteArmoryLog(ply, name, item, true)

		self.ArmoryLookup[inst.ID] = {ply:VisibleRPName(), name, GAMEMODE:GetDefaultItemKey(item, "Name")}

		self:WriteLog("item_armory_checkout", {Item = self:LogItem(inst), Char = self:LogCharacter(ply), Ply = self:LogPlayer(ply)})
	else
		self:DBCreateItem(item, ITEM_WORLD, GAMEMODE:GetItemDropLocation(ply), function(inst)
			self:WriteArmoryLog(ply, name, item)
			self:WriteLog("item_armory_checkout", {Item = self:LogItem(inst), Char = self:LogCharacter(ply), Ply = self:LogPlayer(ply)})
		end)
	end
end

net.Receive("nSpawnTempArmoryitem", function(len, ply)
	local name = net.ReadString()
	local item = net.ReadString()

	if not ply:IsAdmin() and (name != ply:ArmoryAccess() or not IsValid(ply.ActiveZone["cc_zone_armory"])) then
		return
	end

	local ok, temp = GAMEMODE:CanSpawnArmoryItem(name, item)

	if not ok or not temp then
		return
	end

	GAMEMODE:SpawnArmoryItem(ply, name, item)
end)

net.Receive("nSpawnArmoryitem", function(len, ply)
	local name = net.ReadString()
	local item = net.ReadString()

	if not ply:IsAdmin() and (name != ply:ArmoryAccess() or not IsValid(ply.ActiveZone["cc_zone_armory"])) then
		return
	end

	local ok, temp = GAMEMODE:CanSpawnArmoryItem(name, item)

	if not ok or temp then
		return
	end

	GAMEMODE:SpawnArmoryItem(ply, name, item)
end)

net.Receive("nRequestArmoryData", function(len, ply)
	local name = ply:ArmoryAccess()

	if ply:IsAdmin() and len > 0 then
		name = net.ReadString()
	end

	local data = GAMEMODE.ArmoryData[name]

	if not data then
		return
	end

	local tab = {}

	for k, v in pairs(data) do
		table.insert(tab, {k, v, GAMEMODE:GetIssuedArmoryItems(name, k)})
	end

	net.Start("nRequestArmoryData")
		net.WriteUInt(#tab, 10)

		for _, v in pairs(tab) do
			net.WriteString(v[1])
			net.WriteInt(v[2], 8)
			net.WriteInt(v[3], 8)
		end
	net.Send(ply)

	local logs = GAMEMODE.ArmoryLogs[name]

	if logs then
		for _, v in pairs(logs) do
			net.Start("nArmoryLogs")
				net.WriteString(v)
			net.Send(ply)
		end
	end
end)

net.Receive("nArmoryList", function(len, ply)
	if not ply:IsAdmin() then
		return
	end

	net.Start("nArmoryList")
		net.WriteUInt(table.Count(GAMEMODE.ArmoryData), 6)

		for k in pairs(GAMEMODE.ArmoryData) do
			net.WriteString(k)
		end
	net.Send(ply)
end)

hook.Add("CC.SV.InitSQL", "SV.Armory.InitSQL", function()
	GAMEMODE:AddSQLColumn("chars", "ArmoryAccess", "TEXT", "")
end)

hook.Add("CC.SV.LoadCharacterData", "SV.Armory.LoadCharacterData", function(ply, data)
	ply:SetArmoryAccess(data.ArmoryAccess)
end)

hook.Add("CC.SH.UnloadItem", "SV.Armory.UnloadItem", function(item)
	if GAMEMODE.ArmoryLookup[item.ID] then
		local ply, name, itemName = unpack(GAMEMODE.ArmoryLookup[item.ID])

		table.insert(GAMEMODE.ArmoryLogs[name], string.format("Item checked out by %s returned: %s", ply, itemName))

		GAMEMODE.ArmoryLookup[item.ID] = nil
	end
end)

hook.Add("OnGamemodeLoaded", "Armory", function()
	GAMEMODE:LoadArmoryData()
end)

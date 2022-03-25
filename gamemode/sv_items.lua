local meta = FindMetaTable("Player")

hook.Add("CC.SH.InitEnts", "SV.Items.InitEnts", function()
	GAMEMODE:DBLoadWorldItems()
end)

hook.Add("CC.SV.ShutDown", "SV.Items.ShutDown", function()
	for _, v in pairs(GAMEMODE.Items) do
		if v.StoreType == ITEM_WORLD then
			v:SaveLocation()
		end

		v:ShutDown()
	end
end)

hook.Add("CC.SV.InitialSpawn", "SV.Items.InitialSpawn", function(ply)
	for _, v in pairs(GAMEMODE.Items) do
		if v.StoreType == ITEM_WORLD then
			v:UpdateClients({ply})
		end
	end
end)

hook.Add("CC.SH.LoadCharacter", "SV.Items.LoadCharacter", function(ply)
	GAMEMODE:DBLoadCharacterItems(ply:CharID())
end)

hook.Add("CC.SV.UnloadCharacter", "SV.Items.UnloadCharacter", function(ply)
	for _, v in pairs(GAMEMODE.Items) do
		if v.StoreType == ITEM_PLAYER and v.CharacterID == ply:CharID() then
			GAMEMODE:UnloadItem(v)
		end
	end
end)

net.Receive("nDestroyItem", function(len, ply)
	local id = net.ReadInt(32)
	local item = GAMEMODE:GetItem(id)

	if not item then
		return
	end

	if not item:CanDestroy(ply) then
		return
	end

	GAMEMODE:WriteLog("item_destroy", {Char = GAMEMODE:LogCharacter(ply), Ply = GAMEMODE:LogPlayer(ply), Item = GAMEMODE:LogItem(item), Raw = pon.encode(item.Overrides)})
	GAMEMODE:DeleteItem(item)
end)

net.Receive("nDropItem", function(len, ply)
	local id = net.ReadInt(32)
	local item = GAMEMODE:GetItem(id)

	if not item or not item:CanDrop(ply) then
		return
	end

	item:OnDrop(ply)
end)

net.Receive("nUseItem", function(len, ply)
	local id = net.ReadInt(32)
	local action = net.ReadInt(8)
	local item = GAMEMODE:GetItem(id)

	if not item or not item:CanInteract(ply) then
		return
	end

	local actions = item:GetInventoryOptions(ply)

	if actions[action] then
		actions[action].Func(item, ply)
	end
end)

net.Receive("nADestroyItem", function(len, ply)
	local id = net.ReadInt(32)
	local item = GAMEMODE:GetItem(id)

	if not item or not item:CanDestroy(ply) then
		return
	end

	item.Player:SendChat(nil, "WARNING", ply:Nick() .. " removed your item \"" .. item:GetName() .. "\".")

	GAMEMODE:WriteLog("item_destroy_admin", {Admin = GAMEMODE:LogPlayer(ply), Char = GAMEMODE:LogCharacter(item.Player), Ply = GAMEMODE:LogPlayer(item.Player), Item = GAMEMODE:LogItem(item), Raw = pon.encode(item.Overrides)})
	GAMEMODE:DeleteItem(item)
end)

net.Receive("nATakeItem", function(len, ply)
	local id = net.ReadInt(32)
	local item = GAMEMODE:GetItem(id)

	if not item or not item:CanPickup(ply, true) then
		return
	end

	local owner = item.Player

	owner:SendChat(nil, "WARNING", ply:Nick() .. " took your item \"" .. item:GetName() .. "\".")

	item:SetItemLocation(ITEM_PLAYER, ply:CharID())

	GAMEMODE:WriteLog("item_take_admin", {Admin = GAMEMODE:LogPlayer(ply), Char = GAMEMODE:LogCharacter(owner), Ply = GAMEMODE:LogPlayer(owner), Item = GAMEMODE:LogItem(item)})
end)

net.Receive("nClosePlayerInventory", function(len, ply)
	local targ = net.ReadEntity()

	if not IsValid(targ) or targ == ply then
		return
	end

	for _, v in pairs(targ.Inventory) do
		v:RemoveNetworkedPlayer(ply)
	end
end)

net.Receive("nSetItemUserDescription", function(len, ply)
	local id = net.ReadInt(32)
	local desc = net.ReadString()

	local item = GAMEMODE:GetItem(id)

	if not item or not item:CanInteract(ply) then
		return
	end

	if #desc > GAMEMODE.MaxItemDescLength then
		return
	end

	item:SetProperty("UserDescription", #desc > 0 and desc or nil)
end)

net.Receive("nDropAmount", function(len, ply)
	local id = net.ReadInt(32)
	local item = GAMEMODE.Items[id]
	local val = net.ReadInt(32)

	if not item or not class.IsTypeOf(item, "base_stacking") or not item:CanDrop(ply) then
		return
	end

	item:DropAmount(ply, val)
end)

function GM:DBCreateItem(classname, location, locationarg, callback)
	if not class.Exists(classname) then
		return
	end

	local function cb(res)
		local item = GAMEMODE:LoadItem(res[1].id, classname, {}, ITEM_NONE, nil, false)
		item:OnCreated()

		item:SetItemLocation(location, locationarg)

		if callback then
			callback(item)
		end
	end

	self.SQL:Insert("$items", {ItemClass = classname}, cb)
end

function GM:DBLoadItems(ids)
	if #ids < 1 then
		return
	end

	local query = "SELECT * FROM cc_items WHERE "

	for k, v in pairs(ids) do
		if k ~= 1 then
			query = query .. " OR "
		end

		query = query .. string.format("id = '%s'", tostring(v))
	end

	local function cb(res)
		for _, v in pairs(res) do
			local location = v.StorageType
			local locationarg

			if location == ITEM_PLAYER then
				locationarg = v.CharacterID
			elseif location == ITEM_WORLD then
				locationarg = Vector(v.WorldX, v.WorldY, v.WorldZ)
			end

			self:LoadItem(v.id, v.ItemClass, pon.decode(v.CustomData) or {}, location, locationarg)
		end
	end

	self.SQL:Query(query, cb)
end

function GM:DBLoadWorldItems()
	local function cb(res)
		for _, v in pairs(res) do
			local pos = Vector(v.WorldX, v.WorldY, v.WorldZ)
			self:LoadItem(v.id, v.ItemClass, pon.decode(v.CustomData), v.StorageType, pos)
		end
	end

	self.SQL:Query([[
		SELECT * FROM $items
			WHERE StorageType = ? AND WorldMap = ?
		]], ITEM_WORLD, game.GetMap(), cb)
end

function GM:DBLoadCharacterItems(charid)
	local function cb(res)
		for _, v in pairs(res) do
			self:LoadItem(v.id, v.ItemClass, pon.decode(v.CustomData), v.StorageType, v.CharacterID)
		end
	end

	self.SQL:Query([[
		SELECT * FROM $items
			WHERE StorageType = ? AND CharacterID = ?
		]], ITEM_PLAYER, charid, cb)
end

function GM:GetItemDropLocation(ply)
	local tr = util.TraceLine({
		start = ply:GetShootPos(),
		endpos = ply:GetShootPos() + ply:GetAimVector() * 50,
		filter = ply
	})

	return tr.HitPos + tr.HitNormal * 10
end

function GM:CreateItem(ply, classname, arguments)
	self:DBCreateItem(classname, ITEM_WORLD, GAMEMODE:GetItemDropLocation(ply), function(item)
		if istable(arguments) and table.Count(arguments) > 0 then
			item:OnCustomSetup(unpack(arguments))
		end

		self:WriteLog("item_created_admin", {Item = self:LogItem(item), Ply = self:LogPlayer(ply)})
	end)
end

function GM:DeleteItem(item)
	item:OnDestroy()
	item:DeleteItem()

	self:UnloadItem(item)
end

function meta:GiveItem(classname, amount, callback)
	if class.IsChildOf(classname, "base_stacking") then
		local existing = self:GetFirstItem(classname)

		if existing then
			existing:AddAmount(amount)
		else
			GAMEMODE:DBCreateItem(classname, ITEM_PLAYER, self:CharID(), function(item)
				item:SetAmount(amount)

				if callback then
					callback(item)
				end
			end)
		end
	else
		for i = 1, amount do
			GAMEMODE:DBCreateItem(classname, ITEM_PLAYER, self:CharID(), callback)
		end
	end
end
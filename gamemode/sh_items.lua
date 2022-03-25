GM.Items = {}
GM.ItemClasses = {}

function GM:RegisterItem(path)
	if string.Right(path, 4) != ".lua" then
		AddCSLuaFile(path .. "/sh_init.lua")
		include(path .. "/sh_init.lua")
	else
		AddCSLuaFile(path)
		include(path)
	end

	path = string.FileName(path)

	class.Register(path, ITEM)

	if string.Left(path, 4) != "base" then
		self.ItemClasses[path] = true
	end

	-- Just for good measure
	ITEM = nil
end

function GM:RegisterItemFolder(path)
	local files = file.Find(self.FolderName .. "/gamemode/" .. path .. "/*.lua", "LUA")

	for _, v in pairs(files) do
		self:RegisterItem(path .. "/" .. v)
	end
end

GM:RegisterItem("classes/items/base_item")
GM:RegisterItem("classes/items/base_stacking.lua")
GM:RegisterItem("classes/items/base_equipment")
GM:RegisterItem("classes/items/base_clothing.lua")
GM:RegisterItem("classes/items/base_weapon.lua")
--GM:RegisterItem("items/base_augment.lua")
GM:RegisterItem("classes/items/base_deployable.lua")
GM:RegisterItem("classes/items/base_radio.lua")
GM:RegisterItem("classes/items/base_grenade.lua")
GM:RegisterItem("classes/items/base_consumable.lua")
GM:RegisterItem("classes/items/base_light.lua")
GM:RegisterItem("classes/items/item_custom")

GM:RegisterItemFolder("classes/items/clothing")
GM:RegisterItemFolder("classes/items/weapons")
GM:RegisterItemFolder("classes/items/radios")
GM:RegisterItemFolder("classes/items/misc")
GM:RegisterItemFolder("classes/items/consumables")
GM:RegisterItemFolder("classes/items/deployables")
GM:RegisterItemFolder("classes/items/lights")
GM:RegisterItemFolder("classes/items/parts")

function GM:GetDefaultItemKey(classname, key)
	assertf(self.ItemClasses[classname], "Invalid class '%s'", classname)

	return baseclass.Get(classname)[key]
end

function GM:GetItem(id)
	return self.Items[id] or nil
end

function GM:LoadItem(id, classname, overrides, location, locationarg, deleted)
	if SERVER and not class.Exists(classname) then
		if table.Count(overrides) < 1 then
			GAMEMODE.SQL:Query("DELETE FROM $items WHERE id = ?", id, stub)
		else
			GAMEMODE.SQL:Update("$items", {Deleted = 1}, "id = ?", id, stub)
		end

		return
	end

	local item = class.Instance(classname)

	item:Load(id, overrides, location, locationarg, deleted)

	self.Items[id] = item

	return item
end

function GM:UnloadItem(item)
	item.Unloaded = true

	if SERVER then
		item:UnloadClients()
	end

	item:UnsetItemLocation(true)

	self.Items[item.ID] = nil
end

function GM:CanSeeItem(classname, ply)
	local license = self:GetDefaultItemKey(classname, "BusinessLicense")

	if license == BUSINESS_NONE or bit.band(ply:BusinessLicenses(), license) != license then
		return false
	end

	return true
end

function GM:CanBuyItem(classname, ply, amount)
	local item = baseclass.Get(classname)

	amount = amount or 1

	if not self:CanSeeItem(classname, ply) then
		return false
	end

	if ply:Money() < item.BuyPrice * amount then
		return false
	end

	if ply:InventoryWeight() + (item.Weight * amount) > ply:InventoryMaxWeight() then
		return false
	end

	return true
end

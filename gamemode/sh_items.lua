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

function GM:RegisterFolder(path)
	local files = file.Find(self.FolderName .. "/gamemode/" .. path .. "/*.lua", "LUA")

	for _, v in pairs(files) do
		self:RegisterItem(path .. "/" .. v)
	end
end

GM:RegisterItem("items/base_item")
GM:RegisterItem("items/base_stacking.lua")
GM:RegisterItem("items/base_equipment")
GM:RegisterItem("items/item_custom")
GM:RegisterItem("items/base_clothing.lua")
GM:RegisterItem("items/base_weapon.lua")
--GM:RegisterItem("items/base_augment.lua")
GM:RegisterItem("items/base_deployable.lua")
GM:RegisterItem("items/base_radio.lua")
GM:RegisterItem("items/base_grenade.lua")
GM:RegisterItem("items/base_consumable.lua")
GM:RegisterItem("items/base_light.lua")
GM:RegisterItem("items/base_packed.lua")

GM:RegisterFolder("items/clothing")
GM:RegisterFolder("items/weapons")
GM:RegisterFolder("items/radios")
GM:RegisterFolder("items/ammo")
GM:RegisterFolder("items/misc")
GM:RegisterFolder("items/consumables")
GM:RegisterFolder("items/deployables")
GM:RegisterFolder("items/lights")
GM:RegisterFolder("items/parts")
GM:RegisterFolder("items/packed")

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
	if SERVER then
		item:UnloadClients()
	end

	item:UnsetItemLocation(true)

	GAMEMODE.Items[item.ID] = nil
end

function GM:CanSeeItem(classname, ply)
	local license = self:GetDefaultItemKey(classname, "BusinessLicense")
	local buyprice = self:GetDefaultItemKey(classname, "BuyPrice")

	if isnumber(license) and license == BUSINESS_NONE then
		return false
	end

	if not ply:HasLicense(license) then
		return false
	end

	if buyprice < 0 then
		return false
	end

	return true
end

function GM:CanBuyItem(classname, ply, amount)
	local item = baseclass.Get(classname)

	if not amount or amount <= 0 then
		amount = 1
	end

	if not self:CanSeeItem(classname, ply) then
		return false
	end

	if ply:Money() < item.BuyPrice * amount then
		return false, "Not enough money!"
	end

	if ply:InventoryWeight() + (item.Weight * amount) > ply:InventoryMaxWeight() then
		return false, "Too heavy!"
	end

	local max = item.MaxStack
	local existing = ply:GetFirstItem(classname)

	if max and max > 0 and ((amount > max) or (existing and (existing:GetAmount() + amount > max))) then
		return false, "Maximum amount reached!"
	end

	return true
end
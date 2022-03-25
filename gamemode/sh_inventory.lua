local meta = FindMetaTable("Player")

function GM:GetNumItems(items, classname)
	local amt = 0

	for _, v in pairs(items) do
		if v:GetClass() == classname then
			amt = amt + v:GetAmount()
		end
	end

	return amt
end

function GM:HasItem(items, classname, amount)
	amount = tonumber(amount) or 1

	if self:GetNumItems(items, classname) >= amount then
		return true
	end

	return false
end

function GM:GetFirstItem(items, classname)
	for _, v in pairs(items) do
		if v:GetClass() == classname then
			return v
		end
	end
end

function meta:GetNumItems(classname)
	return GAMEMODE:GetNumItems(self.Inventory, classname)
end

function meta:HasItem(classname, amount)
	return GAMEMODE:HasItem(self.Inventory, classname, amount)
end

function meta:GetFirstItem(classname)
	return GAMEMODE:GetFirstItem(self.Inventory, classname)
end

function meta:GetAllEquipment()
	if SERVER then
		return self.Equipment
	end

	local tab = {}

	for k, v in pairs(self.Inventory) do
		if not class.IsTypeOf(v, "base_equipment") then
			continue
		end

		if v:IsWorn() then
			tab[k] = v
		end
	end

	return tab
end

function meta:GetEquipment(slot)
	if SERVER then
		return self.Equipment[slot] or nil
	end

	-- Bit more expensive to do but self.Equipment isn't synced with clients
	for _, v in pairs(self.Inventory) do
		if not class.IsTypeOf(v, "base_equipment") then
			continue
		end

		if v:IsWorn() == slot then
			return v
		end
	end
end

function meta:InventoryWeight()
	local weight = 0

	for _, v in pairs(self.Inventory) do
		weight = weight + v:GetWeight()
	end

	return weight
end

function meta:InventoryMaxWeight()
	local weight = 30

	if self.Inventory then
		local tab = {}

		for _, v in pairs(self.Inventory) do
			local add = v:GetCarryAdd()
			local added = tab[v:GetClass()] or 0

			if add > added then
				weight = weight + (add - added)

				tab[v:GetClass()] = add
			end
		end
	end

	return math.Round(weight)
end

-- TODO: Phase out
function meta:CanTakeItem(item)
	local weight = item:GetWeight()

	if weight < 0 then
		return true
	end

	return self:InventoryWeight() + weight <= self:InventoryMaxWeight()
end

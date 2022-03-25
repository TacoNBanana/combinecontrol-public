DEFINE_BASECLASS("base_item")

function ITEM:GetInventoryOptions(ply)
	local tab = {}

	if self:IsWorn() then
		local delay = self:GetProperty("UnequipDelay")

		table.insert(tab, {
			Delay = delay > 0 and delay or nil,
			DelayName = self:GetProperty("UnequipName"),
			Name = "Unequip",
			Func = function(item, user)
				if SERVER then
					item:Unwear(user)
				end
			end
		})
	else
		local delay = self:GetProperty("EquipDelay")
		local name = self:GetProperty("EquipName")

		for _, v in pairs(self.Slots) do
			local mult = ply:GetEquipment(v) and 2 or 1

			table.insert(tab, {
				Delay = (delay > 0 and self:CanWear(ply, v, true)) and delay * mult or nil,
				DelayName = name,
				Name = "Equip as " .. string.lower(EQUIPMENT_TO_TEXT[v]),
				Func = function(item, user)
					if SERVER then
						if not item:CanWear(user, v) then
							return
						end

						item:Wear(user, v)
					end
				end
			})
		end
	end

	table.Add(tab, BaseClass.GetInventoryOptions(self, ply))

	return tab
end

function ITEM:GetCarryAdd()
	return self:IsWorn() and BaseClass.GetCarryAdd(self) or 0
end

function ITEM:GetGasImmunity()
	return self:GetProperty("GasImmunity")
end

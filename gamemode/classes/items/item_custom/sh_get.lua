DEFINE_BASECLASS("base_item")

function ITEM:GetInventoryOptions(ply)
	local tab = {}

	local locked = self:IsLocked()

	if self:CanLock(ply) then
		table.insert(tab, {
			Name = locked and "Unlock" or "Lock",
			Func = function(item, user)
				if SERVER and item:CanLock(user) then
					item:SetProperty("Locked", not locked)
				end
			end
		})
	end

	if self:CanEdit(ply, true) then
		table.insert(tab, {
			Name = "Customise item",
			Func = function(item, user)
				if CLIENT and item:CanEdit(user) then
					item:OpenEditUI()
				end
			end
		})

		table.insert(tab, {
			Name = "Clone",
			Func = function(item, user)
				if SERVER and item:CanEdit(user) then
					local overrides = table.Copy(item.Overrides)
					user:GiveItem(item:GetClass(), 1, function(clone)
						for property, data in pairs(overrides) do
							clone:SetProperty(property, data)
						end
					end)
				end
			end
		})

		table.insert(tab, {
			Name = "Import/Export",
			Func = function(item, user)
				if CLIENT and item:CanEdit(user) then
					item:OpenImportUI()
				end
			end
		})
	end

	table.Add(tab, BaseClass.GetInventoryOptions(self, ply))

	return tab
end
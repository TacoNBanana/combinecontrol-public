function ITEM:GetInventoryOptions(ply)
	if not self:CanInteract(ply) then
		return {}
	end

	local tab = {}

	if not self:GetProperty("Generic") then
		table.insert(tab, {
			Name = "View description",
			Func = function(item, user)
				if CLIENT then
					item:CreateUserDescription(true)
				end
			end
		})
	end

	if self.UseCondition and self:GetCondition() > CONDITION_GOOD then
		table.insert(tab, {
			Name = "Repair",
			Func = function(item, user)
				if SERVER then
					if item.ScrapItem then
						local kit = user:GetFirstItem(item.ScrapItem)

						if kit then
							GAMEMODE:DeleteItem(kit)
							item:SetProperty("Condition", CONDITION_GOOD)
						else
							user:SendChat(nil, "ERROR", string.format("You need %s to repair this!", GAMEMODE:GetDefaultItemKey(item.ScrapItem, "Name")))
						end
					else
						local kit = user:GetFirstItem("repairkit")

						if kit then
							GAMEMODE:DeleteItem(kit)
							item:SetProperty("Condition", CONDITION_GOOD)
						else
							user:SendChat(nil, "ERROR", "You need a repair kit!")
						end
					end
				end
			end
		})
	end

	return tab
end

function ITEM:GetName()
	local name = self:GetProperty("Name")
	local cond = self:GetCondition()

	if cond == CONDITION_DAMAGED then
		name = "Damaged " .. name
	elseif cond == CONDITION_HEAVILYDAMAGED then
		name = "Heavily Damaged " .. name
	elseif self:IsBroken() then
		name = "Broken " .. name
	end

	return name
end

function ITEM:GetWeight()
	return self:GetProperty("Weight")
end

function ITEM:GetCarryAdd()
	return self:GetProperty("CarryAdd")
end

function ITEM:GetAmount()
	return 1
end

function ITEM:GetCondition()
	return self:GetProperty("Condition")
end
ITEM = class.Create("base_stacking")
DEFINE_BASECLASS("base_stacking")

ITEM.Name 			= "base_consumable"

ITEM.Blacklist 		= table.AddToCopy(BaseClass.Blacklist, {})

ITEM.CanUseSelf 	= true
ITEM.UseSelfName 	= "Use"

ITEM.CanUseOthers 	= false
ITEM.CanUseAnything = false
ITEM.UseOthersName 	= "Apply"

function ITEM:GetInventoryOptions(ply)
	local tab = {}

	if self.CanUseSelf then
		table.insert(tab, {
			Name = self.UseSelfName,
			Func = function(item, user)
				if SERVER and not self:OnUse(user) then
					self:TakeAmount(1)
				end
			end
		})
	end

	if self.CanUseOthers then
		table.insert(tab, {
			Name = self.UseOthersName,
			Func = function(item, user)
				if SERVER then
					local target = user:GetEyeTrace().Entity

					if not IsValid(target) or (not self.CanUseAnything and not (target:IsPlayer() or target:IsBot())) then
						user:SendChat(nil, "ERROR", "Error: You can't use this on that!")
						return
					end

					if SERVER and not self:OnUseOther(user, target) then
						self:TakeAmount(1)
					end
				end
			end
		})
	end

	table.Add(tab, BaseClass.GetInventoryOptions(self, ply))

	return tab
end

if SERVER then
	-- Return true to cancel consumption
	function ITEM:OnUse(ply)
	end

	function ITEM:OnUseOther(ply, target)
	end
end
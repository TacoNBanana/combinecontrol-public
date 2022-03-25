ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Baseball Cap"
ITEM.Description 			= "A baseball cap with the american flag on it."

ITEM.Model					= Model("models/tnb/items/trp/headgear/hat3.mdl")

ITEM.Weight 				= 0.1

ITEM.Slots 					= {EQUIPMENT_HEAD}

ITEM.Flipped 				= false

if SERVER then
	function ITEM:GetModelData(ply, data)
		table.Merge(data.head, {
			bodygroups = {
				hat = self:GetProperty("Flipped") and 1 or 3
			}
		})
	end
end

function ITEM:GetInventoryOptions(ply)
	local tab = {}

	if self:IsWorn() then
		table.insert(tab, {
			Name = "Flip",
			Func = function(item, user)
				if SERVER then
					self:SetProperty("Flipped", not self:GetProperty("Flipped"))

					ply:RecalculatePlayerModel()
				end
			end
		})
	end

	table.Add(tab, BaseClass.GetInventoryOptions(self, ply))

	return tab
end

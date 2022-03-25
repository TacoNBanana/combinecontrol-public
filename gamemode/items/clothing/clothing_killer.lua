ITEM = class.Create("base_clothing_body")
DEFINE_BASECLASS("base_clothing_body")

ITEM.Name 					= "Bloodied Jacket"
ITEM.Description 			= "A hooded jacket stained by dried blood."

ITEM.Model					= Model("models/tnb/items/trp/clothes/item_killer.mdl")

ITEM.Weight 				= 2
ITEM.ArmorValue 			= 0

ITEM.Hood 					= false

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.body = {
			model = string.format("models/tnb/clothing/trp/body/%s_killer.mdl", ply:Gender()),
			bodygroups = {
				hood = self:GetProperty("Hood")
			}
		}
	end

	function ITEM:PostGetModelData(ply, data)
		if self:GetProperty("Hood") then
			table.Merge(data, {
				head = {
					bodygroups = {
						hat = 0
					}
				}
			})
		end
	end
end

function ITEM:GetInventoryOptions(ply)
	local tab = {}

	if self:IsWorn() then
		table.insert(tab, {
			Name = "Toggle hood",
			Context = true,
			Func = function(item, user)
				if SERVER then
					self:SetProperty("Hood", not self:GetProperty("Hood"))

					ply:RecalculatePlayerModel()
				end
			end
		})
	end

	table.Add(tab, BaseClass.GetInventoryOptions(self, ply))

	return tab
end

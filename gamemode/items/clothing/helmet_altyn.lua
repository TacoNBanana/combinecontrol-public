ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Altyn Helmet"
ITEM.Description 			= "A very heavy ballistic helmet of russian origin. Features a flip-up face shield for extra protection."

ITEM.Model					= Model("models/tnb/items/trp/headgear/hat18.mdl")

ITEM.Weight 				= 4.5

ITEM.Slots 					= {EQUIPMENT_HEAD}

ITEM.Visor 					= false

if SERVER then
	function ITEM:GetModelData(ply, data)
		table.Merge(data.head, {
			bodygroups = {
				hat = self:GetProperty("Visor") and 17 or 16
			}
		})
	end
end

function ITEM:GetInventoryOptions(ply)
	local tab = {}

	if self:IsWorn() then
		table.insert(tab, {
			Name = "Toggle visor",
			Context = true,
			Func = function(item, user)
				if SERVER then
					self:SetProperty("Visor", not self:GetProperty("Visor"))

					ply:RecalculatePlayerModel()
				end
			end
		})
	end

	table.Add(tab, BaseClass.GetInventoryOptions(self, ply))

	return tab
end

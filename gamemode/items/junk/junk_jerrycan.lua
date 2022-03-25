ITEM = class.Create("base_stacking")
DEFINE_BASECLASS("base_stacking")

ITEM.Name 			= "Jerrycan (Empty)"
ITEM.Description 	= "An empty fluid container made out of pressed steel."

ITEM.Model			= "models/illusion/eftcontainers/gasoline.mdl"

ITEM.Weight 		= 0.4

function ITEM:GetInventoryOptions(ply)
	local tab = {}

	if ply:WaterLevel() >= 1 and ply:Crouching() then
		table.insert(tab, {
			Delay = 10,
			DelayName = "Filling...",
			Name = "Fill with water",
			Func = function(item, user)
				if SERVER then
					item:TakeAmount(1)

					user:GiveItem("junk_jerrycan_water", 1)
				end
			end
		})
	end

	table.Add(tab, BaseClass.GetInventoryOptions(self, ply))

	return tab
end

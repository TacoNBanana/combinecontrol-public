ITEM = class.Create("base_stacking")
DEFINE_BASECLASS("base_stacking")

ITEM.Name 			= "Water bottle (Empty)"
ITEM.Description 	= "An empty plastic bottle that used to contain water."

ITEM.Model			= "models/illusion/eftcontainers/waterbottle.mdl"

ITEM.Weight 		= 0.1

function ITEM:GetInventoryOptions(ply)
	local tab = {}

	if ply:WaterLevel() >= 1 and ply:Crouching() then
		table.insert(tab, {
			Delay = 1,
			DelayName = "Filling...",
			Name = "Fill with water",
			Func = function(item, user)
				if SERVER then
					item:TakeAmount(1)

					user:GiveItem("food_waterbottle", 1)
				end
			end
		})
	end

	table.Add(tab, BaseClass.GetInventoryOptions(self, ply))

	return tab
end

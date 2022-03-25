ITEM = class.Create("base_equipment")
DEFINE_BASECLASS("base_equipment")

ITEM.Name 			= "Compass"
ITEM.Description 	= "Sometimes points in the right direction."

ITEM.Model			= Model("models/jaanus/thruster_flat.mdl")

ITEM.Weight 		= 0.1

ITEM.Slots 			= {EQUIPMENT_EQUIP1, EQUIPMENT_EQUIP2}

function ITEM:GetInventoryOptions(ply)
	local tab = {}

	table.insert(tab, {
		Name = "Check heading",
		Context = true,
		Func = function(item, user)
			if CLIENT then
				local bearing = math.floor(math.AngleToHeading(user:GetAngles().y))

				GAMEMODE:AddChat(string.format("The needle points to %i degrees (%s).", bearing, GAMEMODE:GetHeading(bearing)), Color(200, 200, 200, 255))
			end
		end
	})

	table.Add(tab, BaseClass.GetInventoryOptions(self, ply))

	return tab
end

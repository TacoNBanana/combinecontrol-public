ITEM = class.Create("base_equipment")
DEFINE_BASECLASS("base_equipment")

ITEM.Name 			= "GPS"
ITEM.Description 	= "Despite a thermonuclear war having destroyed the vast majority of global infrastructure, this still seems to work just fine."

ITEM.Model			= Model("models/beer/wiremod/gps_mini.mdl")

ITEM.Weight 		= 0.2

ITEM.Slots 			= {EQUIPMENT_EQUIP1, EQUIPMENT_EQUIP2}

function ITEM:GetInventoryOptions(ply)
	local tab = {}

	table.insert(tab, {
		Name = "Check heading",
		Context = true,
		Func = function(item, user)
			if CLIENT then
				local bearing = math.floor(math.AngleToHeading(user:GetAngles().y))

				GAMEMODE:AddChat(string.format("The GPS reads %i degrees (%s)", bearing, GAMEMODE:GetHeading(bearing)), Color(200, 200, 200, 255))
			end
		end
	})

	table.insert(tab, {
		Name = "Check grid",
		Context = true,
		Func = function(item, user)
			if CLIENT then
				local pos = user:GetPos()
				local gridX, gridY = util.ToGrid(pos.x, pos.y)

				GAMEMODE:AddChat(string.format("The GPS reads %03i horizontal and %03i vertical", gridX + util.GridNoiseX, gridY + util.GridNoiseY), Color(200, 200, 200, 255))
			end
		end
	})

	table.Add(tab, BaseClass.GetInventoryOptions(self, ply))

	return tab
end

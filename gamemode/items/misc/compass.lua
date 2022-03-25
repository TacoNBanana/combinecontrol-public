ITEM = class.Create("base_item")
DEFINE_BASECLASS("base_item")

ITEM.Name 			= "Compass"
ITEM.Description 	= "Sometimes points in the right direction."

ITEM.Model			= Model("models/props_trainstation/trainstation_clock001.mdl")
ITEM.Scale 			= 0.1

ITEM.BusinessLicense 			= BUSINESS_GENERIC
ITEM.BuyPrice 					= 50
ITEM.SellPrice 					= 20

ITEM.Weight 		= 0.5

function ITEM:GetInventoryOptions(ply)
	local tab = {}

	table.insert(tab, {
		Name = "Check heading",
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
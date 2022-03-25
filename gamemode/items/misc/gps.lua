ITEM = class.Create("base_item")

ITEM.Name 			= "GPS Device"
ITEM.Description 	= "A small GPS device capable of reading out your current direction."

ITEM.Model			= "models/gibs/shield_scanner_gib1.mdl"

ITEM.BusinessLicense 			= BUSINESS_GENERIC
ITEM.BuyPrice 					= 200
ITEM.SellPrice 					= 100

ITEM.Weight 		= 0.5

ITEM.Usable			= true
ITEM.UseText		= "Use"
ITEM.OnPlayerUse	= function(self, ply)
	if CLIENT then
		local ang = ply:GetAngles()
		local bearing = math.floor(math.AngleToHeading(ang.y))

		GAMEMODE:AddChat("The GPS device's screen reads:", Color(200, 200, 200, 255))
		GAMEMODE:AddChat(string.format("Heading: %s (%s)", bearing, GAMEMODE:GetHeading(bearing)), Color(200, 200, 200, 255))
	end
end
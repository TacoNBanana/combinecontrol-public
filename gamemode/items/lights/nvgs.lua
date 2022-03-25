ITEM = class.Create("base_light")

ITEM.Name 			= "Nightvision goggles"
ITEM.Description 	= "Allows you to see in the dark"

ITEM.Model			= Model("models/gibs/shield_scanner_gib1.mdl")

ITEM.BusinessLicense 			= BUSINESS_GENERIC
ITEM.BuyPrice 					= 300
ITEM.SellPrice 					= 100

ITEM.Weight 		= 1

if SERVER then
	function ITEM:OnUnworn(ply)
		ply:SetOverlayMode(OVERLAY_NONE)
	end

	function ITEM:Toggle(ply)
		local headgear =  ply:GetEquipment(EQUIPMENT_HEAD)

		if ply:GetCharFlagAttribute("CanUseNightvision") or (headgear and headgear:GetClass() == "clothing_nvgs") then
			if ply:OverlayMode() == OVERLAY_NONE then
				ply:SetOverlayMode(OVERLAY_NVG)
			else
				ply:SetOverlayMode(OVERLAY_NONE)
			end
		else
			ply:SendChat(nil, "ERROR", "You need to be wearing nightvision goggles to use this!")
		end
	end
end
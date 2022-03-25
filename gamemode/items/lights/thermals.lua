ITEM = class.Create("base_light")

ITEM.Name 			= "Thermal goggles"
ITEM.Description 	= "Allows you to see"

ITEM.Model			= Model("models/gibs/shield_scanner_gib1.mdl")

ITEM.Weight 		= 1

if SERVER then
	function ITEM:OnUnworn(ply)
		ply:SetOverlayMode(OVERLAY_NONE)
	end

	function ITEM:Toggle(ply)
		if ply:OverlayMode() == OVERLAY_NONE then
			ply:SetOverlayMode(OVERLAY_THERMAL)
		else
			ply:SetOverlayMode(OVERLAY_NONE)
		end
	end
end
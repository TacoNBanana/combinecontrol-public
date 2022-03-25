ITEM = class.Create("base_light")

ITEM.Name 			= "Target finder"
ITEM.Description 	= "Sensor upgrade which highlights targets within a certain range"

ITEM.Model			= Model("models/gibs/shield_scanner_gib1.mdl")

ITEM.Weight 		= 1

if SERVER then
	function ITEM:OnUnworn(ply)
		ply:SetOverlayMode(OVERLAY_NONE)
	end

	function ITEM:Toggle(ply)
		if ply:OverlayMode() == OVERLAY_NONE then
			ply:SetOverlayMode(OVERLAY_TARGET)
		else
			ply:SetOverlayMode(OVERLAY_NONE)
		end
	end
end
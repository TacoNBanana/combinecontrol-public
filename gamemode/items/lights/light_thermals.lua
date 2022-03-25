ITEM = class.Create("base_light")

ITEM.Name 			= "Thermal Goggles"
ITEM.Description 	= "Allows you to see."

ITEM.Model			= Model("models/tnb/items/trp/headgear/nvg2.mdl")

ITEM.Weight 		= 2

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.head.bodygroups = data.head.bodygroups or {}
		data.head.bodygroups.nvg = ply:OverlayMode() == OVERLAY_NONE and 1 or 2
	end

	function ITEM:OnWorn(ply)
		ply:RecalculatePlayerModel()
	end

	function ITEM:OnUnworn(ply)
		ply:SetOverlayMode(OVERLAY_NONE)
		ply:RecalculatePlayerModel()
	end

	function ITEM:Toggle(ply)
		if ply:OverlayMode() == OVERLAY_NONE then
			ply:SetOverlayMode(OVERLAY_THERMAL)
		else
			ply:SetOverlayMode(OVERLAY_NONE)
		end

		ply:RecalculatePlayerModel()
	end
end

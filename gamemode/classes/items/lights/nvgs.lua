ITEM = class.Create("base_light")

ITEM.Name 			= "Nightvision goggles"
ITEM.Description 	= "Allows you to see in the dark"

ITEM.Model			= Model("models/gibs/shield_scanner_gib1.mdl")

ITEM.Weight 		= 1

if SERVER then
	function ITEM:OnUnworn(ply)
		net.Start("nSetNightvision")
			net.WriteBit(0)
		net.Send(ply)
	end

	function ITEM:Toggle(ply)
		local headgear =  ply:GetEquipment(EQUIPMENT_HEAD)

		if ply:GetCharFlagAttribute("CanUseNightvision") or (headgear and headgear:GetClass() == "clothing_nvgs") then
			net.Start("nToggleNightvision")
			net.Send(ply)
		else
			ply:SendChat(nil, "ERROR", "You need to be wearing nightvision goggles to use this!")
		end
	end
end
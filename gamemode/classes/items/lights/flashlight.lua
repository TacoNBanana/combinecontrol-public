ITEM = class.Create("base_light")

ITEM.Name 			= "Flashlight"
ITEM.Description 	= "Lights up dark passages"

ITEM.Model			= Model("models/maxofs2d/lamp_flashlight.mdl")
ITEM.Scale 			= 0.25

ITEM.Weight 		= 1

if SERVER then
	function ITEM:OnUnworn(ply)
		if ply:FlashlightIsOn() then
			ply:Flashlight(false)
		end
	end

	function ITEM:Toggle(ply)
		return true
	end
end
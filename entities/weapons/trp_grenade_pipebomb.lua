AddCSLuaFile()
DEFINE_BASECLASS("tekka_base_throwing")

SWEP.Base 				= "tekka_base_throwing"

SWEP.PrintName 			= "Pipe bomb"
SWEP.Category 			= "TRP - Grenades"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/trpweapons/c_pipebomb.mdl")
SWEP.WorldModel 		= Model("models/tnb/trpweapons/w_pipebomb.mdl")

SWEP.AmmoItem 			= "grenade_pipebomb"

SWEP.ThrowEntity 		= "cc_grenade_pipebomb"
SWEP.ThrowSound 		= "WeaponFrag.Throw"

function SWEP:CreateEntity()
	local ent = BaseClass.CreateEntity(self)

	ent:SetTimer(math.Rand(2, 5))

	return ent
end

AddCSLuaFile()
DEFINE_BASECLASS("tekka_base_throwing")

SWEP.Base 				= "tekka_base_throwing"

SWEP.PrintName 			= "Frag Grenade"
SWEP.Category 			= "TRP - Grenades"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/weapons/c_grenade.mdl")
SWEP.WorldModel 		= Model("models/weapons/w_grenade.mdl")

SWEP.AmmoItem 			= "grenade_frag"

SWEP.ThrowEntity 		= "cc_grenade_frag"
SWEP.ThrowSound 		= "WeaponFrag.Throw"

function SWEP:CreateEntity()
	local ent = BaseClass.CreateEntity(self)

	ent:SetTimer(3)

	return ent
end

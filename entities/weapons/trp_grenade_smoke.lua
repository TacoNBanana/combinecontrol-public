AddCSLuaFile()
DEFINE_BASECLASS("tekka_base_throwing")

SWEP.Base 				= "tekka_base_throwing"

SWEP.PrintName 			= "Smoke Grenade"
SWEP.Category 			= "TRP - Grenades"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/weapons/c_grenade.mdl")
SWEP.WorldModel 		= Model("models/weapons/w_eq_smokegrenade.mdl")

SWEP.AmmoItem 			= "grenade_smoke"

SWEP.ThrowEntity 		= "cc_grenade_smoke"
SWEP.ThrowSound 		= "WeaponFrag.Throw"

SWEP.SmokeColor			= Color(135, 135, 135)

SWEP.HoldType 			= "grenade"
SWEP.HoldTypeLowered 	= "normal"

function SWEP:CreateEntity()
	local ent = BaseClass.CreateEntity(self)

	ent:SetColor(self.SmokeColor)
	ent:SetTimer(3)
	ent:SetDoRemove(true)

	return ent
end

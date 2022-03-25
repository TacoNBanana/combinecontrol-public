AddCSLuaFile()

SWEP.Base 				= "tekka_base_throwing"

SWEP.PrintName 			= "Tear gas grenade"
SWEP.Category 			= "Tekka"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/weapons/c_grenade.mdl")
SWEP.WorldModel 		= Model("models/weapons/w_eq_smokegrenade.mdl")

SWEP.AmmoItem 			= "weapon_grenade_teargas"
SWEP.ThrowEntity 		= "cc_grenade_teargas"
SWEP.ThrowSound 		= "WeaponFrag.Throw"

SWEP.HoldType 			= "grenade"
SWEP.HoldTypeLowered 	= "normal"

SWEP.LoweredOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, 0, 0)
}

function SWEP:CreateEntity()
	local ent = self.BaseClass.CreateEntity(self)

	ent:SetTimer(3)

	return ent
end
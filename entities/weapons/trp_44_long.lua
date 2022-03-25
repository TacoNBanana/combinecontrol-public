AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= ".44 Magnum Long"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_magnum.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_magnum.mdl")

SWEP.VMBodyGroups 			= {1}
SWEP.WMBodyGroups 			= {1}

SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 6
SWEP.Damage 				= 80
SWEP.FireDelay 				= 0.4

SWEP.AmmoItem 				= "ammo_pistol"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 3


SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.05

SWEP.FireSound 				= "Weapon_357.Single"

SWEP.Animations = {
	reload = "reload",
	fire = "fire"
}

SWEP.HoldType 			= "revolver"
SWEP.HoldTypeLowered 	= "normal"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, 0, 0)
}

SWEP.AimOffset = {
	ang = Vector(-1.5, 0, 0),
	pos = Vector(-4.545, -3.5, 0.8)
}

SWEP.LoweredOffset = {
	ang = Vector(-25, 0, 0),
	pos = Vector(0, 0, 3)
}
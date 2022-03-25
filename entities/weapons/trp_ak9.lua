AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "AK9"

SWEP.Category 				= "TRP"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true
SWEP.DrawCrosshair 			= false
SWEP.ViewModel 				= Model("models/tnb/weapons/c_bizon.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_bizon.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "tracer"

SWEP.VMBodyGroups 			= {2}
SWEP.WMBodyGroups 			= {2}

SWEP.ClipSize 				= 30
SWEP.Damage 				= 50
SWEP.FireDelay 				= 0.1

SWEP.AmmoItem 				= "ammo_rifle"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}},
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 0.5

SWEP.AimCone 				= 0.02
SWEP.HipCone 				= 0.06

SWEP.FireSound 				= soundscript.AddFire("WEAPON_FAMAS", "tekka/weapons/weapon_famas.wav", 140)


SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-3, -8, 2)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-7.949, -14, 2.8)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}

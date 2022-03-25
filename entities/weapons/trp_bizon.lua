AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Bizon"

SWEP.Category 				= "TRP"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true
SWEP.DrawCrosshair 			= false
SWEP.ViewModel 				= Model("models/tnb/weapons/c_bizon.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_bizon.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "tracer"

SWEP.VMBodyGroups 			= {1}
SWEP.WMBodyGroups 			= {1}

SWEP.ClipSize 				= 64
SWEP.Damage 				= 10
SWEP.FireDelay 				= 0.06

SWEP.AmmoItem 				= "ammo_pistol"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}},
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 0.2

SWEP.AimCone 				= 0.02
SWEP.HipCone 				= 0.06

SWEP.FireSound 				= soundscript.AddFire("WEAPON_SILENCEDSHARP", "tekka/weapons/weapon_silencedsharp.wav", 80)


SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-3, -8, 1)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-7.96, -12, 1.9)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}

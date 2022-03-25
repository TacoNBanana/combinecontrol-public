AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "P90"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_p90.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_p90.mdl")

SWEP.UseHands 				= true

SWEP.VMBodyGroups 			= {2}
SWEP.WMBodyGroups 			= {2}

SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 50
SWEP.Damage 				= 20
SWEP.FireDelay 				= 0.06

SWEP.AmmoItem 				= "ammo_pistol"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}

SWEP.Recoil 				= 0.1



SWEP.AimCone 				= 0.03
SWEP.HipCone 				= 0.06

SWEP.FireSound 				= soundscript.AddFire("WEAPON_MAC10", "tekka/weapons/weapon_mac10.wav", 140)

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}


SWEP.HoldType 			= "smg"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2, -1, 2)
}

SWEP.AimOffset = {
	ang = Vector(0, 0.5, 0),
	pos = Vector(-5.579, -10, 2.05)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}

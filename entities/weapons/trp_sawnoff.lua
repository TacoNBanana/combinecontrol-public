AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Sawnoff"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_sawnoff.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_sawnoff.mdl")

SWEP.UseHands 				= true

SWEP.VMBodyGroups 			= {1}
SWEP.WMBodyGroups 			= {1}

SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 2
SWEP.Damage 				= 18
SWEP.BulletCount 			= 12
SWEP.FireDelay 				= -1

SWEP.AmmoItem 				= "ammo_shotgun"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.PumpAction 			= false
SWEP.ShotgunReload 			= false

SWEP.Firemodes 				= {
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 1

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.01

SWEP.UseClumpSpread 		= true
SWEP.ClumpSpread 			= 0.06

SWEP.FireSound 				= soundscript.AddFire("WEAPON_SHOTGUNBLAST", "tekka/weapons/weapon_shotgunblast.wav", 140)

SWEP.Animations = {
	fire = {"shoot1", "shoot2"},
	reload = "reload",

}

SWEP.HoldType 			= "pistol"
SWEP.HoldTypeLowered 	= "normal"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-3, -10, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-5.9, -12, 4)
}


SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}

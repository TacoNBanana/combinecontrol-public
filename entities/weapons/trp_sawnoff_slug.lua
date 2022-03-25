AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Sawnoff Handcanon"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_sawnoff.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_sawnoff.mdl")

SWEP.UseHands 				= true

SWEP.VMBodyGroups 			= {2}
SWEP.WMBodyGroups 			= {2}

SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 1
SWEP.Damage 				= 40
SWEP.BulletCount 			= 14
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

SWEP.FireSound 				= soundscript.AddFire("WEAPON_WESTERN", "tekka/weapons/weapon_western.wav", 140)

SWEP.Animations = {
	fire = {"shoot1", "shoot2"},
	reload = "reload",

}

SWEP.HoldType 			= "revolver"
SWEP.HoldTypeLowered 	= "normal"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2, -7, 2)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-5.8, -8, 3.6)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}

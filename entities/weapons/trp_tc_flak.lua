AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Techcom Plasma Handcanon"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_alyx_shotgun.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_alyx_shotgun.mdl")

SWEP.UseHands 				= true

SWEP.VMBodyGroups 			= {0}
SWEP.WMBodyGroups 			= {0}

SWEP.Tracer 				= "AirboatGunTracer"

SWEP.ClipSize 				= 2
SWEP.Damage 				= 100
SWEP.BulletCount 			= 8
SWEP.FireDelay 				= -1

SWEP.AmmoItem 				= "ammo_at"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.PumpAction 			= true
SWEP.ShotgunReload 			= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 4

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.01

SWEP.UseClumpSpread 		= true
SWEP.ClumpSpread 			= 0.06

SWEP.FireSound 				= soundscript.AddFire("PLASMA_BOSS", "tekka/weapons/plasma_boss.wav", 140)

SWEP.Animations = {
	fire = "fire1",
	reload = "open1",
	reloadfinish = "close",
	reloadinsert = "load1"
}


SWEP.HoldType 			= "revolver"
SWEP.HoldTypeLowered 	= "normal"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-1, -3, -0.5)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-6.34, -8, 1.231)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}

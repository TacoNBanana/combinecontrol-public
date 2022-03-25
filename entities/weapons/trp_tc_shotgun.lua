AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Techcom Plasma Blaster"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_shotgun.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_tc_shotgun.mdl")

SWEP.UseHands 				= true

SWEP.VMBodyGroups 			= {0}
SWEP.WMBodyGroups 			= {0}

SWEP.Tracer 				= "AirboatGunTracer"

SWEP.ClipSize 				= 6
SWEP.Damage 				= 50
SWEP.BulletCount 			= 8
SWEP.FireDelay 				= -1

SWEP.AmmoItem 				= "ammo_shotgun"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.PumpAction 			= true
SWEP.ShotgunReload 			= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 2

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.01

SWEP.UseClumpSpread 		= true
SWEP.ClumpSpread 			= 0.06

SWEP.FireSound 				= soundscript.AddFire("PLASMA_SNIPER", "tekka/weapons/plasma_sniper.wav", 140)

SWEP.Animations = {
	fire = {"base_fire_cock_1", "base_fire_cock_2"},
	reload = "base_reload_start",
	reloadfinish = "base_reload_end",
	reloadinsert = "base_reload_insert"
}

SWEP.HoldType 			= "shotgun"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(1, -1, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2.029, -3, 1)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}

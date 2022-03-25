AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Techcom Scattergun"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_turok.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_tc_turok.mdl")

SWEP.UseHands 				= true

SWEP.VMBodyGroups 			= {0}
SWEP.WMBodyGroups 			= {0}

SWEP.Tracer 				= "AirboatGunTracer"

SWEP.ClipSize 				= 6
SWEP.Damage 				= 60
SWEP.BulletCount 			= 8
SWEP.FireDelay 				= -1

SWEP.AmmoItem 				= "ammo_shotgun"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.PumpAction 			= true
SWEP.ShotgunReload 			= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_SEMI, Vars = {}},
	{Mode = FIREMODE_CANNON, Vars = {
		Automatic = true,
		Name = "Autocannon",
		Delay = 0.25,
		Clipsize = 1,
		AmmoItem = "ammo_sniper",		
		Projectile = "cc_autocannon",
		Sound = "tekka/weapons/weapon_mossberg.wav"
	}}
}

SWEP.Recoil 				= 2

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.01

SWEP.UseClumpSpread 		= true
SWEP.ClumpSpread 			= 0.04

SWEP.FireSound 				= soundscript.AddFire("WEAPON_SVT", "tekka/weapons/weapon_svt.wav", 140)

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
	pos = Vector(0, 0, -0.5)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-1.899, 0, 0.301)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}

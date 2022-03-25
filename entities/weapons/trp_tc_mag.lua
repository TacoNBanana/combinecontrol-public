AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Techcom MAG Plasma Shotgun"

SWEP.Category 				= "TRP"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.MuzzleEffect 			= "AR2Explosion"

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_mag.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_tc_mag.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "trp_laser_beam_thicc"
SWEP.LaserColor 			= COLOR_BLUE
SWEP.DoDissolve 			= true

SWEP.ClipSize 				= 12
SWEP.Damage 				= 100
SWEP.FireDelay 				= 0.5
-- needs some sort of explosive impact ....
-- + impact particle value from hl2rp swep base
-- + splash damage value
SWEP.UseClumpSpread 		= true
SWEP.ClumpSpread 			= 0.06
SWEP.BulletCount 			= 4

SWEP.AmmoItem 				= "ammo_plasma_heavy"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_SEMI, Vars = {}}
}


SWEP.Recoil 				= 0.4

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.045

SWEP.FireSound 				= soundscript.AddFire("PLASMABOSS", "tekka/weapons/plasma_boss.wav", 140)

SWEP.Animations = {
	reload = "reload",
	fire = {"fire01"}
}

SWEP.HoldType 			= "smg"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-1, -5, -1.5)
}

SWEP.AimOffset = {
	ang = Vector(0, 0.301, 0),
	pos = Vector(-6, -8, -0.5)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}

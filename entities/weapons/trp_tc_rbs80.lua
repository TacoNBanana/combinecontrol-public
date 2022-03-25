AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "General Dynamics RBS80"

SWEP.Category 				= "TRP"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_rbs80.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_rbs80.mdl")

SWEP.UseHands 				= false

SWEP.Tracer 				= "trp_laser"
SWEP.LaserColor 			= COLOR_PURPLE

SWEP.ClipSize 				= 400
SWEP.Damage 				= 30
SWEP.FireDelay 				= 0.05

SWEP.AmmoItem 				= "ammo_plasma_lmg"

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}

SWEP.UseBolt 				= true
SWEP.BoltLockOnEmpty 		= false
SWEP.BoltBone 				= "v_weapon.bolt"
SWEP.BoltOffset 			= Vector(0, 0, -8)
SWEP.BoltRecoverySpeed 		= 80

SWEP.Recoil 				= 0.5

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.03

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.FireSound 				= soundscript.AddFire("TRP_PLASMA_RECON", "tekka/weapons/plasma_recon.wav", 140)


SWEP.HoldType 			= "crossbow"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2, -12, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-4, -20, 2)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}

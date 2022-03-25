AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "SkyNet STEALTH-MODE 55Watt PPR"

SWEP.Category 				= "TRP Skynet"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_skynet_55watt_stealth.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_skynet_55watt_stealth.mdl")

SWEP.UseHands 				= false

SWEP.Tracer 				= "trp_laser_beam"
SWEP.LaserColor 			= COLOR_RED

SWEP.ClipSize 				= 30
SWEP.Damage 				= 50
SWEP.FireDelay 				= 0.12

SWEP.AmmoItem 				= "ammo_plasma"

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}},
	{Mode = FIREMODE_M203, Vars = {}},
	{Mode = FIREMODE_M203, Vars = {
		Name = "M203 Smoke",
		AmmoPool = "M203_SMOKE",
		AmmoItem = "ammo_m203_smoke",
		Projectile = "cc_m203_smoke"
	}}
}

SWEP.Recoil 				= 0.4

SWEP.PlayerBodyGroups = {
	["models/tnb/skynet/t870.mdl"] = {1}
}

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.03

SWEP.UseBolt 				= true
SWEP.BoltLockOnEmpty 		= false
SWEP.BoltBone 				= "v_weapon.bolt"
SWEP.BoltOffset 			= Vector(0, 0, -2.5)
SWEP.BoltRecoverySpeed 		= 40



SWEP.AllowThermals 			= true



SWEP.FireSound 				= soundscript.AddFire("TRP_PLASMA7", "tekka/weapons/plasma_single7.wav", 140)

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-1, -5, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-5.895, -10, 1.578)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}

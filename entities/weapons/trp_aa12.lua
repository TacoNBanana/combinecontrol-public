AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "AA12"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_aa12.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_aa12.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "AR2Tracer"

SWEP.ClipSize 				= 20
SWEP.Damage 				= 15
SWEP.BulletCount 			= 12
SWEP.FireDelay 				= 0.18

SWEP.AmmoItem 				= "ammo_shotgun"

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}

SWEP.Recoil 				= 1

SWEP.RecoilAxisMod = {
	side = 5,
	forward = 5,
	up = 2,
	pitch = 2,
	roll = 1
}

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.01

SWEP.UseClumpSpread 		= true
SWEP.ClumpSpread 			= 0.04

SWEP.UseBolt 				= true
SWEP.BoltLockOnEmpty 		= false
SWEP.BoltBone 				= "v_weapon.bolt"
SWEP.BoltOffset 			= Vector(0, 0, -8)
SWEP.BoltRecoverySpeed 		= 80

SWEP.FireSound 				= soundscript.AddFire("WEAPON_SNIPER", "tekka/weapons/weapon_sniper.wav", 140)

SWEP.Animations = {
	reload = "reload"
}

SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, -4, 0)
}

SWEP.AimOffset = {
	ang = Vector(1.3, 0, 0),
	pos = Vector(-6.346, -5, -1.374)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}

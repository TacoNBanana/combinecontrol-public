AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "M14 DMR"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_m14.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_m14.mdl")

SWEP.VMBodyGroups 			= {2}
SWEP.WMBodyGroups 			= {2}

SWEP.UseHands 				= true

SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 20
SWEP.Damage 				= 40
SWEP.FireDelay 				= 0.13

SWEP.AmmoItem 				= "ammo_rifle"

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}},
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 0.6

SWEP.RecoilAxisMod = {
	side = 1,
	forward = 5,
	up = 3,
	pitch = 2,
	roll = 1
}

SWEP.AimCone 				= 0
SWEP.HipCone 				= 0.04

SWEP.UseBolt 				= true
SWEP.BoltLockOnEmpty 		= false
SWEP.BoltBone 				= "v_weapon.bolt"
SWEP.BoltOffset 			= Vector(0, 0, -5)
SWEP.BoltRecoverySpeed 		= 80

SWEP.FireSound 				= soundscript.AddFire("WEAPON_M14", "tekka/weapons/weapon_m14.wav", 140)

if CLIENT then
	SWEP.UseRTScope 				= true
	SWEP.RTScopeFOV 				= 5 -- 5 for ACOG, 3 for long range scopes
	SWEP.RTScopeMaterialIndex 		= 6
end

SWEP.Animations = {
	reload = "reload",
	fire = {"fire1", "fire2"}
}

SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-1, -8, 1)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-6.416, -12, 1.595)
}


SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}

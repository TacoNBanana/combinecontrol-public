AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "ACR SD"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_acr.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_acr.mdl")

SWEP.VMBodyGroups 			= {1}
SWEP.WMBodyGroups 			= {1}

SWEP.UseHands 				= true

SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 20
SWEP.Damage 				= 40
SWEP.FireDelay 				= 0.08

SWEP.AmmoItem 				= "ammo_rifle"

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}},
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 1

SWEP.RecoilAxisMod = {
	side = 10,
	forward = 5,
	up = 3,
	pitch = 1,
	roll = 1
}

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.06

SWEP.UseBolt 				= true
SWEP.BoltLockOnEmpty 		= false
SWEP.BoltBone 				= "v_weapon.bolt"
SWEP.BoltOffset 			= Vector(0, 0, -4.5)
SWEP.BoltRecoverySpeed 		= 80

SWEP.FireSound 				= soundscript.AddFire("WEAPON_SILENCEDTHWACK", "tekka/weapons/weapon_silencedthwack.wav", 80)

SWEP.Animations = {
	reload = "reload"
}

SWEP.HoldType 			= "smg"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2, -4, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-6.26, -7, 0.801)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}

AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "AA12 - HE Rounds"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_aa12.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_aa12.mdl")

SWEP.VMBodyGroups 			= {1}
SWEP.WMBodyGroups 			= {1}

SWEP.UseHands 				= true

SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 20
SWEP.Damage 				= 500
SWEP.FireDelay 				= 0.18

SWEP.AmmoItem 				= "ammo_shotgun"

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_CANNON, Vars = {
		Automatic = true,
		Name = "Autocannon",
		Delay = 0.18,
		Clipsize = 20,
		Projectile = "cc_autocannon",
		Sound = "tekka/weapons/weapon_canon.wav"
	}},
	{Mode = FIREMODE_M203, Vars = {ClipSize = 20, Radius = 100}}
}

SWEP.Recoil 				= 1

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.05

SWEP.UseBolt 				= true
SWEP.BoltLockOnEmpty 		= false
SWEP.BoltBone 				= "v_weapon.bolt"
SWEP.BoltOffset 			= Vector(0, 0, -8)
SWEP.BoltRecoverySpeed 		= 80

SWEP.FireSound 				= soundscript.AddFire("WEAPON_MGTHUD", "tekka/weapons/weapon_mgthud.wav", 140)

SWEP.Animations = {
	reload = "reload"
}

SWEP.HoldType 			= "smg"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2, -7, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-6.3, -15, 0.051)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}

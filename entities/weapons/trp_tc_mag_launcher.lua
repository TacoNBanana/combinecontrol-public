AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Techcom MAG AutoLauncher"

SWEP.Category 				= "TRP"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_mag.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_tc_mag.mdl")

SWEP.UseHands 				= true

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.ClipSize 				= 12
SWEP.AmmoItem 				= "ammo_shotgun"

SWEP.Firemodes 				= {
	{Mode = FIREMODE_CANNON, Vars = {
		Automatic = true,
		Name = "Autocannon",
		Delay = 0.2,
		Projectile = "cc_autocannon",
		Sound = "tekka/weapons/weapon_gut.wav"
	}}
}

SWEP.Recoil 				= 0.5

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.03

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


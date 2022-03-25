AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "T-300 AA Gun"

SWEP.Category 				= "TRP Skynet"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true
SWEP.DrawCrosshair 			= false
SWEP.ViewModel 				= Model("models/tnb/weapons/c_m2.mdl")
SWEP.WorldModel 			= ""

SWEP.UseHands 				= false

SWEP.Damage 				= 180
SWEP.FireDelay 				= 0.12

SWEP.Tracer 				= "trp_minitracer"

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= false

SWEP.Firemodes 				= {
	{Mode = FIREMODE_CANNON, Vars = {
		Automatic = true,
		Name = "T-300 AA-Gun",
		Delay = 0.12,
		Projectile = "cc_autocannon",
		Sound = "tekka/weapons/weapon_m203_smoke.wav"
	}}
}

SWEP.Recoil 				= 0.5

SWEP.VMBodyGroups 			= {1}


SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.03

SWEP.FireSound 				= soundscript.AddFire("WEAPON_MAGNETIC", "tekka/weapons/weapon_magnetic.wav", 140)

if CLIENT then
	SWEP.UseAimpoint 			= true
	SWEP.AimpointMaterial 		= Material("models/tnb/trpweapons/reticule_square")
	SWEP.AimpointColor 			= Color(255, 0, 0, 255)
	SWEP.AimpointSize 			= 20
end

SWEP.Animations = {
	reload = "reload",
	fire = {"fire1", "fire2"}
}

SWEP.HoldType 			= "normal"
SWEP.HoldTypeLowered 	= "normal"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(5, -15, -4)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(2, -17, -2)
}

SWEP.LoweredOffset = {
	ang = Vector(-10, 0, 0),
	pos = Vector(0, 0, 0)
}

SWEP.PlayerBodyGroups = {
	["models/tnb/skynet/t300.mdl"] = {0, 0},
}


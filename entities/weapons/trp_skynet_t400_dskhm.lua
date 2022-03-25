AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "T-400 Dual DSHKm"

SWEP.Category 				= "TRP Skynet"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_dshkm_akimbo.mdl")
SWEP.WorldModel 			= ""

SWEP.UseHands 				= false

SWEP.Damage 				= 80
SWEP.FireDelay 				= 0.08

SWEP.Tracer 				= "trp_minitracer_t400"

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= false

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}

SWEP.Recoil 				= 0.5



SWEP.AimCone 				= 0.005
SWEP.HipCone 				= 0.045

SWEP.FireSound 				= soundscript.AddFire("WEAPON_SNIPER", "tekka/weapons/weapon_sniper.wav", 140)

if CLIENT then
	SWEP.UseAimpoint 			= true
	SWEP.AimpointMaterial 		= Material("reticles/eotech_reddot")
	SWEP.AimpointColor 			= Color(255, 0, 0, 255)
	SWEP.AimpointSize 			= 3
end

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot_left2", "shoot_right2"}
}

SWEP.HoldType 			= "normal"
SWEP.HoldTypeLowered 	= "normal"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, -8, -5)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, -10, -3)
}

SWEP.LoweredOffset = {
	ang = Vector(-10, 0, 0),
	pos = Vector(0, 0, 0)
}

SWEP.PlayerBodyGroups = {
	["models/tnb/skynet/t400.mdl"] = {4},
	["models/tnb/skynet/t400_repro.mdl"] = {4}
}
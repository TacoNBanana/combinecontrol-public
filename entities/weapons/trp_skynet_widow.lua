AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "T-70 Widow"

SWEP.Category 				= "TRP Skynet"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_65watt.mdl")
SWEP.WorldModel 			= ""

SWEP.UseHands 				= false

SWEP.Damage 				= 20
SWEP.FireDelay 				= 0.1

SWEP.Tracer 				= "trp_laser"
SWEP.LaserColor 			= COLOR_PURPLE

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}

SWEP.Recoil 				= 0.1

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.045

SWEP.FireSound 				= soundscript.AddFire("TEKKA_BURSTSMALL", "tekka/weapons/weapon_burstsmall.wav", 100)

if CLIENT then
	SWEP.UseAimpoint 			= true
	SWEP.AimpointMaterial 		= Material("models/tnb/trpweapons/reticule_square")
	SWEP.AimpointColor 			= Color(255, 0, 0, 255)
	SWEP.AimpointSize 			= 8
end

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot", "shoot2"}
}

SWEP.HoldType 			= "normal"
SWEP.HoldTypeLowered 	= "normal"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 30),
	pos = Vector(-16, -12, 6)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 30),
	pos = Vector(-16, -12, 6)
}

SWEP.LoweredOffset = {
	ang = Vector(15, 0, 30),
	pos = Vector(-16, -12, 6)
}


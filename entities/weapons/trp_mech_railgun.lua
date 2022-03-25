AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "APU - Shoulder-mounted Railgun"

SWEP.Category 				= "TRP Exo Weapons"
SWEP.Plasma 				= true

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_70watt.mdl")
SWEP.WorldModel 			= ""

SWEP.UseHands 				= false

SWEP.Tracer 				= "trp_laser"
SWEP.LaserColor 			= COLOR_GREEN
SWEP.DoDissolve 			= true
SWEP.Damage 				= 500
SWEP.FireDelay 				= 1.5


SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 4

SWEP.AimCone 				= 0.001
SWEP.HipCone 				= 0.02


if CLIENT then
	SWEP.UseAimpoint 			= true
	SWEP.AimpointMaterial 		= Material("models/tnb/trpweapons/reticule_square")
	SWEP.AimpointColor 			= Color(255, 0, 0, 255)
	SWEP.AimpointSize 			= 8
end

SWEP.FireSound 				= soundscript.AddFire("TRP_LASERHEAVY", "tekka/weapons/weapon_laser_heavy.wav", 140)

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2", "shoot3"}
}

SWEP.HoldType 			= "normal"
SWEP.HoldTypeLowered 	= "normal"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-14, -18, 7)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-14, -17, 7)
}

SWEP.LoweredOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-16, -20, 9)
}

AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "APU - Defender Plasma Weapon"

SWEP.Category 				= "TRP Exo Weapons"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_75watt.mdl")
SWEP.WorldModel 			= ""

SWEP.UseHands 				= false

SWEP.Tracer 				= "trp_laser_beam_thicc"
SWEP.LaserColor 			= COLOR_BLUE
SWEP.DoDissolve 			= true
SWEP.ClipSize 				= 100
SWEP.Damage 				= 70
SWEP.FireDelay 				= 0.05

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}},
	{Mode = FIREMODE_BURST3, Vars = {}}
}

SWEP.Recoil 				= 0.5

if CLIENT then
	SWEP.UseAimpoint 			= true
	SWEP.AimpointMaterial 		= Material("models/tnb/trpweapons/reticule_square")
	SWEP.AimpointColor 			= Color(255, 0, 0, 255)
	SWEP.AimpointSize 			= 10
end

SWEP.AimCone 				= 0.0001
SWEP.HipCone 				= 0.04

SWEP.FireSound 				= soundscript.AddFire("TRP_SINGLE7", "tekka/weapons/plasma_single7.wav", 80)


SWEP.HoldType 			= "normal"
SWEP.HoldTypeLowered 	= "normal"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(3, -12, 6)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(1, -15, 6)
}

SWEP.LoweredOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(3, -12, 6)
}

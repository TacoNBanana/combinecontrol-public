AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "T-300 Plasma Canons"

SWEP.Category 				= "TRP Skynet"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_75watt.mdl")
SWEP.WorldModel 			= ""

SWEP.UseHands 				= false

SWEP.Tracer 				= "trp_laser_beam_thicc"
SWEP.LaserColor 			= COLOR_BLUE

SWEP.Damage 				= 80
SWEP.FireDelay 				= 0.18
SWEP.DoDissolve 			= true

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
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
	SWEP.AimpointSize 			= 22
end

SWEP.PlayerBodyGroups = {
	["models/tnb/skynet/t300.mdl"] = {1, 1},
	["models/tnb/skynet/t300_new.mdl"] = {1, 1},	
}

SWEP.AimCone 				= 0.005
SWEP.HipCone 				= 0.04

SWEP.FireSound 				= soundscript.AddFire("PLASMSNIPER", "tekka/weapons/plasma_sniper.wav", 140)


SWEP.HoldType 			= "normal"
SWEP.HoldTypeLowered 	= "normal"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-1, -15, 2)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2, -18, 3)
}

SWEP.LoweredOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-1, -14, 2)
}

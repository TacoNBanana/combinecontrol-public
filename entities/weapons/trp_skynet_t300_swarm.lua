AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "T-300 SWARM Launcher"

SWEP.Category 				= "TRP Skynet"

SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_100watt.mdl")
SWEP.WorldModel 			= ""

SWEP.ClipSize 				= 20
SWEP.Damage 				= 300
SWEP.FireDelay 				= 0.18

SWEP.UseHands 				= false
SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_RPG, Vars = {
		Name = "SWARM Missile",
		Projectile = "cc_rpg_weak",
		ClipSize 	= 9,
		Delay 		= 0.18,		
		Automatic 	= true
	}}
}

SWEP.Recoil 				= 0

SWEP.PlayerBodyGroups = {
	["models/tnb/skynet/t300.mdl"] = {0, 0},
}


if CLIENT then
	SWEP.UseAimpoint 			= true
	SWEP.AimpointMaterial 		= Material("models/tnb/trpweapons/reticule_square")
	SWEP.AimpointColor 			= Color(255, 0, 0, 255)
	SWEP.AimpointSize 			= 22
end

SWEP.AimCone 				= 0.9
SWEP.HipCone 				= 1.2

SWEP.FireSound 				= soundscript.AddFire("TRP_SMOKE", "tekka/weapons/weapon_m203_smoke.wav", 140)

SWEP.HoldType 				= "normal"
SWEP.HoldTypeLowered 		= "normal"

SWEP.Animations = {
	reload = "reload",
	fire = {"fire1", "fire2"}
}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-20, -15, 5)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-18, -18, 4)
}

SWEP.LoweredOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-20, -13, 5)
}
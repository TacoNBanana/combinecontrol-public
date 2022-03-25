AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "T-400 Rocket Launcher"

SWEP.Category 				= "TRP Skynet"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_skynet_rocketlauncher.mdl")
SWEP.WorldModel 			= ""

SWEP.UseHands 				= false

SWEP.FireDelay 				= 1

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_RPG, Vars = {
		ClipSize = -1,
		Projectile = "cc_rpg_weak"
	}}
}

SWEP.Recoil 				= 1
SWEP.VMRecoilMod 			= 5

SWEP.FireSound 				= soundscript.AddFire("TRP_RPG", "tekka/weapons/weapon_rpg.wav", 140)

if CLIENT then
	SWEP.UseAimpoint 			= true
	SWEP.AimpointMaterial 		= Material("models/tnb/trpweapons/reticule_square")
	SWEP.AimpointColor 			= Color(255, 0, 0, 255)
	SWEP.AimpointSize 			= 14
end

SWEP.HoldType 				= "rpg"

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, 0, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, -2, 1)
}

SWEP.LoweredOffset = {
	ang = Vector(-20, 10, 10),
	pos = Vector(0, 0, 5)
}

SWEP.PlayerBodyGroups = {
	["models/tnb/skynet/t400.mdl"] = {2},
	["models/tnb/skynet/t400_repro.mdl"] = {2}
}
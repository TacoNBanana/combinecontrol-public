AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Exoskeleton Right Shoulder: SWARM Launcher"

SWEP.Category 				= "TRP Exo Weapons"

SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_exo_rocketlauncher.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_exo_rocketlauncher.mdl")

SWEP.ClipSize 				= 20
SWEP.Damage 				= 300
SWEP.FireDelay 				= 0.2

SWEP.UseHands 				= false
SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_RPG, Vars = {
		Name = "SWARM Missile",
		Projectile = "cc_rpg_swarm",
		ClipSize = 20,
		Automatic = true
	}}
}

SWEP.Recoil 				= 1

if CLIENT then
	SWEP.UseAimpoint 			= true
	SWEP.AimpointMaterial 		= Material("models/tnb/trpweapons/reticule_square")
	SWEP.AimpointColor 			= Color(255, 0, 0, 255)
	SWEP.AimpointSize 			= 8
end

SWEP.AimCone 				= 0.9
SWEP.HipCone 				= 1.2

--SWEP.FireSound 				= soundscript.AddFire("TRP_RPG", "tekka/weapons/weapon_launcher.wav", 140)

SWEP.HoldType 				= "slam"
SWEP.HoldTypeLowered 		= "slam"

SWEP.Animations = {
	reload = "reload",
	fire = {"fire1", "fire2"}
}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, 0, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, 0, 0)
}

SWEP.LoweredOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, 0, 0)
}
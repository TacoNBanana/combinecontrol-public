AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Exoskeleton Left Arm: M203 Launcher"

SWEP.Category 				= "TRP Exo Weapons"

SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_exo_m203.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_exo_minigun.mdl")

SWEP.Damage 				= 500
SWEP.FireDelay 				= -1

SWEP.UseHands 				= false
SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_M203, Vars = {ClipSize = -1}},
	{Mode = FIREMODE_M203, Vars = {
		Name = "M203 Smoke",
		ClipSize = -1,
		AmmoPool = "M203_SMOKE",
		AmmoItem = "ammo_m203_smoke",
		Projectile = "cc_m203_smoke"
	}}
}

SWEP.Recoil 				= 1

if CLIENT then
	SWEP.UseAimpoint 			= true
	SWEP.AimpointMaterial 		= Material("models/tnb/trpweapons/reticule_square")
	SWEP.AimpointColor 			= Color(255, 0, 0, 255)
	SWEP.AimpointSize 			= 8
end

SWEP.AimCone 				= 0.02
SWEP.HipCone 				= 0.035

SWEP.FireSound 				= soundscript.AddFire("TRP_RPG", "tekka/weapons/weapon_launcher.wav", 140)

SWEP.HoldType 				= "duel"
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
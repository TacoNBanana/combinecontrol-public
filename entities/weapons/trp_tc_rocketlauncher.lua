AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Tech-Com Tactical Missile Launcher"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_rocketlauncher.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_tc_rocketlauncher.mdl")

SWEP.ClipSize 				= 1
SWEP.Damage 				= 1500
SWEP.FireDelay 				= -1

SWEP.AmmoItem 				= "ammo_rpg"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_RPG, Vars = {
		Name = "Tactical Missile",
		Projectile = "cc_rpg_tactical",
	}}
}

SWEP.AllowThermals 			= true

if CLIENT then
	SWEP.UseRTScope 				= true
	SWEP.RTScopeFOV 				= 5 -- 5 for ACOG, 3 for long range scopes
	SWEP.RTScopeMaterialIndex 		= 1
	SWEP.RTScopeReticle 			= true
end

SWEP.Recoil 				= 1
SWEP.VMRecoilMod 			= 5


SWEP.AimCone 				= 0.02
SWEP.HipCone 				= 0.035

SWEP.FireSound 				= soundscript.AddFire("TRP_RPG2", "tekka/weapons/weapon_m203_smoke.wav", 140)

SWEP.HoldType 				= "camera"

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(3, 0, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-0.55, -9, 3.701)
}

SWEP.LoweredOffset = {
	ang = Vector(-20, 10, 10),
	pos = Vector(0, 0, 5)
}

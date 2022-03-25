AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "AKM with Airburst Mod"

SWEP.Category 				= "TRP"
SWEP.Plasma 				= false
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_akm_elysium.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_akm_elysium.mdl")

SWEP.UseHands 				= true
SWEP.MuzzleEffect 			= "CS_MuzzleFlash_X"
SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 30
SWEP.Damage 				= 100
SWEP.FireDelay 				= 0.1

SWEP.AmmoItem 				= "ammo_rifle"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_CANNON, Vars = {
		Automatic = true,
		Name = "Airburst Mod",
		Delay = 0.1,
		Projectile = "cc_autocannon_mini",
		Sound = "tekka/weapons/weapon_aks.wav"
	}}
}

SWEP.Recoil 				= 1

SWEP.AimCone 				= 0.02
SWEP.HipCone 				= 0.06

SWEP.FireSound 				= soundscript.AddFire("WEAPON_AKS", "tekka/weapons/weapon_aks.wav", 140)

SWEP.Animations = {
	reload = "base_reload_empty",
	fire = {"base_fire", "iron_fire"}
}

SWEP.HoldType 			= "rpg"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-0, 0, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2.859, -9, -0.649)
}

SWEP.LoweredOffset = {
	ang = Vector(-6, 0, 0),
	pos = Vector(0, 0, 0)
}

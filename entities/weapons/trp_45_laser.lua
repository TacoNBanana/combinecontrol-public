AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Colt .45 Longslide with Laser Sight"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.MuzzleEffect 			= "CS_MuzzleFlash_X"

SWEP.ViewModel 				= Model("models/tnb/weapons/c_45.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_45.mdl")

SWEP.VMBodyGroups 			= {1}
SWEP.WMBodyGroups 			= {1}

SWEP.VMSubMaterials 		= {
	[3] = true,
	[4] = true
}

SWEP.UseHands 				= true

SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 8
SWEP.Damage 				= 70
SWEP.FireDelay 				= 0.1

SWEP.AmmoItem 				= "ammo_pistol"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 0.4


SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.04

if CLIENT then
	SWEP.VElements 	= {
		["laser"] = {Type = SCK_LASER, Bone = "v_weapon.p228_parent", Pos = Vector(0.1, -5.29, -7), Ang = Angle(-90, 90, 0), Color = Color(255, 0, 0), Line = 0.5, Dot = 0.2}
	}
end

SWEP.FireSound 				= soundscript.AddFire("WEAPON_K98", "tekka/weapons/weapon_k98.wav", 140)

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}


SWEP.HoldType 			= "revolver"
SWEP.HoldTypeLowered 	= "normal"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, -8, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-3.025, -10, 1.786)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}

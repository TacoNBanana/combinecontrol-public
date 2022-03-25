AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Techcom Syndicate TAR"

SWEP.Category 				= "TRP"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_syndicate.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_tc_syndicate.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "trp_laser"
SWEP.LaserColor 			= COLOR_RED

SWEP.ClipSize 				= 50
SWEP.Damage 				= 60
SWEP.FireDelay 				= 0.08

SWEP.AmmoItem 				= "ammo_plasma"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}},
	{Mode = FIREMODE_M203, Vars = {}},
	{Mode = FIREMODE_MASTERKEY, Vars = {}},
	{Mode = FIREMODE_MASTERKEY, Vars = {Name = "Underslung Slugs", Damage = 200, Count = 1, Spread = 0}}	
}

if CLIENT then
	SWEP.UseAimpoint 			= true
	SWEP.AimpointMaterial 		= Material("models/tnb/trpweapons/reticule_square")
	SWEP.AimpointColor 			= Color(255, 0, 0, 255)
	SWEP.AimpointSize 			= 14
end

SWEP.Recoil 				= 0.2

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.045

SWEP.FireSound 				= soundscript.AddFire("TRP_PLASMA_RECON", "tekka/weapons/plasma_recon.wav", 140)

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2", "shoot3"}
}

SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2, -10, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-6.48, -15, 0.561)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}

AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Techcom CBR Prototype"

SWEP.Category 				= "TRP"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_mag.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_tc_mag.mdl")

SWEP.VMBodyGroups 			= {1}
SWEP.WMBodyGroups 			= {1}

SWEP.UseHands 				= true

SWEP.Tracer 				= "trp_beam"

SWEP.ClipSize 				= -1
SWEP.Damage 				= 15
SWEP.FireDelay 				= 0.02

SWEP.AmmoItem 				= "ammo_plasma"

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}

SWEP.Recoil 				= 0.1

SWEP.AimCone 				= 0
SWEP.HipCone 				= 0

SWEP.UseClumpSpread 		= true
SWEP.ClumpSpread 			= 0.005

SWEP.FireSound 				= ""

SWEP.LoopSounds = {
	loop = "ambient/energy/force_field_loop1.wav"
}

SWEP.Animations = {
	reload = "reload",
	fire = {"fire01"}
}

SWEP.HoldType 			= "smg"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-1, -5, -1.5)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-6.156, -8, -0.978)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}

function SWEP:FireAnimationEvent(pos, ang, event, name)
	return true
end

function SWEP:DoImpactEffect()
	return true
end
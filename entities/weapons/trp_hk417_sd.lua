AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "HK417 SD"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_hk416.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_hk416.mdl")

SWEP.VMBodyGroups 			= {4}
SWEP.WMBodyGroups 			= {4}

SWEP.UseHands 				= true

SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 20
SWEP.Damage 				= 40
SWEP.FireDelay 				= 0.1

SWEP.AmmoItem 				= "ammo_rifle"

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}},
	{Mode = FIREMODE_SEMI, Vars = {}},
}

SWEP.Recoil 				= 0.6

SWEP.RecoilAxisMod = {
	side = 20,
	forward = 10,
	up = 3,
	pitch = 2,
	roll = 1
}

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.03

SWEP.FireSound 				= soundscript.AddFire("WEAPON_SILENCEDSMG", "tekka/weapons/weapon_silencedsmg.wav", 80)

if CLIENT then
	SWEP.UseRTScope 				= true
	SWEP.RTScopeFOV 				= 6 -- 5 for ACOG, 3 for long range scopes
	SWEP.RTScopeSCKIndex 			= "scope"

	SWEP.VElements = {
		["scope"] = {Type = SCK_MODEL, mdl = "models/XQM/panel360.mdl", Bone = "v_weapon.sg550_Parent", Pos = Vector(-0.03, -8.58, 1.4), Ang = Angle(-90, -90, 0), Size = Vector(0.02, 0.027, 0.027)},
	}

	SWEP.WElements = {}
	SWEP.VMBoneMods = {}
end

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot", "shoot2"}
}

SWEP.HoldType 			= "smg"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2, -8, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-7.36, -10, 0.84)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}

AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "SkyNet 90-Watt Plasma Canon"

SWEP.Category 				= "TRP Skynet"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_skynet_90watt.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_skynet_90watt.mdl")

SWEP.VMBodyGroups 			= {0}
SWEP.WMBodyGroups 			= {0}

SWEP.UseHands 				= false

SWEP.Tracer 				= "trp_laser_beam"
SWEP.LaserColor 			= COLOR_RED

SWEP.ClipSize 				= 200
SWEP.Damage 				= 30
SWEP.FireDelay 				= 0.07

SWEP.UseClumpSpread 		= true
SWEP.ClumpSpread 			= 0.02
SWEP.BulletCount 			= 3

SWEP.AmmoItem 				= "ammo_plasma_lmg"
SWEP.DoDissolve 			= true

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}

SWEP.Recoil 				= 0

SWEP.AimCone 				= 0.001
SWEP.HipCone 				= 0.02

SWEP.FireSound 				= soundscript.AddFire("TRP_PLASMARIFLE1", "tekka/weapons/plasma_rifle1.wav", 140)


SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

if CLIENT then
	SWEP.UseAimpoint 			= true
	SWEP.AimpointMaterial 		= Material("models/tnb/trpweapons/reticule_square")
	SWEP.AimpointColor 			= Color(0, 255, 0, 255)
	SWEP.AimpointSize 			= 8
end

SWEP.HoldType 			= "duel"
SWEP.HoldTypeLowered 	= "slam"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-1, 7, 3)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-5, -5, 5)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}

if CLIENT then
	function SWEP:Think()
		self.BaseClass.Think(self)

		if self.Owner:KeyDown(IN_ATTACK) and self:CanFire() then
			ang = Angle(0, 0, -5)
			ang:RotateAroundAxis(Vector(0, 1, 0), CurTime() * 2000)
			ang:RotateAroundAxis(Vector(1, 0, 0), 5)

			self.VM:ManipulateBoneAngles(2, ang)
		end
	end
end

SWEP.PlayerBodyGroups = {
	["models/tnb/skynet/t800.mdl"] = {1, 0},
	["models/tnb/skynet/t700.mdl"] = {1, 0},
	["models/tnb/skynet/t700_repro.mdl"] = {1, 0},
	["models/tnb/skynet/t600.mdl"] = {2, 0},
	["models/tnb/skynet/t600_skinjob.mdl"] = {3, 0},
	["models/tnb/skynet/t600_repro.mdl"] = {2, 0}
}
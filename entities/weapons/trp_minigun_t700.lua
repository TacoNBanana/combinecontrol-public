AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "T-700 Minigun"

SWEP.Category 				= "TRP Skynet"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_minigun_3.mdl")
SWEP.WorldModel 			= ""

SWEP.UseHands 				= true

SWEP.Damage 				= 30
SWEP.FireDelay 				= 0.07

SWEP.Tracer 				= "trp_minitracer"
SWEP.AttachmentOverride 	= "minigun"

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}

SWEP.Recoil 				= 0.5



SWEP.AimCone 				= 0.04
SWEP.HipCone 				= 0.08

SWEP.FireSound 				= soundscript.AddFire("TRP_CHAINGUN", "tekka/weapons/weapon_chaingun.wav", 140)

if CLIENT then
	SWEP.UseAimpoint 			= true
	SWEP.AimpointMaterial 		= Material("models/tnb/trpweapons/reticule_square")
	SWEP.AimpointColor 			= Color(255, 0, 0, 255)
	SWEP.AimpointSize 			= 8
end

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.HoldType 			= "revolver"
SWEP.HoldTypeLowered 	= "normal"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 2.5, 0),
	pos = Vector(0, 0, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2.687, 0, 4.158)
}

SWEP.LoweredOffset = {
	ang = Vector(-10, 0, 0),
	pos = Vector(0, 0, 0)
}

SWEP.PlayerBodyGroups = {
	["models/tnb/skynet/t700.mdl"] = {1, 1},
	["models/tnb/skynet/t700_repro.mdl"] = {1, 1}	
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
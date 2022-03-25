AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "Pattern 29 SCDW"
SWEP.Category 			= "TRP - AOF"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/weapons/arccw/c_bo2_scorpion.mdl")
SWEP.WorldModel 		= Model("models/weapons/arccw/w_bo2_scorpion.mdl")

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {}

SWEP.ActiveHoldType 	= "ar2"
SWEP.PassiveHoldType 	= "passive"

SWEP.Firemodes 			= {-1, 3, 0}

SWEP.AmmoType 			= "ammo_pistol"
SWEP.Durability 		= {6000, 8000}
SWEP.JamTypes 			= {
	Rate = 60 / 850,
	Sear = 10,
	Malfunction = 150
}

SWEP.ClipSize 			= 30
SWEP.Delay 				= 60 / 1150

SWEP.Damage 			= 16

SWEP.CrouchingAccuracy 	= {util.RangeMeters(10), util.RangeMeters(45)}
SWEP.StandingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(35)}

SWEP.AimTime 			= 0.4
SWEP.ZoomLevel 			= 1.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 1

SWEP.FireSound 			= "ArcCW_BO2.EVO3_Fire"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, 0, -0.5),
		Ang = Angle(0, 0, 0)
	},
	Holster = {
		Pos = Vector(0, -6, 0),
		Ang = Angle(10, 40, 0)
	},
	Sprint = {
		Pos = Vector(0, 0, 1),
		Ang = Angle(15, 5, 0)
	},
	Aim = {
		Pos = Vector(0, 1, 1),
		Ang = Angle(0, 0, 0)
	}
}

SWEP.AnimReplacements = {
	[ACT_VM_PRIMARYATTACK] = "fire",
	[ACT_VM_RELOAD] = "reload",
	[ACT_VM_RELOAD_EMPTY] = "reload_empty"
}

SWEP.AnimEmptySupport = table.MakeAssociative({
	ACT_VM_RELOAD
})

SWEP.FixWorldModel = {
	ang = Angle(-1, -10, 178),
	pos = Vector(-6, 4, -6),
	scale = 1
}

function SWEP:Deploy()
	BaseClass.Deploy(self)

	if CLIENT then
		self:EmitSound("Universal.Draw")
	end
end

function SWEP:FireAnimationEvent(_, _, event)
	if CLIENT and (LocalPlayer() != self:GetOwner() or LocalPlayer():ShouldDrawLocalPlayer()) then
		return true
	end
end

if CLIENT then
	function SWEP:DoSoundUpdate(sequence, last, time)
		if sequence == "reload" then
			if math.InRange(16 / 30, last, time) then self:EmitSound("ArcCW_BO1.Kiparis_MagOut") end
			if math.InRange(47 / 30, last, time) then self:EmitSound("ArcCW_BO1.Kiparis_MagIn") end
		elseif sequence == "reload_empty" then
			if math.InRange(16 / 30, last, time) then self:EmitSound("ArcCW_BO1.Kiparis_MagOut") end
			if math.InRange(47 / 30, last, time) then self:EmitSound("ArcCW_BO1.Kiparis_MagIn") end
			if math.InRange(65 / 30, last, time) then self:EmitSound("ArcCW_BO2.AR_Fwd") end
		end
	end
end

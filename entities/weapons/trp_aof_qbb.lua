AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "Pattern 46 LSW"
SWEP.Category 			= "TRP - AOF"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/weapons/arccw/c_bo2_qbb.mdl")
SWEP.WorldModel 		= Model("models/weapons/arccw/w_bo2_qbb.mdl")

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {}

SWEP.ActiveHoldType 	= "ar2"
SWEP.PassiveHoldType 	= "passive"

SWEP.Firemodes 			= -1

SWEP.AmmoType 			= "ammo_lmg"
SWEP.Durability 		= {10000, 12000}
SWEP.JamTypes 			= {
	Rate = 60 / 550,
	Sear = 30
}

SWEP.ClipSize 			= 75
SWEP.Delay 				= 60 / 650

SWEP.Damage 			= 22

SWEP.CrouchingAccuracy 	= {util.RangeMeters(10), util.RangeMeters(45)}
SWEP.StandingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(35)}

SWEP.AimTime 			= 0.5
SWEP.ZoomLevel 			= 1.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 0.75

SWEP.FireSound 			= "ArcCW_BO2.QBB_Fire"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, -1, -1),
		Ang = Angle(0, 0, 0)
	},
	Holster = {
		Pos = Vector(0, -5, 0),
		Ang = Angle(10, 40, 0)
	},
	Sprint = {
		Pos = Vector(0, 0, 0),
		Ang = Angle(15, 5, 0)
	},
	Aim = {
		Pos = Vector(0, 0.5, 0.5),
		Ang = Angle(0, 0, 0)
	}
}

SWEP.AnimReplacements = {
	[ACT_VM_IDLE] = "idle",
	[ACT_VM_PRIMARYATTACK] = "fire",
	[ACT_VM_RELOAD] = "reload",
	[ACT_VM_RELOAD_EMPTY] = "reload_empty"
}

SWEP.AnimEmptySupport = table.MakeAssociative({
	ACT_VM_RELOAD
})

SWEP.FixWorldModel = {
	ang = Angle(-1, -10, 178),
	pos = Vector(-8, 3, -6),
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
			if math.InRange(0.3, last, time) then self:EmitSound("ArcCW_BO1.RPK_MagOut") end
			if math.InRange(1.95, last, time) then self:EmitSound("ArcCW_BO1.RPK_Futz") end
			if math.InRange(2.4, last, time) then self:EmitSound("ArcCW_BO1.RPK_MagIn") end
		elseif sequence == "reload_empty" then
			if math.InRange(0.3, last, time) then self:EmitSound("ArcCW_BO1.RPK_MagOut") end
			if math.InRange(1.95, last, time) then self:EmitSound("ArcCW_BO1.RPK_Futz") end
			if math.InRange(2.4, last, time) then self:EmitSound("ArcCW_BO1.RPK_MagIn") end
			if math.InRange(2.8, last, time) then self:EmitSound("ArcCW_BO2.LMG_Back") end
			if math.InRange(3, last, time) then self:EmitSound("ArcCW_BO2.LMG_Fwd") end
		end
	end
end

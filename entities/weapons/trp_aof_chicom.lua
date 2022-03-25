AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "Pattern 19 CMP"
SWEP.Category 			= "TRP - AOF"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/weapons/arccw/c_bo2_chicom.mdl")
SWEP.WorldModel 		= Model("models/weapons/arccw/w_bo2_chicom.mdl")

SWEP.Bodygroups 		= {
	["3"] = 2
}
SWEP.SubMaterials 		= {}

SWEP.ActiveHoldType 	= "pistol"
SWEP.PassiveHoldType 	= "normal"

SWEP.Firemodes 			= {3, 0}
SWEP.AutoBurst 			= 0.2

SWEP.AmmoType 			= "ammo_pistol"
SWEP.Durability 		= {6000, 8000}
SWEP.JamTypes 			= {
	Rate = 60 / 850,
	Sear = 10,
	Malfunction = 150
}

SWEP.ClipSize 			= 30
SWEP.Delay 				= 60 / 900

SWEP.Damage 			= 16

SWEP.CrouchingAccuracy 	= {util.RangeMeters(10), util.RangeMeters(35)}
SWEP.StandingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(25)}

SWEP.AimTime 			= 0.4
SWEP.ZoomLevel 			= 1.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 1

SWEP.FireSound 			= "ArcCW_BO2.Chicom_Fire"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, 0, -0.5),
		Ang = Angle(0, 0, 0)
	},
	Holster = {
		Pos = Vector(0, -4, 0),
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
			if math.InRange(65 / 30, last, time) then self:EmitSound("ArcCW_BO1.Kiparis_Bolt") end
		end
	end
end

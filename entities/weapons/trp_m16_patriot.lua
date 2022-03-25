AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "M16 'Patriot'"
SWEP.Category 			= "TRP - Rifles"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/weapons/arccw/c_ud_m16.mdl")
SWEP.WorldModel 		= Model("models/weapons/arccw/c_ud_m16.mdl")

SWEP.Bodygroups 		= {
	["2"] = 4,
	["4"] = 1,
	["5"] = 6,
	["6"] = 5,
	["7"] = 2
}
SWEP.FixBodygroups 		= true
SWEP.SubMaterials 		= {}

SWEP.ActiveHoldType 	= "ar2"
SWEP.PassiveHoldType 	= "passive"

SWEP.Firemodes 			= -1

SWEP.AmmoType 			= "ammo_rifle"
SWEP.Durability 		= {6000, 8000}
SWEP.JamTypes 			= {
	Rate = 60 / 850,
	Sear = 10,
	Malfunction = 150
}

SWEP.ClipSize 			= 100
SWEP.Delay 				= 60 / 1200

SWEP.Damage 			= 16

SWEP.CrouchingAccuracy 	= {util.RangeMeters(4), util.RangeMeters(15)}
SWEP.StandingAccuracy 	= {util.RangeMeters(3), util.RangeMeters(10)}

SWEP.AimTime 			= 0.3
SWEP.ZoomLevel 			= 1.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 1.5

SWEP.FireSound 			= "UD.M16.Fire"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, 0, -1),
		Ang = Angle(0, 0, 0)
	},
	Holster = {
		Pos = Vector(0, -5, 0.5),
		Ang = Angle(15, 40, 0)
	},
	Sprint = {
		Pos = Vector(0, 0.5, 1),
		Ang = Angle(15, 10, 0)
	},
	Aim = {
		Pos = Vector(0, 1, 0.9),
		Ang = Angle(0, 0, 0)
	}
}

SWEP.AnimReplacements = {
	[ACT_VM_DRAW] = "draw",
	[ACT_VM_DRAW_EMPTY] = "draw_empty",
	[ACT_VM_IDLE] = "idle",
	[ACT_VM_IDLE_EMPTY] = "idle_empty",
	[ACT_VM_PRIMARYATTACK] = "fire",
	[ACT_VM_PRIMARYATTACK_EMPTY] = "fire_empty",
	[ACT_VM_RELOAD] = "reload_100",
	[ACT_VM_RELOAD_EMPTY] = "reload_empty_100"
}

SWEP.AnimEmptySupport = table.MakeAssociative({
	ACT_VM_DRAW, ACT_VM_IDLE, ACT_VM_PRIMARYATTACK, ACT_VM_RELOAD
})

SWEP.FixWorldModel = {
	ang = Angle(-1, -10, 178),
	pos = Vector(-8, 4, -6.5),
	scale = 1
}

function SWEP:FireAnimationEvent(_, _, event)
	if CLIENT and (LocalPlayer() != self:GetOwner() or LocalPlayer():ShouldDrawLocalPlayer()) then
		return true
	end
end

if CLIENT then
	function SWEP:DoSoundUpdate(sequence, last, time)
		if sequence == "draw" or sequence == "draw_empty" then
			if math.InRange(0, last, time) then self:EmitSound("UD.Common.Raise") end
			if math.InRange(0.15, last, time) then self:EmitSound("UD.Common.Shoulder") end
			if math.InRange(0.2, last, time) then self:EmitSound("UD.M16.Rattle3") end
		elseif sequence == "reload_100" then
			if math.InRange(0, last, time) then self:EmitSound("UD.Common.Rottle") end
			if math.InRange(0.3, last, time) then self:EmitSound("UD.M16.Magout") end
			if math.InRange(0.75, last, time) then self:EmitSound("UD.Common.Rottle") end
			if math.InRange(1.05, last, time) then self:EmitSound("UD.M16.Magin") end
			if math.InRange(1.1, last, time) then self:EmitSound("UD.Common.Rottle") end
			if math.InRange(1.59, last, time) then self:EmitSound("UD.M16.Magtap") end
			if math.InRange(1.65, last, time) then self:EmitSound("UD.Common.Cloth4") end
			if math.InRange(2.05, last, time) then self:EmitSound("UD.Common.Shoulder") end
		elseif sequence == "reload_empty_100" then
			if math.InRange(0, last, time) then self:EmitSound("UD.Common.Rottle") end
			if math.InRange(0.3, last, time) then self:EmitSound("UD.M16.Magout") end
			if math.InRange(0.75, last, time) then self:EmitSound("UD.Common.Rottle") end
			if math.InRange(0.65, last, time) then self:EmitSound("UD.Common.Rifle_Magdrop") end
			if math.InRange(1.05, last, time) then self:EmitSound("UD.M16.Magin") end
			if math.InRange(1.59, last, time) then self:EmitSound("UD.M16.Magtap") end
			if math.InRange(1.75, last, time) then self:EmitSound("UD.Common.Rottle") end
			if math.InRange(2, last, time) then self:EmitSound("UD.M16.Chback") end
			if math.InRange(2.05, last, time) then self:EmitSound("UD.Common.Cloth4") end
			if math.InRange(2.22, last, time) then self:EmitSound("UD.M16.Chamber") end
			if math.InRange(2.6, last, time) then self:EmitSound("UD.Common.Shoulder") end
		end
	end
end

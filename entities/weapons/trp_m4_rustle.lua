AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "M4A1 'Rustle'"
SWEP.Category 			= "TRP - Rifles"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/weapons/arccw/c_ud_m16.mdl")
SWEP.WorldModel 		= Model("models/weapons/arccw/c_ud_m16.mdl")

SWEP.Bodygroups 		= {
	["1"] = 1,
	["2"] = 1,
	["3"] = 3,
	["4"] = 3,
	["5"] = 9,
	["6"] = 5,
	["7"] = 5,
	["12"] = 2
}
SWEP.FixBodygroups 		= true
SWEP.SubMaterials 		= {}

SWEP.ActiveHoldType 	= "ar2"
SWEP.PassiveHoldType 	= "passive"

SWEP.Firemodes 			= 0

SWEP.AmmoType 			= "ammo_rifle"
SWEP.Durability 		= {6000, 8000}
SWEP.JamTypes 			= {
	Rate = 60 / 850,
	Sear = 10,
	Malfunction = 150
}

SWEP.ClipSize 			= 20
SWEP.Delay 				= 0.2

SWEP.Damage 			= 20

SWEP.CrouchingAccuracy 	= {util.RangeMeters(10), util.RangeMeters(40)}
SWEP.StandingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(30)}

SWEP.AimTime 			= 0.35
SWEP.ZoomLevel 			= 1.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.ShotgunPump 		= true

SWEP.RecoilKick 		= 1.2

SWEP.FireSound 			= "Terminator_SilencedSocom.Fire"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, 0, -1),
		Ang = Angle(0, 0, -10)
	},
	Holster = {
		Pos = Vector(0, -5, 0),
		Ang = Angle(10, 30, 0)
	},
	Sprint = {
		Pos = Vector(0, 0.5, 1),
		Ang = Angle(15, 10, 0)
	},
	Aim = {
		Pos = Vector(0, 1, 0.5),
		Ang = Angle(0, 0, -10)
	}
}

SWEP.AnimReplacements = {
	[ACT_VM_DRAW] = "draw",
	[ACT_VM_DRAW_EMPTY] = "draw_empty",
	[ACT_VM_IDLE] = "idle",
	[ACT_VM_IDLE_EMPTY] = "idle_empty",
	[ACT_VM_PRIMARYATTACK] = "fire",
	[ACT_VM_PRIMARYATTACK_EMPTY] = "fire_empty",
	[ACT_VM_RELOAD] = "reload_20",
	[ACT_SHOTGUN_PUMP] = "fix"
}

SWEP.AnimEmptySupport = table.MakeAssociative({
	ACT_VM_DRAW, ACT_VM_IDLE, ACT_VM_PRIMARYATTACK
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
		elseif sequence == "fix" then
			if math.InRange(0.15, last, time) then self:EmitSound("UD.M16.Chback") end
			if math.InRange(0.25, last, time) then self:EmitSound("UD.Common.Cloth4") end
			if math.InRange(0.4, last, time) then self:EmitSound("UD.M16.Chamber") end
		elseif sequence == "reload_20" then
			if math.InRange(0, last, time) then self:EmitSound("UD.Common.Rottle") end
			if math.InRange(0.25, last, time) then self:EmitSound("UD.M16.Rattle") end
			if math.InRange(0.335, last, time) then self:EmitSound("UD.M16.Magout") end
			if math.InRange(0.5, last, time) then self:EmitSound("UD.M16.Rattle") end
			if math.InRange(0.75, last, time) then self:EmitSound("UD.Common.Rottle") end
			if math.InRange(1.05, last, time) then self:EmitSound("UD.M16.Magin") end
			if math.InRange(1.1, last, time) then self:EmitSound("UD.M16.Rattle") end
			if math.InRange(1.15, last, time) then self:EmitSound("UD.Common.Rottle") end
			if math.InRange(1.81, last, time) then self:EmitSound("UD.Common.Grab") end
			if math.InRange(1.9, last, time) then self:EmitSound("UD.Common.Shoulder") end
		end
	end
end

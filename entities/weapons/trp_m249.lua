AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "M249 SAW"
SWEP.Category 			= "TRP - LMG's"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/weapons/tfa_ins2/c_minimi.mdl")
SWEP.WorldModel 		= Model("models/weapons/tfa_ins2/w_minimi.mdl")

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

SWEP.ClipSize 			= 100
SWEP.Delay 				= 60 / 775

SWEP.Damage 			= 23

SWEP.CrouchingAccuracy 	= {util.RangeMeters(10), util.RangeMeters(45)}
SWEP.StandingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(35)}

SWEP.AimTime 			= 0.5
SWEP.ZoomLevel 			= 1.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 0.75

SWEP.FireSound 			= "TFA_INS2_MINIMI.1"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, 0, -1),
		Ang = Angle(0, 0, 0)
	},
	Holster = {
		Pos = Vector(-1, -2, -1),
		Ang = Angle(10, 20, 0)
	},
	Sprint = {
		Pos = Vector(0, -1, 0),
		Ang = Angle(10, 20, 0)
	},
	Aim = {
		Pos = Vector(0, 1, 1),
		Ang = Angle(0, 0, 0)
	}
}

SWEP.AnimWhitelist = table.MakeAssociative({
	ACT_VM_DRYFIRE
})

SWEP.AnimReplacements = {
	[ACT_VM_DRAW] = ACT_VM_DRAW_DEPLOYED
}

SWEP.AnimEmptySupport = table.MakeAssociative({
	ACT_VM_RELOAD
})

SWEP.FixWorldModel 		= {
	ang = Angle(-1, -5, 178),
	pos = Vector(4, 1.3, -1.5),
	scale = 1
}

function SWEP:DoWeaponAnim(act)
	if act == ACT_VM_RELOAD and self:Clip1() > 0 and self:Clip1() < 16 then
		act = ACT_VM_RELOAD_DEPLOYED
	end

	return BaseClass.DoWeaponAnim(self, act)
end

local reloads = {
	[ACT_VM_RELOAD] = 100 / 31.5,
	[ACT_VM_RELOAD_DEPLOYED] = 100 / 31.5,
	[ACT_VM_RELOAD_EMPTY] = 140 / 31.5
}

function SWEP:Think()
	BaseClass.Think(self)

	if CLIENT then
		local ply = self:GetOwner()

		if IsValid(ply) then
			local vm = ply:GetViewModel()

			if self:IsReloading() then
				local time = reloads[self:GetActivity()]
				local start = self:GetFinishReload() - self:SequenceDuration()

				if not time or CurTime() - start > time then
					vm:SetBodygroup(1, 16)
				else
					vm:SetBodygroup(1, math.min(self:Clip1(), 16))
				end
			else
				vm:SetBodygroup(1, math.min(self:Clip1(), 16))
			end
		end
	end
end

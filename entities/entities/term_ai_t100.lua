AddCSLuaFile()
DEFINE_BASECLASS("term_ai_base")

ENT.Base = "term_ai_base"

ENT.Spawnable = true

ENT.AIHealth = 400
ENT.AIArmor = 50

ENT.WeaponDamage = 5
ENT.WeaponPlasma = true
ENT.WeaponTracer = "trp_laser"
ENT.WeaponSound = "Terminator_Plasma.T100"
ENT.WeaponSpread = Vector(0.025, 0.025, 0)

if CLIENT then
	function ENT:Initialize()
		BaseClass.Initialize(self)

		self.Side = false
	end

	function ENT:GetTracerPos(pos)
		local muzzle = self:LookupAttachment(self.Side and "muzzle_right" or "muzzle_left")

		if muzzle != 0 then
			self.Side = not self.Side

			return self:GetAttachment(muzzle).Pos
		end

		return pos
	end

	function ENT:Think()
	end

	function ENT:OnRemove()
	end

	function ENT:Draw()
		self:DrawModel()
	end

	return
end

function ENT:Initialize()
	self:SetBloodColor(BLOOD_COLOR_MECH)
	self:SetModel("models/tnb/player/trp/t100.mdl")

	self:SetHullType(HULL_LARGE)
	self:SetHullSizeNormal()

	self:SetSolid(SOLID_BBOX)
	self:SetMoveType(MOVETYPE_STEP)

	self:CapabilitiesAdd(bit.bor(CAP_MOVE_GROUND, CAP_OPEN_DOORS, CAP_TURN_HEAD))

	self:SetHealth(self.AIHealth)
	self:SetMaxHealth(self.AIHealth)

	self.Interrupts = {}
	self.Memories = {}

	self:SetModelScale(0.55, 0.0001)

	self:Activate()
end

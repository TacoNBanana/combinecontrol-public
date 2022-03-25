AddCSLuaFile()
DEFINE_BASECLASS("base_ai")

ENT.Base = "base_ai"
ENT.Type = "ai"

ENT.TerminatorAI = true

ENT.Spawnable = true

ENT.LookDistance 	= 3000
ENT.LookFOV 		= 70

ENT.ActiveMemoryTime 	= 10
ENT.InactiveMemoryTime 	= 30

ENT.Footsteps = {"T600.FootstepLeft", "T600.FootstepRight"}

ENT.AIHealth = 300
ENT.AIArmor = 50

ENT.WeaponDamage = 5
ENT.WeaponPlasma = false
ENT.WeaponTracer = "trp_minitracer"
ENT.WeaponSound = "Terminator_Minigun.Blat"
ENT.WeaponSpread = Vector(0.03, 0.03, 0)

if CLIENT then
	function ENT:GetTracerPos(pos)
		local muzzle = self.CSEnt:LookupAttachment("minigun")

		if muzzle != 0 then
			return self.CSEnt:GetAttachment(muzzle).Pos
		end

		return pos
	end

	function ENT:Think()
		if not IsValid(self.CSEnt) then
			SafeRemoveEntity(self.CSEnt)

			self.CSEnt = ClientsideModel("models/tnb/player/trp/t600.mdl")
			self.CSEnt:SetParent(self)
			self.CSEnt:SetBodyGroups("0031")
			self.CSEnt:AddEffects(EF_BONEMERGE)
			self.CSEnt:CreateShadow()
		end

		if self.CSEnt:GetParent() != self then
			SafeRemoveEntity(self.CSEnt)
		end
	end

	function ENT:OnRemove()
		if self:Health() <= 0 then
			local ragdoll = self.CSEnt:BecomeRagdollOnClient()

			timer.Simple(10, function()
				if IsValid(ragdoll) then
					ragdoll:SetSaveValue("m_bFadingOut", true)
				end
			end)
		end

		SafeRemoveEntity(self.CSEnt)
	end

	function ENT:Draw()
	end

	return
end

include("interrupt.lua")
include("schedule.lua")
include("sight.lua")
include("memory.lua")

function ENT:Initialize()
	self:SetBloodColor(BLOOD_COLOR_MECH)
	self:SetModel("models/Humans/Group01/male_07.mdl")

	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()

	self:SetSolid(SOLID_BBOX)
	self:SetMoveType(MOVETYPE_STEP)

	self:CapabilitiesAdd(bit.bor(CAP_MOVE_GROUND, CAP_OPEN_DOORS, CAP_TURN_HEAD))

	self:SetHealth(self.AIHealth)
	self:SetMaxHealth(self.AIHealth)

	self:DrawShadow(false)

	self.Interrupts = {}
	self.Memories = {}

	if #self.Footsteps == 2 then
		self.Step = false
	end
end

function ENT:SelectSchedule()
	if not self.LastSchedule or string.find(self.LastSchedule, "Control") then
		self:SetCustomSchedule("Control_Idle")
	else
		if self.LastSchedule == "Attack" then
			self:SetCustomSchedule("Attack")
		else
			self:SetCustomSchedule("Seek")
		end
	end
end

function ENT:RunAI()
	self:Look(self.LookDistance, self.LookFOV)
	self:UpdateMemories()

	self:FireInterrupts()

	BaseClass.RunAI(self)

	self:SetMoveYawLocked(tobool(string.find(self.ActiveSchedule, "Attack")))
end

function ENT:GetRelationship(ent)
	if ent:IsPlayer() then
		return D_HT
	end
end

function ENT:OnTakeDamage(dmg)
	local ply = dmg:GetAttacker()
	local weapon = dmg:GetInflictor()

	if IsValid(ply) and ply:IsPlayer() then
		self:UpdateMemory(ply, ply:GetPos())
	end

	dmg = dmg:GetDamage()

	if not GAMEMODE.PlasmaBullet then
		dmg = GAMEMODE:CalcDamage(dmg, self.AIArmor)
	end

	if IsValid(weapon) and weapon.Damage then
		dmg = math.Clamp(dmg, 0, weapon.Damage * 1.5)
	end

	self:SetHealth(self:Health() - dmg)

	if self:Health() <= 0 then
		SafeRemoveEntityDelayed(self, 0)
	end
end

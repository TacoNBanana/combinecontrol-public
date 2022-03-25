AddCSLuaFile()

ENT.Base = "cc_base_ent"

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "Text")
end

function ENT:Initialize()
	if CLIENT then return end

	self:SetModel(Model("models/props_c17/paper01.mdl"))
	self:PhysicsInit(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()

	if IsValid(phys) then
		phys:Wake()
	end

	self.KillTime = CurTime() + 86400 -- 24 hours
end

function ENT:OnTakeDamage(dmginfo)
	self:TakePhysicsDamage(dmginfo)
end

function ENT:Think()
	if CLIENT then
		return
	end

	if CurTime() > self.KillTime then
		self:Remove()
	end
end

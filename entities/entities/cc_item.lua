AddCSLuaFile()

ENT.Base = "cc_base_ent"

ENT.AllowPhys = true

function ENT:Initialize()
	if CLIENT then return end

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

	local phys = self:GetPhysicsObject()

	if IsValid(phys) then
		phys:Wake()
	end
end

function ENT:Think()
	if CLIENT then
		return
	end

	if self.Item then
		self.Item:SaveLocation()
	end

	self:NextThink(CurTime() + 30)

	return true
end

function ENT:OnRemove()
	if CLIENT then
		return
	end

	local item = self.Item

	-- self.Item gets nulled out first if the item is being removed by other means, e.g. unloading or being picked up
	if item and not GAMEMODE.IsShuttingDown then
		GAMEMODE:DeleteItem(item)
	end
end

function ENT:Use(activator, caller, usetype, val)
	local item = self.Item

	if not item then
		return
	end

	item:OnWorldUse(activator)
end
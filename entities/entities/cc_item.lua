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

	if self.Item and self:HasMoved() then
		self:SaveMoved()

		self.Item:SaveLocation()
	end

	self:NextThink(CurTime() + 30)

	return true
end

function ENT:HasMoved()
	if not self.SavedPos then
		return true
	end

	local pos = self:GetPos()
	local ang = self:GetAngles()

	pos = Vector(math.Round(pos.x, 2), math.Round(pos.y, 2), math.Round(pos.z, 2))
	ang = Angle(math.Round(ang.p, 2), math.Round(ang.y, 2), math.Round(ang.r, 2))

	if self.SavedPos != pos or self.SavedAng != ang then
		return true
	end

	return false
end

function ENT:SaveMoved()
	local pos = self:GetPos()
	local ang = self:GetAngles()

	self.SavedPos = Vector(math.Round(pos.x, 2), math.Round(pos.y, 2), math.Round(pos.z, 2))
	self.SavedAng = Angle(math.Round(ang.p, 2), math.Round(ang.y, 2), math.Round(ang.r, 2))
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

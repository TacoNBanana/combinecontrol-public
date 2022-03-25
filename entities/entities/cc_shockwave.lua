AddCSLuaFile()

ENT.Base 				= "cc_base_ent"

ENT.Speed 				= 200
ENT.MaxRange 			= 50000

ENT.Force 				= 255
ENT.Damage 				= 10

function ENT:Initialize()
	self:SetModel(Model("models/props_junk/PopCan01a.mdl"))
	self:SetSolid(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)

	self:SetNoDraw(true)

	self.CurrentRange = 0
end

function ENT:Think()
	if not SERVER then
		return
	end

	self.CurrentRange = math.Clamp(self.CurrentRange + (self.Speed * 2), 0, self.MaxRange)

	if self.CurrentRange >= self.MaxRange then
		self:Remove()
	end

	for _, v in pairs(ents.FindInSphere(self:GetPos(), self.CurrentRange)) do
		if not IsValid(v) then
			continue
		end

		if v:PropSaved() == 1 then
			continue
		end

		local dmg = DamageInfo()

		dmg:SetDamage(self.Damage)
		dmg:SetDamageType(DMG_BLAST)
		dmg:SetAttacker(self:GetOwner())
		dmg:SetInflictor(self)

		for i = 0, v:GetPhysicsObjectCount() - 1 do
			local phys = v:GetPhysicsObjectNum(i)

			if IsValid(phys) then
				local dist = self:GetPos():Distance(v:GetPos())
				local fraction = math.Clamp((self.CurrentRange - dist) / self.CurrentRange, 0, 1)
				local dir = (v:GetPos() - self:GetPos()) * self.Force

				phys:AddAngleVelocity(Vector(self.Force, self.Force, self.Force) * fraction)
				phys:AddVelocity(dir)

				local class = v:GetClass()

				if class == "func_breakable" or class == "func_breakable_surf" or class == "func_physbox" then
					v:Fire("Break", 0)
				end
			end
		end

		if v:IsPlayer() then
			local dist = self:GetPos():Distance(v:GetPos())
			local fraction = math.Clamp((self.CurrentRange - dist) / self.CurrentRange, 0, 1)

			v:SetVelocity((v:GetPos() - self:GetPos()) * self.Force * fraction)

			v:TakeDamageInfo(dmg)
		else v:IsNPC()
			v:TakeDamageInfo(dmg)
		end
	end

	self:NextThink(CurTime() + 0.1)

	return true
end

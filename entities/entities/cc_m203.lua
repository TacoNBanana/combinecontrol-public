AddCSLuaFile()

ENT.Base 				= "cc_base_projectile"

ENT.Model 				= Model("models/weapons/ar2_grenade.mdl")

ENT.Velocity 			= 2000

ENT.UseGravity 			= true
ENT.GravityMultiplier 	= 1

ENT.Damage 				= 60
ENT.Radius 				= 180

if SERVER then
	function ENT:CustomInit()
		self:SetModelScale(0.5, 0)

		local trail = ents.Create("env_smoketrail")

		trail:SetSaveValue("m_Opacity", 0.2)
		trail:SetSaveValue("m_SpawnRate", 48)
		trail:SetSaveValue("m_ParticleLifetime", 1)

		trail:SetSaveValue("m_StartColor", Vector(0.1, 0.1, 0.1))
		trail:SetSaveValue("m_EndColor", Vector(0, 0, 0))

		trail:SetSaveValue("m_StartSize", 12)
		trail:SetSaveValue("m_EndSize", 48)

		trail:SetSaveValue("m_SpawnRadius", 4)

		trail:SetSaveValue("m_MinSpeed", 4)
		trail:SetSaveValue("m_MaxSpeed", 24)

		trail:SetPos(self:GetPos())
		trail:SetAngles(self:GetAngles())

		trail:SetParent(self)

		trail:Spawn()
		trail:Activate()
	end

	function ENT:OnHit(data)
		local ent = data.Entity

		if IsValid(ent) and ent:IsPlayer() then
			local info = DamageInfo()

			info:SetDamage(self.Damage)
			info:SetAttacker(self:GetOwner())
			info:SetInflictor(self)
			info:SetDamageType(DMG_BLAST)

			ent:TakeDamageInfo(info)
		end

		util.ScreenShake(self:GetPos(), 25, 150, 1, self.Radius)

		local explo = ents.Create("env_explosion")
		explo:SetOwner(self:GetOwner())
		explo:SetPos(self:GetPos())
		explo:SetKeyValue("iMagnitude", self.Damage)
		explo:SetKeyValue("iRadiusOverride", self.Radius)
		explo:Spawn()
		explo:Activate()
		explo:Fire("Explode")
	end
end

AddCSLuaFile()

ENT.Base 				= "cc_base_projectile"

ENT.Model 				= Model("models/weapons/w_missile_launch.mdl")

ENT.LoopSound 			= Sound("Missile.Ignite")

ENT.Velocity 			= 2000

ENT.UseGravity 			= false
ENT.GravityMultiplier 	= 0.3

ENT.Damage 				= 1500
ENT.Radius 				= 400

if SERVER then
	function ENT:CustomInit()
		local trail = ents.Create("env_rockettrail")

		trail:SetSaveValue("m_SpawnRate", 100)
		trail:SetSaveValue("m_ParticleLifetime", 0.5)

		if os.date("!%d-%m") == "01-04" then
			trail:SetSaveValue("m_Opacity", 1)

			local col = HSVToColor(math.Rand(0, 360), 1, 1)
			local vec = Vector(col.r, col.g, col.b) / 255

			trail:SetSaveValue("m_StartColor", vec)
		else
			trail:SetSaveValue("m_Opacity", 0.2)
			trail:SetSaveValue("m_StartColor", Vector(0.65, 0.65, 0.65))
		end

		trail:SetSaveValue("m_EndColor", Vector(0, 0, 0))

		trail:SetSaveValue("m_StartSize", 8)
		trail:SetSaveValue("m_EndSize", 32)

		trail:SetSaveValue("m_SpawnRadius", 4)

		trail:SetSaveValue("m_MinSpeed", 2)
		trail:SetSaveValue("m_MaxSpeed", 16)

		trail:SetPos(self:GetPos())
		trail:SetAngles(self:GetAngles())

		trail:SetParent(self)

		trail:Spawn()
		trail:Activate()

		self:EmitSound(self.LoopSound)
	end

	function ENT:CustomThink()
		if os.date("!%d-%m") == "01-04" then
			local time = CurTime() - self:GetCreationTime()
			local mult = math.min(time * 5, 10)

			self.Vel:Rotate(Angle(math.Rand(-mult, mult), math.Rand(-mult, mult), 0))
		end
	end

	function ENT:OnHit(data)
		local ent = data.Entity

		if IsValid(ent) and ent:IsPlayer() then
			local info = DamageInfo()

			info:SetDamage(2000)
			info:SetAttacker(self:GetOwner())
			info:SetInflictor(self)
			info:SetDamageType(DMG_BLAST)

			ent:TakeDamageInfo(info)
		end

		self:StopSound(self.LoopSound)

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
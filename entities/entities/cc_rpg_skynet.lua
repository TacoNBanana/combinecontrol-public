AddCSLuaFile()

ENT.Base 				= "cc_base_projectile"

ENT.Model 				= Model("models/weapons/w_missile_launch.mdl")

ENT.LoopSound 			= Sound("Missile.Ignite")

ENT.ExplodeSound 		= Sound("ambient/explosions/explode_1.wav")
ENT.ExplodeSoundRange 	= 1000

ENT.Velocity 			= 4000

ENT.UseGravity 			= true
ENT.GravityMultiplier 	= 0.1

ENT.Damage 				= 90
ENT.Radius 				= 250

ENT.Effect 				= "Explosion"

if SERVER then
	function ENT:CustomInit()
		local trail = ents.Create("env_rockettrail")

		trail:SetSaveValue("m_SpawnRate", 100)
		trail:SetSaveValue("m_ParticleLifetime", 0.5)

		trail:SetSaveValue("m_Opacity", 0)

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

	function ENT:OnHit(data)
		self:StopSound(self.LoopSound)

		util.ScreenShake(self:GetPos(), 25, 150, 1, self.Radius)
		util.BlastDamage(self, self:GetOwner(), self:GetPos(), self.Radius, self.Damage)

		local ent = ents.Create("env_explosion")

		ent:SetPos(self:GetPos())
		ent:SetAngles(data.HitNormal:Angle())
		ent:SetOwner(ply)

		ent:SetKeyValue("spawnflags", 33)
		ent:SetKeyValue("iMagnitude", self.Damage)

		ent:Spawn()
		ent:Activate()
		ent:Fire("Explode")

		--GAMEMODE:SoundRange(self:GetPos(), self.ExplodeSoundRange, self.ExplodeSound)
	end
end

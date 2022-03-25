AddCSLuaFile()

ENT.Base 				= "cc_base_projectile"

ENT.Model 				= Model("models/weapons/w_missile_launch.mdl")

ENT.LoopSound 			= Sound("Missile.Ignite")

ENT.ExplodeSound 		= Sound("ambient/explosions/explode_1.wav")
ENT.ExplodeSoundRange 	= 1000

ENT.Velocity 			= 4000

ENT.UseGravity 			= true
ENT.GravityMultiplier 	= 0.3

ENT.Damage 				= 300
ENT.Radius 				= 250

ENT.Effect 				= "grenade_explosion_01"

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

		ParticleEffect(self.Effect, self:GetPos(), data.HitNormal:Angle() + Angle(90, 0, 0))

		GAMEMODE:SoundRange(self:GetPos(), self.ExplodeSoundRange, self.ExplodeSound)
	end
end

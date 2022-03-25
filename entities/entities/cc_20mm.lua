AddCSLuaFile()

ENT.Base 				= "cc_base_projectile"

ENT.Model 				= Model("models/weapons/ar2_grenade.mdl")

ENT.Velocity 			= 4000

ENT.UseGravity 			= true
ENT.GravityMultiplier 	= 0.3

ENT.Damage 				= 30
ENT.Radius 				= 200

ENT.Effect 				= "grenade_explosion_01"

if SERVER then
	function ENT:OnHit(data)
		local pos = data.HitPos + data.HitNormal * 5

		util.ScreenShake(pos, 25, 150, 1, self.Radius)
		util.BlastDamage(self, self:GetOwner(), pos, self.Radius, self.Damage)

		ParticleEffect(self.Effect, pos, data.HitNormal:Angle() + Angle(180, 0, 0))

		GAMEMODE:SoundRange(self:GetPos(), 500, "weapons/hegrenade/hegrenade_distant_detonate_03.wav")
	end
end

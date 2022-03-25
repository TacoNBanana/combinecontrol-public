AddCSLuaFile()

ENT.Base 	= "cc_grenade_frag"

ENT.Model 	= Model("models/halo_package.mdl")

ENT.Damage 				= 200
ENT.Radius 				= 500

ENT.Effect 				= "high_explosive_air"

ENT.ExplodeSound 		= Sound("ambient/explosions/explode_1.wav")
ENT.ExplodeSoundRange 	= 0

function ENT:Explode(tr)
	util.ScreenShake(self:GetPos(), 25, 150, 1, self.Radius)
	util.BlastDamage(self, self:GetOwner(), self:GetPos(), self.Radius, self.Damage)

	ParticleEffect(self.Effect, self:GetPos(), angle_zero)

	local snd = "wac/tank/tank_shell_0" .. math.random(1, 5) .. ".wav"

	self:EmitSound(snd)

	GAMEMODE:SoundRange(self:GetPos(), self.ExplodeSoundRange, snd)

	self:Remove()
end

AddCSLuaFile()

ENT.Base 				= "cc_base_projectile"

ENT.Model 				= Model("models/crossbow_bolt.mdl")

ENT.Velocity 			= 4000

ENT.UseGravity 			= true
ENT.GravityMultiplier 	= 0.5

ENT.Damage 				= 800

if SERVER then
	function ENT:OnHit(data)
		local ent = data.Entity

		self:EmitSound("weapons/crossbow/hit1.wav")

		if IsValid(ent) then
			local info = DamageInfo()

			info:SetDamage(self.Damage)
			info:SetAttacker(self:GetOwner())
			info:SetDamageForce(self.Vel)
			info:SetDamagePosition(data.HitPos)
			info:SetInflictor(self)
			info:SetDamageType(DMG_SLASH)

			ent:TakeDamageInfo(info)
		end
	end
end
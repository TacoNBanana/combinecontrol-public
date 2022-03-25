BULLET = class.Create("bullet_base")
DEFINE_BASECLASS("bullet_base")

BULLET.Projectile 	= ""

BULLET.Damage 		= 0
BULLET.Radius 		= 0

BULLET.Recoil 		= 0

BULLET.LoudSound 	= ""
BULLET.QuietSound 	= ""

function BULLET:OnFired(ply, weapon, aimcone)
	if SERVER then
		local pos = ply:GetShootPos() + ply:GetForward() * 8 + ply:GetRight() * 6

		local ent = ents.Create(self.Projectile)
		ent:SetPos(pos)
		ent:SetAngles(ply:GetAimVector():Angle())
		ent:SetOwner(ply)
		ent:Spawn()
		ent:Activate()

		ent.Damage = self.Damage
		ent.Radius = self.Radius
	end

	local snd = self:GetFireSound(weapon)

	if snd then
		weapon:EmitSound(snd)
	end

	if IsFirstTimePredicted() and CLIENT then
		weapon:DoVMRecoil(self.Recoil)
	end

	weapon:DoRecoil(self.Recoil)
end
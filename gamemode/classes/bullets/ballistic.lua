BULLET = class.Create("bullet_base")
DEFINE_BASECLASS("bullet_base")

BULLET.Damage 		= 0

BULLET.Amount 		= 1
BULLET.Spread 		= 0
BULLET.Recoil 		= 0

BULLET.Tracer 		= "tracer"

function BULLET:Callback(attacker, trace, dmginfo)
end

function BULLET:OnFired(ply, weapon, aimcone)
	local bullet = {}

	bullet.Num 			= self.Amount
	bullet.Src 			= ply:GetShootPos()
	bullet.Dir 			= (ply:EyeAngles() + ply:GetViewPunchAngles() + aimcone * 25):Forward()
	bullet.Spread 		= Vector(self.Spread, self.Spread, 0)
	bullet.Damage 		= self.Damage
	bullet.Tracer 		= 1
	bullet.TracerName 	= self.Tracer
	bullet.Force 		= self.Damage * 0.3
	bullet.AmmoType 	= ""
	bullet.Callback 	= function(attacker, trace, dmginfo)
		self:Callback(attacker, trace, dmginfo)
	end

	ply:FireBullets(bullet)

	local snd = self:GetFireSound(weapon)

	if snd then
		weapon:EmitSound(snd)
	end

	if IsFirstTimePredicted() and CLIENT then
		weapon:DoVMRecoil(self.Recoil)
	end

	weapon:DoRecoil(self.Recoil)
end
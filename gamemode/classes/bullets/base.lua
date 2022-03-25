BULLET = class.Create()

BULLET.Name 		= ""

BULLET.Caliber 		= ""

BULLET.AmmoClass 	= "" -- Auto filled

BULLET.FireSound 	= ""

function BULLET:OnFired(ply, weapon, aimcone)
end

function BULLET:GetFireSound(weapon)
	return #self.FireSound > 0 and self.FireSound or weapon.FireSound
end
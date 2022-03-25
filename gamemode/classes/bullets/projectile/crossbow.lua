BULLET = class.Create("bullet_projectile")
DEFINE_BASECLASS("bullet_projectile")

BULLET.Projectile 	= "cc_crossbow"

BULLET.Name 		= "Crossbow bolt"
BULLET.Model 		= Model("models/Items/CrossbowRounds.mdl")

BULLET.Caliber 		= "crossbow"

BULLET.Damage 		= 200

BULLET.Recoil 		= 1

BULLET.Weight 		= 0.1
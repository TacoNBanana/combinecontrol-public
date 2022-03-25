BULLET = class.Create("bullet_projectile")
DEFINE_BASECLASS("bullet_projectile")

BULLET.Projectile 	= "cc_m203"

BULLET.Name 		= "40mm HE"
BULLET.Model 		= Model("models/Items/AR2_Grenade.mdl")

BULLET.Caliber 		= "40mm"

BULLET.Damage 		= 800
BULLET.Radius 		= 180

BULLET.Recoil 		= 1

BULLET.FireSound 	= soundscript.AddFire("BULLET_40MM", "tekka/weapons/weapon_m203.wav", 140)
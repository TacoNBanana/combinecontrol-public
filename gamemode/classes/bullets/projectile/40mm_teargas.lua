BULLET = class.Create("bullet_projectile")
DEFINE_BASECLASS("bullet_projectile")

BULLET.Projectile 	= "cc_m203_teargas"

BULLET.Name 		= "40mm Gas"
BULLET.Model 		= Model("models/Items/AR2_Grenade.mdl")

BULLET.Caliber 		= "40mm"

BULLET.Recoil 		= 1

BULLET.FireSound 	= soundscript.AddFire("BULLET_40MM", "tekka/weapons/weapon_m203.wav", 140)
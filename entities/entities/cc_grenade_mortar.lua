AddCSLuaFile()

ENT.Base 	= "cc_grenade_frag"

ENT.Model 	= Model("models/Weapons/w_eq_fraggrenade_thrown.mdl")

ENT.Damage 	= 1500
ENT.Radius 	= 300

function ENT:Explode()
	local pos = self:GetPos()

	util.ScreenShake(self:GetPos(), 25, 150, 1, self.Radius)

	local explo = ents.Create("env_explosion")
	explo:SetOwner(self.Thrower)
	explo:SetPos(self:GetPos())
	explo:SetKeyValue("iMagnitude", self.Damage)
	explo:SetKeyValue("iRadiusOverride", self.Radius)
	explo:Spawn()
	explo:Activate()
	explo:Fire("Explode")

	ParticleEffect("50lb_main", pos, Angle())

	GAMEMODE:SoundRange(pos, 5000, "gbombs_5/explosions/light_bomb/small_explosion_6.mp3")

	local shock = ents.Create("cc_shockwave")
	shock:SetPos(pos)
	shock:SetAngles(Angle())
	shock.MaxRange = 500
	shock.Damage = 0
	shock.Force = 0
	shock:Spawn()
	shock:Activate()

	self:Remove()
end
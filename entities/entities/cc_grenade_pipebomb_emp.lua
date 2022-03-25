AddCSLuaFile()

ENT.Base 	= "cc_grenade_frag"

ENT.Model 	= Model("models/tnb/trpweapons/w_pipebomb.mdl")

ENT.Damage 	= 5000
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

	ParticleEffect("striderbuster_explode_core", pos, Angle())

	GAMEMODE:SoundRange(pos, 6000, "Weapon_StriderBuster.Detonate")

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
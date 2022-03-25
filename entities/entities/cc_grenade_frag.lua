AddCSLuaFile()

ENT.Base 	= "cc_base_ent"

ENT.Model 	= Model("models/Weapons/w_eq_fraggrenade_thrown.mdl")

ENT.Damage 	= 800
ENT.Radius 	= 350

function ENT:SetTimer(dDelay)
	self.DetonateTime = CurTime() + dDelay
	self:NextThink(CurTime())
end

local models = {
	"models/props_junk/garbage_metalcan001a.mdl",
	"models/Gibs/HGIBS.mdl",
	"models/props_c17/doll01.mdl",
	"models/props_junk/watermelon01.mdl",
	"models/props_lab/huladoll.mdl",
	"models/props_lab/cactus.mdl",
	"models/props_junk/garbage_coffeemug001a.mdl",
	"models/props/cs_italy/bananna_bunch.mdl",
	"models/props/cs_italy/orange.mdl",
	"models/props/cs_italy/bananna.mdl"
}

function ENT:Initialize()
	if CLIENT then
		return
	end

	self:SetModel(self.Model)

	if os.date("!%d-%m") == "01-04" then
		self:SetModel(Model(table.Random(models)))
	end

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

	self.Detonated = false

	local phys = self:GetPhysicsObject()

	if IsValid(phys) then
		phys:Wake()
	end
end

function ENT:OnTakeDamage(dmginfo)
	self:TakePhysicsDamage(dmginfo)
end

function ENT:Explode(tr)
	if tr.Fraction ~= 1.0 then
		self:SetPos(tr.HitPos + tr.Normal * 0.6)
	end

	util.ScreenShake(self:GetPos(), 25, 150, 1, self.Radius)

	local explo = ents.Create("env_explosion")
	explo:SetOwner(self.Thrower)
	explo:SetPos(self:GetPos())
	explo:SetKeyValue("iMagnitude", self.Damage)
	explo:SetKeyValue("iRadiusOverride", self.Radius)
	explo:Spawn()
	explo:Activate()
	explo:Fire("Explode")

	self:Remove()
end

function ENT:Detonate()
	self:NextThink(CurTime() + 1)

	local spot = self:GetPos() + Vector(0, 0, 8)

	local trace = {}
	trace.start = self:GetPos()
	trace.endpos = spot + Vector(0, 0, -32)
	trace.filter = self

	local tr = util.TraceLine(trace)

	if tr.StartSolid then
		trace.start = self:GetPos()
		trace.endpos = self:GetPos() + Vector(0, 0, -32)

		tr = util.TraceLine(trace)
	end

	self:Explode(tr)
end

function ENT:Think()
	if CLIENT then
		return
	end

	if CurTime() > self.DetonateTime and not self.Detonated then
		self.Detonated = true
		self:Detonate()
	end

	self:NextThink(CurTime() + 0.1)
end
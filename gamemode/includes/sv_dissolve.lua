local meta = FindMetaTable("Entity")

local snd = Sound("scifi.vapor.dissolve")

function meta:FadeLight(min, max, amt, dietime)
	local range = max
	local srange = range / 2
	local name = "FadeLight" .. self:EntIndex()

	timer.Create(name, 0, 0, function()
		range = range - amt
		srange = range / 2

		if not IsValid(self) then
			timer.Remove(name)

			return
		else
			self:Fire("distance", range, 0)
			self:Fire("spotlight_distance", srange, 0)
		end

		if range == min then
			timer.Remove(name)
		end
	end)

	SafeRemoveEntityDelayed(self, dietime)
end

function meta:Dissolve()
	if self.IsDissolving then return end

	self.IsDissolving = true
	self:Extinguish()

	local phys = self:GetPhysicsObject()

	if IsValid(phys) then
		if self:IsRagdoll() then
			phys:SetMass(1)
			phys:EnableDrag(true)
			phys:SetDragCoefficient(16384)
			phys:SetAngleDragCoefficient(16384)
			phys:ApplyForceCenter(Vector(math.random(-10, 10), math.random(-10, 10), math.random(-5, 55)) * 8)
		else
			phys:ApplyForceCenter(Vector(math.random(-10, 10), math.random(-10, 10), math.random(-5, 55)) * 8)
		end
	end

	for i = 0, self:GetPhysicsObjectCount() - 1 do
		local bone = self:GetPhysicsObjectNum(i)

		if IsValid(bone) then
			bone:EnableGravity(false)
		end
	end

	local pos = self:GetPos()

	self:DrawShadow(false)
	self:SetNoDraw(false)

	local ed = EffectData()
		ed:SetOrigin(pos)
		ed:SetEntity(self)
	util.Effect("vp_dissolve", ed, true, true)

	self:SetCollisionGroup(COLLISION_GROUP_DISSOLVING)

	self:EmitSound(snd)
	self:Fire("kill", "", 0.68)

	ParticleEffectAttach("vp_dissolve", 1, self, -1)

	local light = ents.Create("light_dynamic")

	if not IsValid(light) then
		return
	end

	light:SetKeyValue("_light", "40 60 255 255")
	light:SetKeyValue("brightness", 3)
	light:SetKeyValue("style", 1)
	light:SetPos(pos)
	light:SetParent(self)
	light:Spawn()

	light:FadeLight(0, 420, 8, 0.68)
end
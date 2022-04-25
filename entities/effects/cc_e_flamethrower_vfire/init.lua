function EFFECT:Init(data)
	self.wep = data:GetEntity()
	if not IsValid(self.wep) then
		return
	end

	self.owner = self.wep:GetOwner()
	self.attach = data:GetAttachment()

	self:SetRenderOrigin(self.owner:GetPos())

	local mins, maxs = self.owner:GetRenderBounds()

	self:SetRenderBounds(mins, maxs, Vector(500, 500, 500))

	-- Used to determine when to spawn the next clientside fireball
	self.lastFireBall = 0

	-- Used in the think hook to avoid early dismissals
	self.startTime = CurTime()
end

local beamMat = Material("effects/combinemuzzle2_dark")

function EFFECT:Render()
	local eyeAngs = self.owner:EyeAngles()
	local ent = self.wep

	if self.owner == LocalPlayer() and LocalPlayer():GetViewEntity() == LocalPlayer() and not hook.Call("ShouldDrawLocalPlayer", GAMEMODE, self.owner) then
		ent = LocalPlayer():GetViewModel()
	end

	if not IsValid(ent) or not ent:GetAttachment(self.attach) then
		return
	end

	local pos = ent:GetAttachment(self.attach).Pos
	local vel = eyeAngs:Forward() * math.Rand(2300, 2700)

	-- Draw a beam
	render.SetMaterial(beamMat)
	render.DrawBeam(pos, pos + vel * 0.0335, math.Rand(6, 10), math.Rand(0, 1), 1, Color(255, 255, 255, 255))

	-- Draw following particles
	local pe = ParticleEmitter(pos, false)
	local p = pe:Add("effects/combinemuzzle2_dark", pos + vel * 0.003)
		p:SetDieTime(0.2)
		p:SetVelocity(vel)
		p:SetGravity(Vector(0, 0, -1750))
		p:SetAirResistance(math.Rand(600, 1000))
		p:SetStartAlpha(math.Rand(100, 200))
		p:SetEndAlpha(0)
		p:SetStartSize(math.Rand(3, 4))
		p:SetEndSize(math.Rand(8, 30))
		p:SetRoll(math.Rand(0, math.pi))
		p:SetRollDelta(math.Rand(-40, 40))
	pe:Finish()

	-- Draw a light
	local dLight = DynamicLight(self.wep:EntIndex())
	if dLight then
		dLight.Pos = pos
		dLight.r = 255
		dLight.g = 100
		dLight.b = 80
		dLight.Brightness = 2
		dLight.Decay = 30000
		dLight.Size = 250
		dLight.DieTime = CurTime() + 0.2
	end
end

-- Kill the effect
function EFFECT:Think()
	self:SetRenderOrigin(self.owner:GetPos())

	local mins, maxs = self.owner:GetRenderBounds()

	self:SetRenderBounds(mins, maxs, Vector(500, 500, 500))

	if not IsValid(self.wep) then
		return false
	end

	if CurTime() < self.startTime + 0.1 then
		return true
	end

	return self.wep:GetIsFiring()
end

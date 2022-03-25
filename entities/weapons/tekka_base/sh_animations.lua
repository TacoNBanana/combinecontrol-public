SWEP.CurrentSSTable = {}
SWEP.CurrentSSEntry = 0
SWEP.SSTime = 0
SWEP.SSSpeed = 1

function SWEP:PlayAnimation(anim, speed, cycle, nosound, ent, force)
	speed = speed or 1
	cycle = cycle or 0
	ent = ent or self.VM

	if speed < 0 then
		cycle = 1 - cycle
	end

	if not anim then
		return
	end

	if ent == self.VM then
		anim = self.Animations[anim] or anim

		if istable(anim) then
			anim = table.Random(anim)
		end

		if IsFirstTimePredicted() or force then
			local snd = self.SoundScripts[anim]

			if snd and not nosound then
				self:SetupSoundScript(snd, speed, cycle)
			else
				self:StopSoundScript()
			end
		end

		if SERVER then
			local _, duration = self.Owner:GetViewModel():LookupSequence(anim)

			return math.abs((duration * (1 / speed)) - math.max(duration * (1 / speed) * cycle, 0))
		end
	end

	if IsFirstTimePredicted() or force then
		ent:ResetSequence(anim)
		ent:SetCycle(math.max(0, cycle))
		ent:SetPlaybackRate(speed)
	end

	local _, duration = ent:LookupSequence(anim)

	return math.abs((duration * (1 / speed)) - math.max(duration * (1 / speed) * cycle, 0))
end

function SWEP:SoundThink()
	if #self.CurrentSSTable > 0 then
		local entry = self.CurrentSSTable[self.CurrentSSEntry]

		if not entry then
			return
		end

		if CurTime() > self.SSTime + entry.time / self.SSSpeed then
			self:EmitSound(entry.snd)

			if entry.callback then
				entry.callback(self)
			end

			self.CurrentSSEntry = self.CurrentSSEntry + 1

			if not self.CurrentSSTable[self.CurrentSSEntry] then
				self:StopSoundScript()
			end
		end
	end
end

function SWEP:SetupSoundScript(tab, speed, cycle)
	local index = 1
	local valid = false

	if cycle != 0 then
		local length = self.VM:SequenceDuration()
		local time = length * cycle

		for k, v in pairs(tab) do
			if time < v.time then
				index = k
				valid = true

				break
			end
		end
	else
		valid = true
	end

	if valid then
		self.CurrentSSTable = tab
		self.CurrentSSEntry = index
		self.SSTime = CLIENT and UnPredictedCurTime() or CurTime()
		self.SSSpeed = speed
	else
		self:StopSoundScript()
	end
end

function SWEP:StopSoundScript()
	self.CurrentSSTable = {}
	self.CurrentSSEntry = 0
	self.SSTime = 0
end

SWEP.ActivityTranslations = {
	passive = {
		[ACT_MP_CROUCH_IDLE] = ACT_HL2MP_IDLE_CROUCH,
		[ACT_MP_CROUCHWALK] = ACT_HL2MP_WALK_CROUCH
	},
	slam = {
		[ACT_MP_ATTACK_STAND_PRIMARYFIRE] = ACT_INVALID
	}
}

function SWEP:TranslateActivity(act)
	local holdtype = self:GetHoldType()
	local tab = self.ActivityTranslations[holdtype]

	if tab and tab[act] then
		return tab[act]
	end

	if self.ActivityTranslate[act] then
		return self.ActivityTranslate[act]
	end

	return -1
end
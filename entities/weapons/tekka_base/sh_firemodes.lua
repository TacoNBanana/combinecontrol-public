SWEP.SavedAmmo = {}

function SWEP:SetupFiremodes()
	self.Firemodes = table.Copy(self.Firemodes)

	for index, firemode in ipairs(self.Firemodes) do
		local instance = class.Instance(firemode.Mode)

		firemode.Vars = firemode.Vars or {}
		for k, v in pairs(firemode.Vars) do
			instance[k] = v
		end

		self.Firemodes[index] = instance
	end
end

function SWEP:GetFiremode(index)
	if not index then
		return self.StoredMode
	end

	return self.Firemodes[index]
end

function SWEP:CycleFiremode()
	if CurTime() < self:GetNextModeSwitch() then
		return
	end

	if #self.Firemodes < 2 then
		return
	end

	local old = self:GetFiremodeIndex()
	local new = old + 1

	if new > #self.Firemodes then
		new = 1
	end

	self:SetFiremode(old, new)

	if CLIENT then
		self:EmitSound("weapons/smg1/switch_single.wav")
	end
end

function SWEP:SetFiremode(old, new)
	local oldmode = self:GetFiremode(old)
	local newmode = self:GetFiremode(new)

	self:SetFiremodeIndex(new)
	self.StoredMode = newmode

	if oldmode then
		oldmode:SwitchFrom(self)
	end

	newmode:SwitchTo(self)
end
SWEP.SavedAmmo = {}

function SWEP:SetupFiremodes()
	for k, v in ipairs(self.Firemodes) do
		local meta = {
			__index = firemode.Get(v.Mode)
		}

		self.Firemodes[k] = setmetatable(v.Vars, meta)
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

	self.Primary.Automatic = newmode.Burst and false or newmode.Automatic
	self.Primary.ClipSize = newmode.ClipSize or self.ClipSize

	if oldmode then
		self:SwapAmmo(oldmode, newmode)

		oldmode.SwitchFrom(self)
	end

	newmode.SwitchTo(self)
end

function SWEP:SwapAmmo(old, new)
	self.SavedAmmo[old.AmmoPool] = self:Clip1()

	local saved = self.SavedAmmo[new.AmmoPool]

	if saved then
		self:SetClip1(saved)
		self.SavedAmmo[new.AmmoPool] = nil
	else
		self:SetClip1(0)
	end
end
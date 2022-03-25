hook.Add("PreDrawPlayerHands", "base_trp", function(hands, vm, ply, weapon)
	if weapon.UseHandsFix then
		return true
	end
end)

function SWEP:PreDrawViewModel(vm, ent, ply)
	if self:InScope() and not self:ForceUnscope() then
		render.SetBlend(0)
	end

	if self.UseHandsFix and not IsValid(self.HandsModel) then
		SafeRemoveEntity(self.HandsModel)

		self.HandsModel = ClientsideModel("models/weapons/tfa_ins2/c_ins2_pmhands.mdl", RENDERGROUP_BOTH)
		self.HandsModel:SetNoDraw(true)
		self.HandsModel:SetupBones()

		self.HandsModel:SetParent(vm)
		self.HandsModel:SetPos(vector_origin)
		self.HandsModel:SetAngles(angle_zero)
		self.HandsModel:AddEffects(EF_BONEMERGE)
		self.HandsModel:AddEffects(EF_BONEMERGE_FASTCULL)
	end

	if self.FixBodygroups then
		for k, v in pairs(self.Bodygroups) do
			model.SetNumBodygroup(vm, k, v)
		end
	end
end

function SWEP:PostDrawViewModel(vm, ent, ply)
	render.SetBlend(1)

	if not self:InScope() and self.UseHandsFix and IsValid(self.HandsModel) then
		local hands = ply:GetHands()

		if hands:GetParent() != self.HandsModel then
			hands:AttachToViewmodel(self.HandsModel)
		end

		self.HandsModel:SetupBones()
		self.HandsModel:DrawModel()

		hands:SetupBones()
		hands:DrawModel()
	end
end

function SWEP:GetViewModelBlend(pos, ang, data)
	local holsterFrac = self:GetInterpHolster()
	local sprintFrac = self:GetInterpSprint()
	local aimFrac = self:GetInterpAim()

	if self:ForceUnscope() then
		local frac = self:GetFireFraction()
		local val = math.RemapC(frac, 0.1, 0.5, 1, 0) + math.RemapC(frac, 0.5, 0.9, 0, 1)

		aimFrac = math.min(aimFrac, val)
	end

	local holsterLerp = math.ease.InOutQuad(holsterFrac)

	if self:GetDeployTime() != 0 and self:GetHolstered() then
		holsterLerp = math.Clamp(math.ease.InOutQuad(math.TimeFraction(self:GetDeployTime(), self:GetNextIdle(), CurTime())), 0, 1)
	end

	local holsterPos = data.Holster.Pos * holsterLerp
	local holsterAng = data.Holster.Ang * holsterLerp

	local sprintLerp = math.ease.InOutQuad(math.Clamp(sprintFrac - holsterFrac, 0, 1))

	local sprintPos = data.Sprint.Pos * sprintLerp
	local sprintAng = data.Sprint.Ang * sprintLerp

	local aimLerp = math.ease.InOutCubic(math.Clamp(aimFrac - holsterFrac - sprintFrac, 0, 1))

	local aimPos = data.Aim.Pos * aimLerp
	local aimAng = data.Aim.Ang * aimLerp

	local defLerp = math.ease.InOutQuad(math.Clamp(1 - holsterFrac - sprintFrac - aimFrac, 0, 1))

	local defPos = data.Default.Pos * defLerp
	local defAng = data.Default.Ang * defLerp

	return LocalToWorld(defPos + aimPos + holsterPos + sprintPos, defAng + aimAng + holsterAng + sprintAng, pos, ang)
end

function SWEP:GetViewModelPosition(pos, ang)
	local val = self:GetInterpAlt()

	local frac = math.ease.InOutBack(val)
	local frac2 = math.ease.InOutCubic(val)

	local basePos, baseAng = self:GetViewModelBlend(pos, ang, self.BaseOffsets)
	local altPos, altAng = self:GetViewModelBlend(pos, ang, self.AltOffsets)

	return LerpVector(frac, basePos, altPos), LerpAngle(frac2, baseAng, altAng) + self:GetOwner():GetViewPunchAngles()
end

function SWEP:CreateWorldModel()
	self.WorldCSEnt = ClientsideModel(self.WorldModel, RENDERGROUP_OTHER)

	if not IsValid(self.WorldCSEnt) then
		return false
	end

	self.WorldCSEnt:SetNoDraw(true)

	for k, v in pairs(self.Bodygroups) do
		model.SetNumBodygroup(self.WorldCSEnt, k, v)
	end

	local submaterials = self.SubMaterials

	if self.SubMaterialsWM then
		submaterials = self.SubMaterialsWM
	end

	model.SetSubMaterials(self.WorldCSEnt, submaterials)

	return true
end

function SWEP:DrawWorldModel()
	local ply = self:GetOwner()

	if self.WorldModel == "" then
		return
	end

	if not IsValid(self.WorldCSEnt) then
		local ok = self:CreateWorldModel()

		if not ok then
			return -- Some weird shit going on
		end
	end

	if self.FixWorldModel and IsValid(ply) then
		local hand = ply:LookupBone("ValveBiped.Bip01_R_Hand")

		if hand then
			local pos, ang

			local matrix = ply:GetBoneMatrix(hand)

			if matrix then
				pos, ang = matrix:GetTranslation(), matrix:GetAngles()
			else
				pos, ang = ply:GetBonePosition(hand)
			end

			pos = pos + (ang:Forward() * self.FixWorldModel.pos.x) + (ang:Right() * self.FixWorldModel.pos.y) + (ang:Up() * self.FixWorldModel.pos.z)

			ang:RotateAroundAxis(ang:Up(), self.FixWorldModel.ang.p)
			ang:RotateAroundAxis(ang:Right(), self.FixWorldModel.ang.y)
			ang:RotateAroundAxis(ang:Forward(), self.FixWorldModel.ang.r)

			self.WorldCSEnt:SetRenderOrigin(pos)
			self.WorldCSEnt:SetRenderAngles(ang)

			self.WorldCSEnt:SetModelScale(self.FixWorldModel.scale or 1, 0)
		end
	else
		self.WorldCSEnt:SetParent(IsValid(ply) and ply or self)
		self.WorldCSEnt:AddEffects(EF_BONEMERGE)
	end

	self.WorldCSEnt:SetupBones()
	self.WorldCSEnt:DrawModel()
	self.WorldCSEnt:CreateShadow()
end

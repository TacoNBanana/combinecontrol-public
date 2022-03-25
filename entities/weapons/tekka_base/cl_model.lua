SWEP.CSModels = {}

-- Cleans up any CS models attached to the entity
function SWEP:RemoveManagedCSModels()
	for _, v in pairs(self.CSModels) do
		if IsValid(v) then
			v:Remove()
		end
	end
end

-- Attaches a CS model to the entity, cleaning it up when we remove the weapon
function SWEP:CreateManagedCSModel(mdl, rendergroup)
	local ent = ClientsideModel(mdl, rendergroup or RENDERGROUP_OTHER)

	table.insert(self.CSModels, ent)

	return ent
end

-- Sets up our custom VM
function SWEP:SetupCustomVM(mdl)
	if IsValid(self.VM) then
		self.VM:Remove()
	end

	self.VM = self:CreateManagedCSModel(mdl, RENDERGROUP_BOTH)
	self.VM:SetNoDraw(true)
	self.VM:SetupBones()

	self:SetupVMMaterials()

	-- Inverting the model itself
	if self.ViewModelFlip then
		local matrix = Matrix()

		matrix:Scale(Vector(1, -1, 1))

		self.VM:EnableMatrix("RenderMultiply", matrix)
	end

	if self.UseBolt then
		self.BoltBoneID = self.VM:LookupBone(self.BoltBone)
	end
end

function SWEP:SetupVMMaterials()
	local vm = self.VM

	if not IsValid(vm) then
		return
	end

	if istable(self.VMSubMaterials) then
		for k, v in pairs(self.VMSubMaterials) do
			if not isnumber(k) then
				continue
			end

			if isstring(v) then
				vm:SetSubMaterial(k, v)
			else
				vm:SetSubMaterial(k, "engine/occlusionproxy")
			end
		end
	else
		vm:SetMaterial(self.VMSubMaterials)
	end

	for k, v in pairs(self.VMBodyGroups) do
		if not isnumber(k) then
			continue
		end

		vm:SetBodygroup(k, v)
	end
end

-- Actually draws the custom VM
function SWEP:DrawVM()
	if self.ViewModelFlip then
		render.CullMode(MATERIAL_CULLMODE_CW)
	end

	if not IsValid(self.VM) then
		return
	end

	self.VM:FrameAdvance(FrameTime())
	self.VM:SetupBones()
	self.VM:DrawModel()

	-- Drawing hands
	if self.UseHands then
		local ply = self.Owner
		local hands = ply:GetHands()

		if IsValid(hands) then
			if hands:GetParent() != self.VM then
				hands:AttachToViewmodel(self.VM)
			end

			hands:SetupBones()
			hands:DrawModel()
		end
	end

	render.CullMode(MATERIAL_CULLMODE_CCW)
end

-- Handles drawing the viewmodel and any attached extras
function SWEP:PostDrawViewModel()
	if not IsValid(self.VM) then
		return
	end

	self:HandleVMOffsets()
	self:ApplyVMOffsets()
	self:DrawVM()
	self:DrawVMSCK()
	self:DrawAimpoint()
end
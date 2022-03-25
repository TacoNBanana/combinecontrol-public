compound = compound or {}

function compound.SetupModel(model, data)
	if not IsValid(model) then
		return
	end

	model:SetNoDraw(data.hide)
	model.hidden = data.hide

	model:SetModel(data.model)
	model:SetSkin(data.skin or 0)

	for _, v in pairs(model:GetBodyGroups()) do
		model:SetBodygroup(v.id, data["bg_" .. v.name] or 0)
	end

	for i = 0, #model:GetMaterials() - 1 do
		local mat = data["submaterial" .. i]

		model:SetSubMaterial(i, mat)
	end

	model:SetColor(data.color or Color(255, 255, 255))
end

function compound.HideCompoundModel(parent, state)
	if parent.CompoundHiddenState == state then
		return
	end

	local bodyEnt = parent.CompoundBody
	local extEnt = parent.CompoundExt

	if IsValid(bodyEnt) then
		bodyEnt:SetNoDraw(bodyEnt.hidden or state)
	end

	if IsValid(extEnt) then
		extEnt:SetNoDraw(extEnt.hidden or state)
	end

	parent.CompoundHiddenState = state
end

function compound.SetCompoundModel(parent, headData, bodyData, extData)
	local func = CLIENT and compound.CreateClientAttachment or compound.CreateAttachment

	if bodyData.model then
		parent.CompoundBody = parent.CompoundBody or func(parent)
	elseif IsValid(parent.CompoundBody) then
		parent.CompoundBody:Remove()
		parent.CompoundBody = nil
	end

	if extData.model then
		parent.CompoundExt = parent.CompoundExt or func(parent)
	elseif IsValid(parent.CompoundExt) then
		parent.CompoundExt:Remove()
		parent.CompoundExt = nil
	end

	parent.CompoundStoredHead = headData
	compound.SetupModel(parent, headData)

	parent.CompoundStoredBody = bodyData
	compound.SetupModel(parent.CompoundBody, bodyData)

	parent.CompoundStoredExt = extData
	compound.SetupModel(parent.CompoundExt, extData)

	parent.CompoundHiddenState = false

	if SERVER then
		if parent:IsPlayer() then
			if IsValid(parent.CompoundBody) then
				parent:SetCompoundBodyEnt(parent.CompoundBody:EntIndex())
			else
				parent:SetCompoundBodyEnt(-1)
			end

			if IsValid(parent.CompoundExt) then
				parent:SetCompoundExtEnt(parent.CompoundExt:EntIndex())
			else
				parent:SetCompoundExtEnt(-1)
			end
		else
			if IsValid(parent.CompoundBody) then
				parent:SetNWInt("CompoundBody", parent.CompoundBody:EntIndex())
			else
				parent:SetNWInt(-1)
			end

			if IsValid(parent.CompoundExt) then
				parent:SetNWInt("CompoundExt", parent.CompoundExt:EntIndex())
			else
				parent:SetNWInt(-1)
			end
		end
	end
end

function compound.CopyCompoundModel(from, to)
	if not from.CompoundStoredHead or not from.CompoundStoredBody or not from.CompoundStoredExt then
		return false
	end

	compound.SetCompoundModel(to, from.CompoundStoredHead, from.CompoundStoredBody, from.CompoundStoredExt)

	return true
end
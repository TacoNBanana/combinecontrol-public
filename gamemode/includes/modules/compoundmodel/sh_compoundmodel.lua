compound = compound or {}

function compound.SetupModel(ent, data)
	if not IsValid(ent) then
		return
	end

	if ent:GetClass() == "cc_attachment" then
		ent:SetModelSlot(data.slot)
	end

	if data.hide then
		ent:SetNoDraw(data.hide)
		ent.hidden = data.hide
	end

	ent:SetModel(data.model)
	ent:SetSkin(data.skin or 0)

	if CLIENT then
		ent:SetupBones()
	end

	for _, v in pairs(ent:GetBodyGroups()) do
		ent:SetBodygroup(v.id, 0)
	end

	if data.bodygroups then
		for k, v in pairs(data.bodygroups) do
			model.SetNumBodygroup(ent, k, v)
		end
	end

	model.SetSubMaterials(ent, data.materials or {})

	ent:SetColor(data.color or Color(255, 255, 255))
end

function compound.HideCompoundModel(parent, state)
	if parent.CompoundHiddenState == state then
		return
	end

	for _, v in pairs(parent:GetChildren()) do
		if v:GetClass() != "cc_attachment" and v:GetClass() != "class C_BaseFlex" then
			continue
		end

		v:SetNoDraw(v.hidden or state)
	end

	parent.CompoundHiddenState = state
end

function compound.SetCompoundModel(parent, ...)
	local func = CLIENT and compound.CreateClientAttachment or compound.CreateAttachment

	parent.Compound = {}

	if SERVER then
		for _, v in pairs(parent:GetChildren()) do
			if v:GetClass() != "cc_attachment" then
				continue
			end

			v:Remove()
		end
	end

	for k, v in pairs({...}) do
		parent.Compound[k] = v

		if k == 1 then
			compound.SetupModel(parent, v)
		else
			compound.SetupModel(func(parent), v)
		end
	end

	parent.CompoundHiddenState = false
end

function compound.CopyCompoundModel(from, to)
	if from.Compound then
		compound.SetCompoundModel(to, unpack(from.Compound))
	else
		compound.SetCompoundModel(to, nil)
	end
end

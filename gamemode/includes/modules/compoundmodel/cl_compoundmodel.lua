compound = compound or {}

function compound.CreateClientAttachment(parent)
	local ent = ClientsideModel("models/Kleiner.mdl")

	ent:SetNoDraw(true)
	ent:SetParent(parent)
	ent:AddEffects(bit.bor(EF_BONEMERGE, EF_BONEMERGE_FASTCULL, EF_PARENT_ANIMATES))
	ent.Identifier = "compound_attach_" .. util.UID()

	parent:CallOnRemove(ent.Identifier, function(self, csent)
		if IsValid(csent) then
			csent:Remove()
		end
	end, ent)

	return ent
end

function compound.SetupModelPanel(pnl, ent, copy)
	compound.CopyCompoundModel(ent, pnl.Entity)

	if copy then
		local base = pnl.Entity.Compound[1]

		if not base then
			base = {}
			pnl.Entity.Compound[1] = base
		end

		base.model = ent:GetModel()
		base.skin = ent:GetSkin()
		base.bodygroups = {}

		for _, v in pairs(ent:GetBodyGroups()) do
			local index = ent:GetBodygroup(v.id)

			if index != 0 then
				base.bodygroups[v.name] = index
			end
		end

		compound.SetCompoundModel(pnl.Entity, unpack(pnl.Entity.Compound))
	end

	compound.HideCompoundModel(pnl.Entity, true)

	pnl.Entity:SetNoDraw(true)

	pnl.PreDrawModel = compound.DrawClientAttachments
end

function compound.DrawClientAttachments(_, ent)
	ent:DrawModel()

	for _, v in pairs(ent:GetChildren()) do
		if v:GetClass() != "class C_BaseFlex" then
			continue
		end

		v:DrawModel()
	end

	return false
end

hook.Add("OnEntityCreated", "CL.CompoundModel.OnEntityCreated", function(ent)
	if ent:IsPlayer() then
		net.Start("nRequestCompoundModel")
			net.WriteEntity(ent)
		net.SendToServer()
	end
end)

net.Receive("nCompoundModelUpdate", function(len)
	local ent = net.ReadEntity()
	local num = net.ReadUInt(6)

	if not IsValid(ent) then
		return
	end

	ent.Compound = {}

	for i = 1, num do
		ent.Compound[i] = net.ReadTable()
	end
end)

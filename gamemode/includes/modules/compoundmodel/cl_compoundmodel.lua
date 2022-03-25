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

function compound.SetupModelPanel(pnl, ent)
	if ent:IsPlayer() then
		local flag = ent:GetCharFlag()

		if flag and flag.ModelFunc then
			return
		end
	end

	compound.CopyCompoundModel(ent, pnl.Entity)
	compound.HideCompoundModel(pnl.Entity, true)

	pnl.Entity:SetNoDraw(true)

	pnl.PreDrawModel = compound.DrawClientAttachments
end

function compound.DrawClientAttachments(_, ent)
	local body = ent.CompoundBody
	local ext = ent.CompoundExt

	ent:DrawModel()

	if IsValid(body) and not body.hidden then
		body:DrawModel()
	end

	if IsValid(ext) and not ext.hidden then
		ext:DrawModel()
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
	local head = net.ReadTable()
	local body = net.ReadTable()
	local ext = net.ReadTable()

	ent.CompoundStoredHead = head
	ent.CompoundStoredBody = body
	ent.CompoundStoredExt = ext
end)
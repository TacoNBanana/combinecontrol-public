local meta = FindMetaTable("Player")

compound = compound or {}

function compound.CreateAttachment(parent)
	local ent = ents.Create("cc_attachment")
	ent:SetModel("models/Kleiner.mdl")

	ent:Spawn()

	ent:SetParent(parent)
	ent:AddEffects(EF_BONEMERGE)

	parent:DeleteOnRemove(ent)

	return ent
end

function meta:RecalculatePlayerModel()
	local data = {}

	for k, v in pairs(self.Equipment) do
		if not v.ModelData then
			continue
		end

		data[k] = v:GetModelData(self)
	end

	local flag = self:GetCharFlag()
	local mdl = self.CharModel or Model("models/tnb/techcom/male_07.mdl")
	local charskin = self.CharSkin or 0

	local headData = {}
	local bodyData = {}
	local extData = {}

	if flag and flag.ModelFunc then
		mdl, charskin = flag.ModelFunc(self)
	else
		bodyData.model = self:IsFemale() and Model("models/tnb/zrp/female_tshirt.mdl") or Model("models/tnb/zrp/male_tshirt.mdl")
	end

	headData.model = mdl
	headData.skin = charskin

	table.Merge(headData, data[EQUIPMENT_HEAD] or {})
	table.Merge(headData, data[EQUIPMENT_MASK] or {})

	table.Merge(bodyData, data[EQUIPMENT_CHEST] or {})

	table.Merge(extData, data[EQUIPMENT_EXO] or {})

	compound.SetCompoundModel(self, headData, bodyData, extData)

	if GAMEMODE.DarkSkinnedModels[mdl] then
		local body = self.CompoundBody

		if IsValid(body) then
			for k, v in pairs(body:GetMaterials()) do
				if GAMEMODE.DarkSkinnedReplacements[v] then
					body:SetSubMaterial(k - 1, GAMEMODE.DarkSkinnedReplacements[v])
				end
			end
		end
	end

	net.Start("nCompoundModelUpdate")
		net.WriteEntity(self)
		net.WriteTable(headData)
		net.WriteTable(bodyData)
		net.WriteTable(extData)
	net.Broadcast()
end

hook.Add("CC.SV.PlayerThink", "SV.CompoundModel.PlayerThink", function(ply)
	if not ply:Alive() and not ply.CompoundHiddenState then
		local ragdoll = ply:GetRagdollEntity()

		if not IsValid(ragdoll) or ragdoll.CompoundSetup then
			return
		end

		compound.CopyCompoundModel(ply, ragdoll)
		ragdoll.CompoundSetup = true
	end

	local flag = ply:GetCharFlag()

	if flag and flag.ModelFunc then
		compound.HideCompoundModel(ply, true)
	else
		compound.HideCompoundModel(ply, ply:GetNoDraw() or not ply:Alive())
	end
end)

hook.Add("CC.SV.PlayerSpawn", "SV.CompoundModel.PlayerSpawn", function(ply)
	-- For some reason the compound model entities get unhidden on spawn, so reset the flag in-case the system needs to hide us again
	ply.CompoundHiddenState = false
end)

net.Receive("nRequestCompoundModel", function(len, ply)
	local ent = net.ReadEntity()

	if not ent.CompoundStoredHead or not ent.CompoundStoredBody or not ent.CompoundStoredExt then
		return
	end

	net.Start("nCompoundModelUpdate")
		net.WriteEntity(ent)
		net.WriteTable(ent.CompoundStoredHead)
		net.WriteTable(ent.CompoundStoredBody)
		net.WriteTable(ent.CompoundStoredExt)
	net.Send(ply)
end)
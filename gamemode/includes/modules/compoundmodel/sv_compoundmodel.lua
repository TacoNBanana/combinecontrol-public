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

function meta:RecalculatePlayerModel(weapon)
	local flag = self:GetCharFlag()
	local mdl = self.CharModel or Model("models/tnb/techcom/male_07.mdl")
	local charskin = self.CharSkin or 0

	local data

	if flag and flag.ModelFunc then
		data = flag.ModelFunc(self)
	else
		data = {
			head = {
				model = mdl,
				skin = charskin
			},
			body = {
				model = string.format("models/tnb/clothing/trp/body/%s_survivor.mdl", self:Gender(mdl))
			}
		}
	end

	if self.Equipment then
		for _, v in pairs(self.Equipment) do
			if v.GetModelData then
				v:GetModelData(self, data)
			end
		end

		for _, v in pairs(self.Equipment) do
			if v.PostGetModelData then
				v:PostGetModelData(self, data)
			end
		end
	end

	if IsValid(weapon) and weapon.GetModelData then
		weapon:GetModelData(self, data)
	end

	local sorted = {}

	for k, v in pairs(data) do
		v.slot = k

		if k == "head" then
			table.insert(sorted, 1, v)
		else
			table.insert(sorted, v)
		end
	end

	compound.SetCompoundModel(self, unpack(sorted))

	net.Start("nCompoundModelUpdate")
		net.WriteEntity(self)
		net.WriteUInt(#self.Compound, 6)

		for _, v in pairs(self.Compound) do
			net.WriteTable(v)
		end
	net.Broadcast()

	self:UpdateHull()
end

hook.Add("CC.SV.PlayerThink", "SV.CompoundModel.PlayerThink", function(ply)
	if not ply:Alive() and not ply.CompoundHiddenState then
		local ragdoll = ply:GetRagdollEntity()

		if IsValid(ragdoll) and not ragdoll.CompoundSetup then
			compound.CopyCompoundModel(ply, ragdoll)
			ragdoll.CompoundSetup = true
		end
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

	if not ent.Compound then
		return
	end

	net.Start("nCompoundModelUpdate")
		net.WriteEntity(ent)
		net.WriteUInt(#ent.Compound, 6)

		for _, v in pairs(ent.Compound) do
			net.WriteTable(v)
		end
	net.Send(ply)
end)

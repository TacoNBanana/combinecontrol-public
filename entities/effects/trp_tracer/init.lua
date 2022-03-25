function EFFECT:Init(data)
	local ed = EffectData()
	local ent = data:GetEntity()

	if not IsValid(ent) then
		return
	end

	if ent:GetOwner() == LocalPlayer() and not LocalPlayer():ShouldDrawLocalPlayer() then
		ent = LocalPlayer():GetViewModel()
	else
		ent = IsValid(ent.WorldCSEnt) and ent.WorldCSEnt or ent
	end

	if not IsValid(ent) then
		return
	end

	ed:SetEntity(ent)
	ed:SetFlags(data:GetFlags())
	ed:SetOrigin(data:GetOrigin())
	ed:SetStart(ent:GetAttachment(data:GetAttachment()).Pos)
	ed:SetScale(10000)

	util.Effect("tracer", ed)
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end

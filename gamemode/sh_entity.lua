local meta = FindMetaTable("Entity")

function game.GetDoors()
	local tab = {}

	for _, v in pairs(ents.GetAll()) do

		if v.IsDoor and v:IsDoor() then

			table.insert(tab, v)

		end

	end

	return tab
end

function meta:CopyBodygroups(ent)
	for i = 0, 8 do
		self:SetBodygroup(i, ent:GetBodygroup(i))
	end
end

function GM:EntityEmitSound(data)
	if not data then return end

	local ent = data.Entity
	if not ent or not IsValid(ent) then return end

	if data.Entity:GetModel() == "models/hunter.mdl" or data.Entity:GetModel() == "models/tnb/combine/synth_soldier.mdl" then

		if string.match(data.SoundName, "player/footsteps/") then
			local soundData = sound.GetProperties("NPC_Hunter.Footstep")

			data.SoundName = soundData.sound[math.Round(math.random(1,3))]
			data.Channel = soundData.channel
			data.SoundLevel = soundData.level
			data.Pitch = soundData.pitch
			data.Volume = soundData.volume

			return true
		end
	end
end

if CLIENT then
	hook.Add("NetworkEntityCreated", "SH.Entity.NetworkEntityCreated", function(ent)
		if ent:IsNPC() then
			net.Start("nRequestNPCData")
				net.WriteEntity(ent)
			net.SendToServer()
		end

		if ent:GetClass() == "prop_physics" then
			net.Start("nRequestPropData")
				net.WriteEntity(ent)
			net.SendToServer()
		end
	end)
end
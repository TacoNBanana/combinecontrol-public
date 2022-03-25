GM.ServerConnectIDs = {}

hook.Add("CC.SH.InitEnts", "SV.Map.InitEnts", function()
	local ent = ents.FindByClass("func_dustmotes")

	for k, v in pairs(ent) do
		v:Remove()
	end

	GAMEMODE.FilterDamage = ents.Create("filter_activator_name")
	GAMEMODE.FilterDamage:SetKeyValue("TargetName", "CCFilterDamage")
	GAMEMODE.FilterDamage:SetKeyValue("negated", "1")
	GAMEMODE.FilterDamage:Spawn()

	GAMEMODE:SpawnSavedProps()

	if #ents.FindByClass("cc_loadoutcrate") == 0 and GAMEMODE.LoadoutCrates then
		for _, v in pairs(GAMEMODE.LoadoutCrates) do
			local e = ents.Create("cc_loadoutcrate")
			e:SetPos(v[1])
			e:SetAngles(v[2])
			e:Spawn()
			e:Activate()
		end
	end

	if GAMEMODE.EntNamesToRemove then
		for _, v in pairs(GAMEMODE.EntNamesToRemove) do
			local tab = ents.FindByName(v)

			for _, e in pairs(tab) do
				e:Remove()
			end
		end
	end

	if GAMEMODE.EntPositionsToRemove then
		for _, v in pairs(GAMEMODE.EntPositionsToRemove) do
			local tab = ents.FindInBox(v, v)

			for _, e in pairs(tab) do
				if not table.HasValue(GAMEMODE.MapProtectedClasses, e:GetClass()) then
					e:Remove()
				end
			end
		end
	end

	if GAMEMODE.MapInitPostEntity then
		GAMEMODE:MapInitPostEntity()
	end

	if GAMEMODE.Microphones then
		for _, v in pairs(GAMEMODE.Microphones) do
			local speaker = ents.Create("info_target")
			speaker:SetPos(v[1])
			speaker:SetName("speaker_" .. speaker:EntIndex())
			speaker:Spawn()
			speaker:Activate()

			local mic = ents.Create("env_microphone")
			mic:SetPos(v[1])
			mic:SetName("cc_microphones")
			mic:SetKeyValue("MaxRange", "320")
			mic:SetKeyValue("Sensitivity", "3")
			mic:SetKeyValue("spawnflags", "0")
			mic:SetKeyValue("speaker_dsp_preset", tostring(v[2]))
			mic:SetKeyValue("SpeakerName", "speaker_" .. speaker:EntIndex())
			mic:SetKeyValue("target", "cc_micsamplepoint")
			mic:Spawn()
			mic:Activate()
			mic:Fire("Enable")
		end
	end

	if GAMEMODE.MapChairs then
		for _, v in pairs(GAMEMODE.MapChairs) do
			local chair = ents.Create("prop_vehicle_prisoner_pod")
			chair:SetPos(v[1])
			chair:SetAngles(v[2])
			chair:SetModel("models/nova/airboat_seat.mdl")
			chair:SetKeyValue("vehiclescript", "scripts/vehicles/prisoner_pod.txt")
			chair:SetKeyValue("limitview", "0")
			chair:Spawn()
			chair:Activate()
			chair:SetNoDraw(true)
			chair:GetPhysicsObject():EnableMotion(false)
			chair:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
			chair.Static = true
		end
	end

	if GAMEMODE.Stoves then
		for _, v in pairs(GAMEMODE.Stoves) do
			local stove = ents.Create("cc_stove")
			stove:SetPos(v[1])
			stove:SetAngles(v[2])

			if v[3] then
				stove:SetBuilding(v[3])
			end

			if v[5] then
				stove:SetModel(v[5])
			end

			stove:Spawn()
			stove:Activate()
			stove:GetPhysicsObject():EnableMotion(false)
			stove.Static = true

			if not v[4] then
				stove:SetInvisible(true)
			end
		end
	end

	if GAMEMODE.VendingMachines then
		for _, v in pairs(GAMEMODE.VendingMachines) do
			local vmachine = ents.Create("cc_vendingmachine")
			vmachine:SetPos(v[1])
			vmachine:SetAngles(v[2])

			vmachine:Spawn()
			vmachine:Activate()
			vmachine:GetPhysicsObject():EnableMotion(false)
			vmachine.Static = true
		end
	end

	if not GAMEMODE.EnableAreaportals then
		local ent = ents.FindByClass("func_areaportalwindow")

		for k, v in pairs(ent) do
			v:Fire("SetFadeStartDistance", "99999", 0)
			v:Fire("SetFadeEndDistance", "99999", 0)
		end

		local ent = ents.FindByClass("func_areaportal")

		for k, v in pairs(ent) do
			v:Fire("Open")
			v:SetKeyValue("target", "")
			v:SetSaveValue("target", "")
		end
	end

	if GAMEMODE.DoorData then
		local function setupDoor(ent, data)
			ent:SetDoorType(data[2] or DOOR_UNBUYABLE)
			ent:SetDoorOriginalName(data[3] or "")
			ent:SetDoorName(data[3] or "")
			ent:SetDoorPrice(data[4] or 0)
			ent:SetDoorBuilding(data[5] or "")
		end

		local ent, enttab

		for _, v in pairs(GAMEMODE.DoorData) do
			local succ = false

			if TypeID(v[1]) == TYPE_VECTOR then
				local enttab = ents.FindInBox(v[1], v[1])

				for i = 1, #enttab do
					ent = enttab[i]

					if ent:IsDoor() then
						setupDoor(ent, v)

						succ = true
						break
					end
				end
			else
				local ent = ents.GetMapCreatedEntity(v[1])

				if ent:IsDoor() then
					setupDoor(ent, v)

					succ = true
				end
			end

			if not succ then
				local str = TypeID(v[1]) == TYPE_NUMBER and "entity with map creation ID: " or ""

				GAMEMODE:LogBug("Warning: Invalid doordata entry at " .. str .. tostring(v[1]) .. ".", true)
			end
		end
	end

	if GAMEMODE.CameraData then
		for _, v in pairs(GAMEMODE.CameraData) do
			local pos, ang, id, nodamage = v[1], v[2], v[3], v[4] or false
			local entlist = ents.FindInBox(pos, pos)

			for _, ent in pairs(entlist) do
				if ent:GetClass() == "npc_combine_camera" then
					ent:Remove()

					break
				end
			end

			local camera = ents.Create("npc_combine_camera")
			camera:SetPos(pos)
			camera:SetAngles(ang)
			camera:Spawn()
			camera:Activate()

			camera:SetNWString("camname", id)

			if nodamage then
				camera.NoDamage = true
			end
		end
	end

	local ent = ents.FindByClass("weapon_*")

	for k, v in pairs(ent) do
		v:Remove()
	end

	hook.Remove("PlayerTick", "TickWidgets")
end)

GM.MapProtectedClasses = {
	"move_rope",
	"keyframe_rope",
}

function GM:EntityKeyValue(ent, key, value)
	if key == "cc_static" and value == "1" then
		ent.Static = true
	end

	return self.BaseClass:EntityKeyValue(ent, key, value)
end

GM.ChairModels = {
	{
		"models/props_c17/furniturecouch001a.mdl",
		{
			Vector(4.375, -13.21875, -3.25),
			Angle(0, -90, 0)
		},
		{
			Vector(4.71875, 14.1875, -2.96875),
			Angle(0, -90, 0)
		},
	},
	{
		"models/props_c17/furniturechair001a.mdl",
		{
			Vector(-0.78111809492111, -0.34404960274696, -7.125),
			Angle(-0, -90, 0)
		},
	},
	{
		"models/props_c17/furniturecouch002a.mdl",
		{
			Vector(4.1000366210938, 9.5060768127441, -5.5312490463257),
			Angle(0, -90, 0)
		},
		{
			Vector(3.1263382434845, -10.095077514648, -5.7187495231628),
			Angle(0, -90, 0)
		},
	},
	{
		"models/props_c17/chair02a.mdl",
		{
			Vector(16.85528755188, 4.6713724136353, 1.0366483926773),
			Angle(0, -90, 0)
		},
	},
	{
		"models/props_combine/breenchair.mdl",
		{
			Vector(5.8337116241455, 0.83913016319275, 15.375),
			Angle(0, -90, 0)
		},
	},
	{
		"models/props_interiors/furniture_chair01a.mdl",
		{
			Vector(0.44139209389687, 0.30659884214401, -3.2190895080566),
			Angle(0, -90, 0)
		},
	},
	{
		"models/props_interiors/furniture_chair03a.mdl",
		{
			Vector(3.381739616394, -0.23042333126068, -3.125),
			Angle(0, -90, 0)
		},
	},
	{
		"models/props_interiors/furniture_couch01a.mdl",
		{
			Vector(5.4747152328491, -17.027050018311, -9.2542018890381),
			Angle(0, -90, 0)
		},
		{
			Vector(7.451247215271, 14.411973953247, -8.4119672775269),
			Angle(0, -90, 0)
		},
	},
	{
		"models/props_interiors/furniture_couch02a.mdl",
		{
			Vector(3.9066781997681, 0.275255382061, -8.3124990463257),
			Angle(0, -90, 0)
		},
	},
	{
		"models/chairs/armchair.mdl",
		{
			Vector(3.9262285232544, 0.32051900029182, 33.268924713135),
			Angle(0, -90, 0)
		},
	},
	{
		"models/props_wasteland/controlroom_chair001a.mdl",
		{
			Vector(-0.09375, 0.09375, -4.78125),
			Angle(0, -90, 0)
		},
	},
	{
		"models/props_c17/chair_stool01a.mdl",
		{
			Vector(-4.9375, -0.25, 33.78125),
			Angle(0, -90, 1)
		},
	}
}

function GM:MultiplyMicrophone(name, n)
	for _, v in pairs(ents.FindByName(name)) do

		for i = 1, n do

			local mic = ents.Create("env_microphone")
			mic:SetPos(v:GetPos())
			mic:SetName(v:GetName())
			mic:SetKeyValue("MaxRange", v:GetSaveTable().MaxRange)
			mic:SetKeyValue("Sensitivity", v:GetSaveTable().Sensitivity)
			mic:SetKeyValue("spawnflags", v:GetSaveTable().spawnflags)
			mic:SetKeyValue("speaker_dsp_preset", v:GetSaveTable().speaker_dsp_preset)
			mic:SetKeyValue("SpeakerName", v:GetSaveTable().SpeakerName)
			mic:SetKeyValue("target", v:GetSaveTable().target)
			mic:Spawn()
			mic:Activate()

		end

	end
end

hook.Add("OnEntityCreated", "SV.Map.OnEntityCreated", function(ent)
	timer.Simple(0, function()
		if not IsValid(ent) then
			return
		end

		if ent:IsNPC() and ent:GetClass() == "npc_combine_s" and IsValid(ent:GetActiveWeapon()) and ent:GetActiveWeapon():GetClass() == "weapon_shotgun" then
			ent:SetSkin(1)
		end

		for _, v in pairs(GAMEMODE.ChairModels) do
			if ent:GetModel() and string.lower(ent:GetModel()) == v[1] then
				ent.Chairs = {}
				ent:SetUseType(SIMPLE_USE)

				for k, n in pairs(v) do
					if k > 1 then
						local chair = ents.Create("prop_vehicle_prisoner_pod")
						chair:SetPos(ent:LocalToWorld(n[1]))
						chair:SetAngles(ent:LocalToWorldAngles(n[2]))
						chair:SetModel("models/nova/airboat_seat.mdl")
						chair:SetKeyValue("vehiclescript", "scripts/vehicles/prisoner_pod.txt")
						chair:SetKeyValue("limitview", "0")
						chair:Spawn()
						chair:Activate()
						chair:SetNoDraw(true)
						chair:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
						chair:GetPhysicsObject():EnableCollisions(false)
						chair.Static = true
						chair:SetParent(ent)

						table.insert(ent.Chairs, chair)
					end
				end

				break
			end
		end

		if ent:GetName() == "cc_replace_stove" then
			local stove = ents.Create("cc_stove")
			stove:SetPos(ent:GetPos())
			stove:SetAngles(ent:GetAngles())
			stove:SetInvisible(false)

			if ent:GetSaveTable().DefaultAnim then
				stove:SetBuilding(ent:GetSaveTable().DefaultAnim)
			end

			stove:Spawn()
			stove:Activate()
			stove:SetModel(ent:GetModel())
			stove:GetPhysicsObject():EnableMotion(false)
			stove.Static = true

			ent:Remove()
		end
	end)
end)

function GM:SetupPlayerVisibility(ply, viewent)
	if self.GetHL2CamPos and ply.CharCreate then

		AddOriginToPVS(self:GetHL2CamPos()[1])

	end

	if self.GetCACamPos then

		AddOriginToPVS(self:GetCACamPos())

	end

	local camera = ply:CombineCamera()

	if IsValid(camera) then

		AddOriginToPVS(camera:GetPos())

	end
end

function GM:CreateMicrowave(pos, ang, broken, char)
	local prop = ents.Create("cc_stove")
	prop:SetPos(pos)
	prop:SetAngles(ang)
	prop:Spawn()
	prop:Activate()
	prop:SetDeployer(char)

	prop:SetModel("models/props_c17/tv_monitor01.mdl")
	prop:PhysicsInit(SOLID_VPHYSICS)
	prop:GetPhysicsObject():Wake()

	return prop
end

function GM:CreateWorkbench(pos, ang, char)
	local prop = ents.Create("cc_workbench")
	prop:SetPos(pos)
	prop:SetAngles(ang)
	prop:Spawn()
	prop:Activate()
	prop:SetDeployer(char)

	prop:PhysicsInit(SOLID_VPHYSICS)
	prop:GetPhysicsObject():Wake()

	return prop
end

GM.ConnectMessages = {}
GM.EntryPortSpawns = {}

local files = file.Find(GM.FolderName .. "/gamemode/maps/" .. game.GetMap() .. ".lua", "LUA", "namedesc")

if #files > 0 then

	for _, v in pairs(files) do

		include("maps/" .. v)
		AddCSLuaFile("maps/" .. v)

	end

	MsgC(Color(200, 200, 200, 255), "Serverside map lua file for " .. game.GetMap() .. " loaded.\n")

else

	MsgC(Color(200, 200, 200, 255), "Warning: No serverside map lua file for " .. game.GetMap() .. ".\n")
end

-- FUCK OFF
GM.CurrentLocation = LOCATION_CITY
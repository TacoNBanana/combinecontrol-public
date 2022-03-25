local meta = FindMetaTable("Player")

GM.GlobalVariables = {
	{"OOCDelay", 			"Float", 	0},
	{"Flashlight",			"Float",	1},
	{"Spawners", 			"Table", 	{}}
}

for k, v in pairs(GM.GlobalVariables) do

	GM["Set" .. v[1]] = function(self, val)

		if CLIENT then return end

		if self[v[1] .. "Val"] == val and v[2] != "Table" then return end

		self[v[1] .. "Val"] = val

		net.Start("nSet" .. v[1])
			net["Write" .. v[2]](val)
		net.Broadcast()

	end

	GM[v[1]] = function(self)

		if self[v[1] .. "Val"] == false then

			return false

		end

		return self[v[1] .. "Val"] or v[3]

	end

	if SERVER then

		util.AddNetworkString("nSet" .. v[1])

	else

		local function nRecvData(len)

			local val = net["Read" .. v[2]]()

			if v[2] == "Bit" then
				val = tobool(val)
			end

			GAMEMODE[v[1] .. "Val"] = val

		end
		net.Receive("nSet" .. v[1], nRecvData)

	end
end

function meta:SyncAllGlobalData()
	for _, n in pairs(GAMEMODE.GlobalVariables) do

		net.Start("nSet" .. n[1])
			net["Write" .. n[2]](GAMEMODE[n[1]](GAMEMODE))
		net.Send(self)

	end
end

function GM:GetMaps()
	local maps = file.Find("maps/*.bsp", "GAME", "namedesc")

	local tab = {}

	for _, v in pairs(maps) do
		local mapname, _ = string.gsub(v, ".bsp", "")
		table.insert(tab, mapname)
	end

	return tab
end

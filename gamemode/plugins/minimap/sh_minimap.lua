local limit = 60000

file.CreateDir("combinecontrol/maps")

function GM:SendMinimapData(message, path, ply)
	local data = util.Compress(file.Read(path, "DATA"))
	local buffer = {}

	if #data < limit then
		buffer = {data}
	else
		for i = 1, math.ceil(#data / limit) do
			buffer[i] = string.sub(data, limit * (i - 1) + 1, limit * i)
		end
	end

	for k, v in ipairs(buffer) do
		timer.Simple(k * 0.1, function()
			net.Start(message)
				net.WriteUInt(#v, 16)
				net.WriteData(v)
			if CLIENT then
				net.SendToServer()
			else
				net.Send(ply)
			end
		end)
	end
end

function GM:ReadMinimapData()
	if not self.MinimapBuffer then
		self.MinimapBuffer = {}
	end

	local len = net.ReadUInt(16)
	local data = net.ReadData(len)

	table.insert(self.MinimapBuffer, data)

	if len < limit then
		local completed = util.Decompress(table.concat(self.MinimapBuffer))

		self.MinimapBuffer = nil

		return completed
	end
end

function GM:LoadMinimap()
	self.MinimapMaterial = Material("../data/combinecontrol/maps/" .. game.GetMap() .. ".png", "mips")

	if CLIENT then
		CreateMaterial("cc_minimap", "VertexLitGeneric", {
			["$basetexture"] = self.MinimapMaterial:GetTexture("$basetexture"):GetName(),
			["$model"] = 1,
			["$vertexcolor"] = 1
		})
	else
		self.MinimapCRC = util.CRC(file.Read("combinecontrol/maps/" .. game.GetMap() .. ".png", "DATA"))
		self:SetMapEnabled(true)
		self.MinimapSent = {}
	end
end

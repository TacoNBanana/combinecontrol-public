function GM:LoadWorldEnt(data)
	local ent = ents.Create(data.Class)

	if not IsValid(ent) then
		return
	end

	local pos = pon.decode(data.MapPos)

	ent:SetPos(Vector(pos.vx, pos.vy, pos.vz))
	ent:SetAngles(Angle(pos.ap, pos.ay, pos.ar))

	ent:Spawn()
	ent:Activate()

	ent:SetEntityID(data.id)
	ent:LoadCustomData(pon.decode(data.CustomData))

	local phys = ent:GetPhysicsObject()

	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	ent:OnInitialLoad()
end

function GM:LoadWorldEnts()
	self.SQL:Query("SELECT * FROM $worldents WHERE MapName = ?", self:GetMapRedirect(), function(res)
		for _, v in ipairs(res) do
			self:LoadWorldEnt(v)
		end
	end)
end

function GM:SaveWorldEnt(ent)
	local data = pon.encode(ent:GetCustomData())

	local vec = ent:GetPos()
	local ang = ent:GetAngles()

	local pos = pon.encode({
		vx = math.Round(vec.x, 2),
		vy = math.Round(vec.y, 2),
		vz = math.Round(vec.z, 2),
		ap = math.Round(ang.p, 2),
		ay = math.Round(ang.y, 2),
		ar = math.Round(ang.r, 2)
	})

	if ent:IsReady() then
		-- Saved before
		self.SQL:Update("$worldents", {MapPos = pos, CustomData = data}, "id = ?", ent:GetEntityID(), stub)
	else
		-- First time save
		local phys = ent:GetPhysicsObject()

		if IsValid(phys) then
			phys:EnableMotion(false)
		end

		self.SQL:Insert("$worldents", {
			Class = ent:GetClass(),
			MapName = self:GetMapRedirect(),
			MapPos = pos,
			CustomData = data
		}, function(res)
			ent:SetEntityID(res[1].id)
			ent:OnInitialLoad()
		end)
	end
end

function GM:DeleteWorldEnt(ent)
	if not ent:IsReady() then
		return
	end

	self.SQL:Query("DELETE FROM $worldents WHERE ID = ?", ent:GetEntityID(), function()
		if IsValid(ent) then
			ent:Remove()
		end
	end)
end

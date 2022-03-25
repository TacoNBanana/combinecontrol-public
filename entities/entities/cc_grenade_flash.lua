AddCSLuaFile()

ENT.Base 	= "cc_grenade_frag"

ENT.Model 	= Model("models/weapons/w_eq_flashbang_thrown.mdl")

function ENT:Explode(tr)
	if tr.Fraction ~= 1.0 then
		self:SetPos(tr.HitPos + tr.Normal * 0.6)
	end

	net.Start("nFlashbang")
		net.WriteEntity(self)
		net.WriteVector(self:GetPos())
	net.Broadcast()

	self:EmitSound("weapons/flashbang/flashbang_explode2.wav")
	self:Remove()
end

if CLIENT then
	local function nFlashbang(len)
		local ent = net.ReadEntity()
		local vec = net.ReadVector()
		local tvec = vec:ToScreen()

		vec.z = vec.z + 8

		local d = DynamicLight(1)

		if d then
			d.Pos = vec
			d.r = 255
			d.g = 255
			d.b = 255
			d.Brightness = 20
			d.Size = 256
			d.Decay = 4096
			d.DieTime = CurTime() + 0.3
			d.Style = 0
		end

		local filter = {LocalPlayer()}

		if IsValid(ent) then
			table.insert(filter, ent)
		end

		local tr, frac = GAMEMODE:CanSeePos(LocalPlayer():EyePos(), vec, filter)

		if tvec.visible and vec:Distance(LocalPlayer():EyePos()) < 650 and tr and frac > 0.75 then
			GAMEMODE.FlashbangStart = CurTime()

			LocalPlayer():SetDSP(math.random(35, 37))
		end
	end

	net.Receive("nFlashbang", nFlashbang)
end
AddCSLuaFile()

ENT.Base 		= "cc_base_ent"

ENT.RenderGroup = RENDERGROUP_OPAQUE

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "ModelSlot")
end

function ENT:Draw()
	local ply = LocalPlayer()
	local parent = self:GetParent()

	if not IsValid(parent) then
		return
	end

	if parent == ply then
		if ply:ShouldDrawLocalPlayer() then
			self:DrawModel()
		end

		return
	elseif parent == ply:GetRagdollEntity() then
		self:DrawModel()
	end

	if parent:IsDormant() or self:IsDormant() then
		return
	end

	local shouldDraw = false
	local pos = self:LocalToWorld(self:OBBCenter())
	local rad = self:BoundingRadius() * 3
	local dist = pos:DistToSqr(ply:GetPos())

	shouldDraw = dist < (1.5 * rad) ^ 2

	if not shouldDraw then
		local weapon = ply:GetActiveWeapon()

		if IsValid(weapon) and weapon.Tekka and weapon.UseRTScope and weapon.RTScopeAlpha < 1 then
			shouldDraw = ply:GetAimVector():Dot((pos - ply:GetPos()):GetNormalized()) > 0.48
		else
			self.PixVis = self.PixVis or util.GetPixelVisibleHandle()
			shouldDraw = util.PixelVisible(pos, rad, self.PixVis) > 0
		end
	end

	if shouldDraw or _G.BypassCulling then
		self:DrawModel()
	end
end

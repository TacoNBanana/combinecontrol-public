function ENT:ValidTarget(ent)
	if not IsValid(ent) or ent == self then
		return false
	end

	if self:Disposition(ent) != D_HT then
		return false
	end

	if ent:IsPlayer() then
		if not ent:Alive() then
			return false
		end

		if ent:GetCharFlagValue("IsSkyNET", false) then
			return false
		end
	end

	if ent:IsNPC() and ent:Health() <= 0 then
		return false
	end

	return true
end

function ENT:Look(dist, fov)
	local origin = self:EyePos()
	local sqrt = dist * dist

	for _, v in pairs(player.GetAll()) do
		if not self:ValidTarget(v) then
			continue
		end

		local vOrigin = v:EyePos()

		if origin:DistToSqr(vOrigin) > sqrt or not self:Visible(v) then
			continue
		end

		if not self:HasActiveMemory(v) then
			local diff = v:EyePos() - origin
			local dot = self:GetAimVector():Dot(diff) / diff:Length()

			local deg = math.deg(math.acos(dot))

			if deg > fov then
				continue
			end
		end

		self:QueueInterrupt("VisibleEnemy")

		if self:UpdateMemory(v, v:GetPos()) then
			self:QueueInterrupt("NewEnemy")
		end
	end

	if not self:IsInterruptSet("VisibleEnemy") then
		self:QueueInterrupt("NoVisibleEnemy")
	end
end

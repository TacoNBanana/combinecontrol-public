function ITEM:OnPickup(ply, loaded)
	if SERVER and loaded then
		local slot = self:IsWorn()

		if slot then
			self:Wear(ply, slot, true)
		end
	end
end

if SERVER then
	function ITEM:OnWorn(ply)
	end

	function ITEM:OnUnworn(ply)
	end

	function ITEM:OnBreak()
		local ply = self.Player

		if not IsValid(ply) then
			return
		end

		if self:IsWorn() then
			self:Unwear(ply)
		end

		ply:SendChat(nil, "WARNING", string.format("Your %s broke!", self:GetName()))
	end

	function ITEM:OnDamaged()
		self.Player:SendChat(nil, "WARNING", string.format("Your %s has been damaged!", self:GetName()))
	end
end
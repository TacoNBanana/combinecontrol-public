DEFINE_BASECLASS("base_item")

function ITEM:GetUpdateTargets()
	if self.StoreType == ITEM_PLAYER and self:IsWorn() then
		return player.GetAll()
	else
		return BaseClass.GetUpdateTargets(self)
	end
end
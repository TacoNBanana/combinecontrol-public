ITEM = class.Create("base_item")
DEFINE_BASECLASS("base_item")

ITEM.Name 		= "base_augment"

ITEM.Speed 		= 0
ITEM.Strength 	= 0
ITEM.Endurance 	= 0
ITEM.Agility 	= 0
ITEM.Dexterity 	= 0

function ITEM:IsInstalled()
	return self.StoreType == ITEM_AUGMENT
end

function ITEM:GetStat(stat)
	return self[stat] or 0
end

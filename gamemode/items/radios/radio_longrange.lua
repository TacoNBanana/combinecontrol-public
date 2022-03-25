ITEM = class.Create("base_radio")
DEFINE_BASECLASS("base_radio")

ITEM.Name 				= "Long-range Radio"
ITEM.Description 		= "A radio capable of tuning into multiple channels at a time"

ITEM.MaxChannels 		= 2

ITEM.ChannelRange 		= {1, 999, {2000}}

ITEM.AllowCommand 		= true

function ITEM:ChannelAvailable(chan)
	if chan == 2000 then
		local item = self.Player:GetEquipment(EQUIPMENT_BACK)

		if not item or item:GetClass() != "backpack_radio" then
			return false, "You aren't wearing a long-range receiver!"
		end
	end

	return BaseClass.ChannelAvailable(self, chan)
end

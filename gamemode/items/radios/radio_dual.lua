ITEM = class.Create("base_radio")

ITEM.Name 				= "Dual-channel radio"
ITEM.Description 		= "A radio capable of tuning into multiple channels at a time"

ITEM.Model 				= Model("models/Items/combine_rifle_cartridge01.mdl")

ITEM.BusinessLicense 		= {BUSINESS_GENERIC, BUSINESS_QUARTERMASTER}
ITEM.BuyPrice 				= 500
ITEM.SellPrice 				= 200

ITEM.MaxChannels 		= 2
ITEM.MaxActiveChannels 	= 2

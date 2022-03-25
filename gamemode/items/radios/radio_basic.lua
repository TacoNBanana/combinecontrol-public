ITEM = class.Create("base_radio")

ITEM.Name 				= "Basic radio"
ITEM.Description 		= "A basic radio capable of tuning into a single channel"

ITEM.Model 				= Model("models/Items/combine_rifle_cartridge01.mdl")

ITEM.BusinessLicense 		= {BUSINESS_GENERIC, BUSINESS_QUARTERMASTER}
ITEM.BuyPrice 				= 50
ITEM.SellPrice 				= 20

ITEM.MaxChannels 		= 1
ITEM.MaxActiveChannels 	= 1

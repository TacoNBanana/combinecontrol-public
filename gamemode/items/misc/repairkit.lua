ITEM = class.Create("base_item")

ITEM.Name 			= "Repair Kit"
ITEM.Description 	= "Full of the necessary components to repair something!"

ITEM.BusinessLicense 		= BUSINESS_GENERIC
ITEM.BuyPrice 				= 100
ITEM.SellPrice 				= 50

ITEM.Model			= Model("models/props_lab/box01a.mdl")

ITEM.Weight 		= 1

--It's used to repair items that don't have ITEM.ScrapItem specified -tanknut
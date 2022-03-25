-- ITEM needs to be global for the includes to work
ITEM = class.Create()

ITEM.ID 					= -1

ITEM.Deleted 				= false

ITEM.Name 					= "base_item"
ITEM.Description 			= "*INVALID*"

ITEM.Generic 				= true -- Prevents people from giving user descriptions to an item
ITEM.UserDescription 		= ""

ITEM.Model 					= "models/props_junk/PopCan01a.mdl"
ITEM.Skin 					= 0
ITEM.Scale 					= 1

ITEM.Bodygroups 			= {}
ITEM.Materials 				= ""
ITEM.Color 					= Color(255, 255, 255)

ITEM.IconFOV 				= -1
ITEM.CamOffset 				= Vector()
ITEM.AngOffset 				= Angle()

ITEM.Weight 				= 0
ITEM.CarryAdd 				= 0

ITEM.UseCondition 			= false
ITEM.Condition 				= CONDITION_GOOD

ITEM.BusinessLicense 		= BUSINESS_NONE
ITEM.BuyPrice 				= -1
ITEM.SellPrice 				= -1
ITEM.SellConditionMult 		= {
	[CONDITION_GOOD] = 1,
	[CONDITION_DAMAGED] = 0.75,
	[CONDITION_HEAVILYDAMAGED] = 0.5,
	[CONDITION_BROKEN] = 0.25
}

ITEM.ScrapItem 				= nil

ITEM.Overrides 				= {}
ITEM.Blacklist 				= {
	Blacklist = true,
	BusinessLicense = true,
	BuyPrice = true,
	Deleted = true,
	ID = true,
	NetworkedPlayers = true,
	PhysicalEntity = true,
	PlayerID = true,
	SellPrice = true,
	SellConditionMult = true,
	StoreType = true,
	UseCondition = true,
	ScrapItem = true
}

ITEM.NetworkedPlayers 		= {}

ITEM.StoreType 				= ITEM_NONE

ITEM.PhysicalEntity 		= nil
ITEM.PhysicalEntityIndex 	= nil
ITEM.CharacterID 			= nil
ITEM.Player 				= nil
-- ITEM.ContainerID 		= nil

AddCSLuaFile("cl_ui.lua")

if CLIENT then
	include("cl_ui.lua")
end

AddCSLuaFile("sh_events.lua")
include("sh_events.lua")

AddCSLuaFile("sh_get.lua")
include("sh_get.lua")

AddCSLuaFile("sh_permissions.lua")
include("sh_permissions.lua")

if SERVER then
	include("sv_db.lua")
	include("sv_networking.lua")
end

function ITEM:GetProperty(key)
	if self.Overrides[key] then
		return self.Overrides[key]
	end

	local val = self[key]

	return istable(val) and table.FullCopy(val) or val
end

function ITEM:IsBroken()
	return self.UseCondition and self:GetCondition() == CONDITION_BROKEN or false
end

function ITEM:Load(id, overrides, location, locationarg, deleted)
	self.ID = id
	self.Overrides = overrides
	self.StoreType = location

	self.Deleted = tobool(deleted)

	self:SetItemLocation(location, locationarg, true, true)
end

function ITEM:__tostring()
	return string.format("Item [%s][%s]", self.ID, self:GetClass())
end

-- When moving items from one place to another we first null out all references at the old location
function ITEM:UnsetItemLocation(unloading)
	local location = self.StoreType

	if location == ITEM_PLAYER then
		local ply = self.Player

		self:OnRemove(ply)

		if IsValid(ply) then
			ply.Inventory[self.ID] = nil
		end

		self.Player = nil
		self.CharacterID = nil
	elseif location == ITEM_WORLD then
		local ent = self.PhysicalEntity

		if IsValid(ent) then
			ent.Item = nil

			if SERVER then
				ent:Remove()
			end
		end

		self.PhysicalEntity = nil
		self.PhysicalEntityIndex = nil
	elseif location == ITEM_AUGMENT then
		local ply = self.Player

		self:OnRemove(ply)

		if IsValid(ply) then
			ply.Augments[self.ID] = nil
		end

		self.Player = nil
		self.CharacterID = nil
	end
end

-- Handles moving items from one location to another proper
function ITEM:SetItemLocation(location, locationarg, nosave, loaded)
	if not loaded then
		self:UnsetItemLocation()
	end

	local ply

	if location == ITEM_PLAYER then
		ply = player.GetByCharID(locationarg)

		self.Player = ply
		self.CharacterID = locationarg

		if IsValid(ply) then
			ply.Inventory[self.ID] = self
		end
	elseif location == ITEM_WORLD then
		if SERVER then
			self:SetWorldPosition(locationarg)
		else
			GAMEMODE.ItemQueue[locationarg] = self
		end
	elseif location == ITEM_AUGMENT then
		ply = player.GetByCharID(locationarg)

		self.Player = ply
		self.CharacterID = locationarg

		if IsValid(ply) then
			ply.Augments[self.ID] = self
		end
	end

	self.StoreType = location

	if SERVER then
		self:ClearNetworkedPlayers()

		local unloadTargets = self:GetUnloadTargets()
		local updateTargets = self:GetUpdateTargets()

		if unloadTargets and not loaded then
			self:UnloadClients(unloadTargets)
		end

		if updateTargets then
			self:UpdateClients(updateTargets)
		end

		if not nosave then
			self:SaveLocation()
		end
	end

	if location == ITEM_PLAYER or location == ITEM_AUGMENT and IsValid(ply) then
		self:OnPickup(ply, loaded)
	end
end

if CLIENT then
	-- Called whenever the client receives an item update
	function ITEM:Updated()
		self.ReloadTooltip = true
	end
else
	function ITEM:SetProperty(key, value, nosave)
		if self.Blacklist[key] then
			return
		end

		-- Setting value to nil forces the default value and saves on db storage
		if self[key] == value then
			value = nil
		end

		self.Overrides[key] = value
		self:UpdateClients(self:GetUpdateTargets())

		if not nosave then
			self:SaveItem()
		end
	end

	function ITEM:TakeDamage()
		if not self.UseCondition or self:IsBroken() then
			return
		end

		local val = self:GetCondition() + 1

		if val == CONDITION_BROKEN then
			self:OnBreak()
		else
			self:OnDamaged()
		end

		self:SetProperty("Condition", val)
	end

	function ITEM:SetWorldPosition(pos)
		local ent = self.PhysicalEntity

		if not IsValid(ent) then
			ent = ents.Create("cc_item")
			ent.Item = self

			self.PhysicalEntity = ent
			self.PhysicalEntityIndex = ent:EntIndex()
		end

		ent:SetPos(pos)

		ent:SetModel(self:GetProperty("Model"))
		ent:SetSkin(self:GetProperty("Skin"))

		local scale = self:GetProperty("Scale")

		if scale ~= 1 then
			ent:SetModelScale(ent:GetModelScale() * scale, 0)
		end

		local bodygroups = self:GetProperty("Bodygroups")

		for k, v in pairs(bodygroups) do
			if not isnumber(v) then
				continue
			end

			ent:SetBodygroup(k - 1, v)
		end

		local mats = self:GetProperty("Materials")

		if isstring(mats) then
			ent:SetMaterial(mats)
		else
			for k, v in pairs(mats) do
				if not isstring(v) then
					continue
				end

				ent:SetSubMaterial(k, v)
			end
		end

		ent:SetColor(self:GetProperty("Color"))
		ent:SetRenderMode(RENDERMODE_TRANSALPHA)

		ent:Spawn()
		ent:Activate()

		self:ProcessEntity(ent)
	end

	function ITEM:ProcessEntity(ent)
	end
end

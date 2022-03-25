AddCSLuaFile()
DEFINE_BASECLASS("cc_zone")

ENT.Base 			= "cc_zone"

ENT.PrintName 		= "Teleport entrance"
ENT.Category 		= "CombineControl - Zones"

ENT.Spawnable 		= true
ENT.AdminSpawnable 	= true

ENT.Color 			= Color(255, 223, 127)

function ENT:SetupDataTables()
	BaseClass.SetupDataTables(self)

	self:NetworkVar("Int", 1, "Group")
end

function ENT:Enter(ply, transition)
	if CLIENT then
		return
	end

	if SERVER and not transition then
		local spawns = ents.FindByClass("cc_teleport_target")

		if #spawns == 0 then
			return
		end

		for k,v in pairs(spawns) do
			if not v:IsReady() then
				spawns[k] = nil
			elseif self:GetGroup() != v:GetGroup() then
				spawns[k] = nil
			end
		end

		local suitable = nil

		for _,v in RandomPairs(spawns) do
			if IsValid(v) and v:IsSuitable(ply) then
				suitable = v

				break
			end
		end

		if suitable == nil then
			suitable = table.Random(spawns) -- Fuck it
		end

		if suitable then
			ply:SetPos(suitable:GetPos())
			ply:SetAngles(suitable:GetAngles())

			ply:SetVelocity(ply:GetVelocity() * Vector(-1, -1, -1))
			ply:SetEyeAngles(suitable:GetAngles())
		end
	end
end

function ENT:GetContextOptions(ply)
	local tab = BaseClass.GetContextOptions(self, ply)

	if ply:IsAdmin() and not self:IsReady() then
		local done = {}

		table.insert(tab, {
			Name = "Set group: 0",
			Callback = function()
				self:SetGroup(0)
			end
		})

		for _, v in pairs(ents.FindByClass("cc_zone_teleport")) do
			local group = v:GetGroup()

			if group != 0 and v != self and not done[group] then
				done[group] = true

				table.insert(tab, {
					Name = string.format("Set group: %i", group),
					Callback = function()
						self:SetGroup(group)
					end
				})
			end
		end

		table.insert(tab, {
			Name = "Set as new group",
			Callback = function()
				self:SetGroup(#done + 1)
			end
		})
	end

	return tab
end

if CLIENT then
	function ENT:Draw()
		BaseClass.Draw(self)

		if GAMEMODE.SeeAll and LocalPlayer():IsAdmin() then
			GAMEMODE:DrawWorldText(self:WorldSpaceCenter(), string.format("Teleport: %i", self:GetGroup()), true)
		end
	end
end

if SERVER then
	function ENT:GetCustomData()
		return {
			Group = self:GetGroup(),

			ZoneMins = self:GetZoneMins(),
			ZoneMaxs = self:GetZoneMaxs()
		}
	end

	function ENT:LoadCustomData(data)
		self:SetGroup(data.Group)

		self:SetZoneMins(data.ZoneMins)
		self:SetZoneMaxs(data.ZoneMaxs)
	end
end

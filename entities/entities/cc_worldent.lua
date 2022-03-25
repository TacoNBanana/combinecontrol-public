AddCSLuaFile()

ENT.Base 			= "cc_base_ent"
ENT.IsWorldEnt 		= true

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "EntityID")
end

function ENT:IsReady()
	return self:GetEntityID() > 0
end

function ENT:CanPhysgun(ply)
	return not self:IsReady()
end

function ENT:CanTool(ply)
	return not self:IsReady()
end

function ENT:GetContextOptions(ply)
	local tab = {}

	if ply:IsAdmin() then
		if self:IsReady() then
			table.insert(tab, {
				Name = "** Delete **",
				Callback = function()
					self:Delete()
				end
			})
		elseif self:CanSave() then
			table.insert(tab, {
				Name = "** Save **",
				Callback = function()
					self:Save()
				end
			})
		end
	end

	return tab
end

function ENT:CanSave()
	return true
end

if SERVER then
	function ENT:GetCustomData()
		return {}
	end

	function ENT:LoadCustomData(data)
	end

	function ENT:OnInitialLoad()
	end

	function ENT:Save()
		undo.ReplaceEntity(self, NULL)
		cleanup.ReplaceEntity(self, NULL)

		constraint.RemoveAll(self)

		GAMEMODE:SaveWorldEnt(self)
	end

	function ENT:Delete()
		GAMEMODE:DeleteWorldEnt(self)
	end
end

AddCSLuaFile()

ENT.Base 					= "base_anim"
ENT.Type 					= "anim"

ENT.RenderGroup  			= RENDERGROUP_BOTH

ENT.Spawnable 				= false
ENT.AdminSpawnable			= false

ENT.AutomaticFrameAdvance	= true

ENT.HUDAlpha 				= 0
ENT.AllowPhys 				= false

function ENT:PostEntityPaste(ply, ent, tab)
	GAMEMODE:WriteLog("security_protected_entity", {Ply = GAMEMODE:LogPlayer(ply), Char = GAMEMODE:LogCharacter(ply), Class = ent:GetClass()})
	ent:Remove()
end

function ENT:CanPhysgun()
	return self.AllowPhys or false
end
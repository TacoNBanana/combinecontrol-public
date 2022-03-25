if game.SinglePlayer() then
	--This is not perfect, but good enough
	-- hook.Add("PlayerStepSoundTime", "ctp_PlayerStepSoundTime", function(ply)
	-- 	if not ply:IsCTPEnabled() then return end

	-- 	local running = ply:KeyDown(IN_SPEED)
	-- 	local walking = ply:KeyDown(IN_WALK)
	-- 	local sideways = ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT)
	-- 	local forward = ply:KeyDown(IN_FORWARD)
	-- 	local back = ply:KeyDown(IN_BACK)

	-- 	local time = 240

	-- 	if running then
	-- 		time = 140
	-- 		if sideways then
	-- 			time = 200
	-- 		end
	-- 	end
	-- 	if walking then
	-- 		time = 285
	-- 		if forward then
	-- 			time = 390
	-- 		end
	-- 		if back then
	-- 			time = 330
	-- 		end
	-- 	end
	-- 	if sideways and not forward then
	-- 		time = time * 0.75
	-- 	end

	-- 	if not walking and not running and back then
	-- 		time = 200
	-- 	end

	-- 	return time
	-- end)
else

	if VERSION >= 150 then
		for key, value in pairs(file.Find("ctp/cvar_presets/*", "DATA")) do
			resource.AddFile("data/ctp/cvar_presets/" .. value)
		end

		for key, value in pairs(file.Find("ctp/default_cvar_presets/*", "DATA")) do
			resource.AddFile("data/ctp/default_cvar_presets/" .. value)
		end

		for key, value in pairs(file.Find("ctp/node_presets/*", "DATA")) do
			resource.AddFile("data/ctp/node_presets/" .. value)
		end
	else
		for key, value in pairs(file.Find("ctp/cvar_presets/*")) do
			resource.AddFile("data/ctp/cvar_presets/" .. value)
		end

		for key, value in pairs(file.Find("ctp/default_cvar_presets/*")) do
			resource.AddFile("data/ctp/default_cvar_presets/" .. value)
		end

		for key, value in pairs(file.Find("ctp/node_presets/*")) do
			resource.AddFile("data/ctp/node_presets/" .. value)
		end
	end
end

local META = FindMetaTable("Player")

function META:IsCTPEnabled()
	return CLIENT and GetConVar("ctp_enabled"):GetBool() == true or self:GetInfoNum("ctp_enabled", 0) == 1
end


util.AddNetworkString( "ctp_togglestate" );
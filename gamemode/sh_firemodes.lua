GM.Firemodes = {}

function GM:RegisterFiremode(path)
	AddCSLuaFile(path)
	include(path)

	path = string.FileName(path)

	class.Register(path, FIREMODE)

	FIREMODE = nil
end

GM:RegisterFiremode("classes/firemodes/firemode_semi.lua")
GM:RegisterFiremode("classes/firemodes/firemode_auto.lua")
GM:RegisterFiremode("classes/firemodes/firemode_m203.lua")
GM:RegisterFiremode("classes/firemodes/firemode_underslung.lua")
GM:RegisterFiremode("classes/firemodes/firemode_extinguisher.lua")
GM:RegisterFiremode("classes/firemodes/firemode_flamethrower.lua")
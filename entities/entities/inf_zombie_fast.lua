AddCSLuaFile()

ENT.Base 			= "inf_zombie_slow"

ENT.PrintName 		= "Zombie (fast)"
ENT.Category 		= "CombineControl"

ENT.Spawnable 		= true
ENT.AdminSpawnable 	= true

ENT.SlowZombie 		= false

if CLIENT then
	language.Add("inf_zombie_fast", "Zombie (fast)")
end
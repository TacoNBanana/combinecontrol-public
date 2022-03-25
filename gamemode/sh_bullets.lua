GM.Bullets = {}

function GM:RegisterBullet(path)
	AddCSLuaFile(path)
	include(path)

	path = string.FileName(path)

	if BULLET.Name != "" then
		local classname = "ammo_" .. path
		local item = class.Create("base_stacking")

		item.Name 				= BULLET.Name .. " Rounds"
		item.Description 		= "Placeholder"

		item.Model				= BULLET.Model or Model("models/Items/BoxSRounds.mdl")

		item.Weight 			= BULLET.Weight or 0.01

		item.FOV 				= 20
		item.CamPos 			= Vector(50, 50, 50)
		item.LookAt 			= Vector(0, 0, 5)

		class.Register(classname, item)

		self.ItemClasses[classname] = true

		BULLET.AmmoClass = classname
	end

	path = "bullet_" .. path

	class.Register(path, BULLET)

	if BULLET.Name != "" then
		self.Bullets[path] = class.Instance(path)
	end

	BULLET = nil
end

function GM:RegisterBulletFolder(path)
	local files = file.Find(self.FolderName .. "/gamemode/" .. path .. "/*.lua", "LUA")

	for _, v in pairs(files) do
		self:RegisterBullet(path .. "/" .. v)
	end
end

GM:RegisterBullet("classes/bullets/base.lua")
GM:RegisterBullet("classes/bullets/ballistic.lua")
GM:RegisterBullet("classes/bullets/rubber.lua")
GM:RegisterBullet("classes/bullets/projectile.lua")

GM:RegisterBulletFolder("classes/bullets/ballistic")
GM:RegisterBulletFolder("classes/bullets/rubber")
GM:RegisterBulletFolder("classes/bullets/projectile")

function GM:GetBullet(type)
	return self.Bullets[type]
end

function GM:GetCompatibleBullets(caliber)
	local tab = {}

	for k, v in pairs(self.Bullets) do
		if v.Caliber == caliber then
			table.insert(tab, k)
		end
	end

	return tab
end
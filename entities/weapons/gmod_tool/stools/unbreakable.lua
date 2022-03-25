--[[******************
 *
 *                              Unbreakable STool
 *
 *
 *   Date   : 28  janvier 2007          Date    : 04 December 2013
 *
 *   Auteur : Chaussette™           Author  : XxWestKillzXx
 *
 ******************************************************************************]]
if (SERVER) then
	-- Comment this line if you don't want to send this stool to clients
	AddCSLuaFile("weapons/gmod_tool/stools/unbreakable.lua")

	function TOOL:Unbreakable(Element, Value)
		local Filter = ""

		if (Value) then
			Filter = "CCFilterDamage"
		end

		if (Element and Element:IsValid()) then
			Element:SetVar("Unbreakable", Value)
			Element:Fire("SetDamageFilter", Filter, 0)
		end
	end
end

TOOL.Category = "Constraints"
TOOL.Name = "Unbreakable"
TOOL.Command = nil
TOOL.ConfigName = ""

if (CLIENT) then
	language.Add("tool.unbreakable.name", "Unbreakable")
	language.Add("tool.unbreakable.desc", "Make a prop unbreakable")
	language.Add("tool.unbreakable.0", "Left click to make a prop unbreakable. Right click to restore its previous settings")
end

function TOOL:Action(Element, Value)
	if (Element and Element:IsValid()) then
		if (CLIENT) then return true end
		self:Unbreakable(Element, Value)

		return true
	end

	return false
end

function TOOL:LeftClick(Target)
	return self:Action(Target.Entity, true)
end

function TOOL:RightClick(Target)
	return self:Action(Target.Entity, false)
end

function TOOL.BuildCPanel(Panel)
	Panel:AddControl("Header", {
		Text = "#tool.unbreakable.name",
		Description = "#tool.unbreakable.desc"
	})
end
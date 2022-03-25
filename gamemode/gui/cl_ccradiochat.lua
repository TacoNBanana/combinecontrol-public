local CHAT_WIDTH	= 600
local CHAT_HEIGHT	= 300
local RADIO_LINES	= 10

local RADIO = {}
local height = draw.GetFontHeight("CombineControl.ChatRadio")

function RADIO:Init()
	self:SetWide(CHAT_WIDTH)
	self:SetTall(height * RADIO_LINES)
	self.Buffer = {}
end

local bgcolor = Color(0, 0, 0)
function RADIO:Paint(w, h)
	if cookie.GetNumber("cc_radiochat", 1) == 0 then
		return
	end

	if cookie.GetNumber("cc_hud", 1) == 0 and cookie.GetNumber("cc_chat", 0) == 0 then
		return
	end

	for i, t in ipairs(self.Buffer) do
		local text = t.Text
		local color = t.Color
		local lifetime = CurTime() - t.Received
		local alpha = 255
		if lifetime >= 15 then
			break
		elseif lifetime > 10 then
			alpha = (15 - lifetime)*0.2 * 255
		end
		color.a = alpha
		bgcolor.a = alpha

		draw.SimpleTextOutlined(text:sub(1, 196), "CombineControl.ChatRadio", 10, h - i*height, color, 0, 0, 1, bgcolor)
	end
	return true
end

local white = Color(255, 255, 255)
function RADIO:AddText(str, color)
	local expl = GAMEMODE:FormatText(str, "CombineControl.ChatRadio", self:GetWide() - 20)
	for i = 1, #expl do
		local line = {
			Text = expl[i],
			Color = color or white,
			Received = CurTime()
		}
		table.insert(self.Buffer, 1, line)
		if #self.Buffer > RADIO_LINES then
			table.remove(self.Buffer)
		end
	end
end

derma.DefineControl("CCRadioChat", "", RADIO, "EditablePanel")

local INPUT = {}

function INPUT:Init()
	self:SetFont("CombineControl.ChatNormal")
	self:SetUpdateOnType(true)

	self.ChatHistory = {}
	self.ChatHistoryIndex = 0
end

-- TODO: may revisit this in the future, dunno
-- parsing is too tightly coupled with error messages atm
local radioCommands = {"r", "ry", "rw", "rcom"}
function INPUT:OnValueChange(str)
	if #str > 0 then
		local lang, cmd, radioing

		lang, cmd = str:match("^/(%w+)%.(%w+)%s+.-%s*$")
		if not lang then
			cmd = str:match("^/(%w+)%s+.-%s*$")
		end

		local typing = 1

		if cmd then
			if table.HasValue(radioCommands, cmd) then
				typing = 2
			elseif cmd == "cr" then
				typing = 3
			end
		end

		net.Start("nSetTyping")
			net.WriteFloat(typing)
		net.SendToServer()
	else
		net.Start("nSetTyping")
			net.WriteFloat(0)
		net.SendToServer()
	end
end

function INPUT:OnKeyCodeTyped(code)
	self:OnKeyCode(code)
	if code == KEY_ESCAPE then
		GAMEMODE:HideChat()
		RunConsoleCommand("cancelselect")
	elseif code == KEY_ENTER and not self:IsMultiline() and self:GetEnterAllowed() then
		if IsValid(self.Menu) then
			self.Menu:Remove()
		end
		self:FocusNext()
		self:OnEnter()
	elseif code == KEY_UP
		or code == KEY_DOWN
	then
		self:CycleChatHistory(code)
	end
end

-- Credit to Zaubermuffin!
function INPUT:CycleChatHistory(code)
	if code == KEY_UP and self.ChatHistoryIndex == 1
		or code == KEY_DOWN and self.ChatHistoryIndex == 0
	then
		return
	elseif code == KEY_UP and self.ChatHistoryIndex == 0 then
		self.ChatHistoryBackup = self:GetText()
	end

	local index = (self.ChatHistoryIndex + 1) % (#self.ChatHistory + 1)
	if code == KEY_UP then
		index = (self.ChatHistoryIndex - 1) % (#self.ChatHistory + 1)
	end

	if index == 0 then
		self:SetText(self.ChatHistoryBackup)
		self.ChatHistoryBackup = nil
	else
		self:SetText(self.ChatHistory[index])
	end

	self:SetCaretPos(#self:GetText())
	self.ChatHistoryIndex = index
end

function INPUT:OnEnter()
	local str = self:GetText()
	if #str == 0 then
		GAMEMODE:HideChat()
		return
	end

	if #self.ChatHistory > cookie.GetNumber("cc_chathistory", 100) then
		table.remove(self.ChatHistory, 1)
	end

	if cookie.GetNumber("cc_chathistory", 100) > 0 then
		table.insert(self.ChatHistory, str)
	end

	GAMEMODE:ParseChat(str)
	GAMEMODE:HideChat()
end

function INPUT:AllowInput(c)
	if #self:GetValue() >= 500 then
		surface.PlaySound("weapons/pistol/pistol_empty.wav")
		return true
	elseif c == "`" then
		return true
	end
end

derma.DefineControl("CCChatInput", "", INPUT, "DTextEntry")

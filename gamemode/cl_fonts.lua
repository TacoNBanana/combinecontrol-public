GM.FontFace = system.IsOSX() and "ChatFont" or "Myriad Pro"

GM.FontHeight = {}

function surface.CreateFontCC(name, tab)
	surface.CreateFont(name, tab)
	GM.FontHeight[name] = tab.size
end

surface.CreateFontCC("CombineControl.Window", {
	font = GM.FontFace,
	size = 14,
	weight = 500})

surface.CreateFontCC("CombineControl.GUIClose", {
	font = GM.FontFace,
	size = 16,
	weight = 900})

surface.CreateFontCC("CombineControl.LabelTiny", {
	font = GM.FontFace,
	size = 12,
	weight = 500})

surface.CreateFontCC("CombineControl.LabelSmall", {
	font = GM.FontFace,
	size = 14,
	weight = 500})

surface.CreateFontCC("CombineControl.LabelSmallItalic", {
	font = GM.FontFace,
	size = 14,
	weight = 500,
	italic = true})

surface.CreateFontCC("CombineControl.LabelMedium", {
	font = GM.FontFace,
	size = 16,
	weight = 500})

surface.CreateFontCC("CombineControl.LabelBig", {
	font = GM.FontFace,
	size = 18,
	weight = 500})

surface.CreateFontCC("CombineControl.LabelGiant", {
	font = GM.FontFace,
	size = 22,
	weight = 500})

surface.CreateFontCC("CombineControl.LabelMassive", {
	font = GM.FontFace,
	size = 30,
	weight = 500})

surface.CreateFontCC("CombineControl.LabelStupid", {
	font = GM.FontFace,
	size = 50,
	weight = 500})

surface.CreateFontCC("CombineControl.ChatSmall", {
	font = GM.FontFace,
	--size = 14,
	size = 15,
	weight = 100})

surface.CreateFontCC("CombineControl.ChatSmallItalic", {
	font = GM.FontFace,
	--size = 14,
	size = 15,
	weight = 500,
	italic = true})

surface.CreateFontCC("CombineControl.ChatNormal", {
	font = GM.FontFace,
	--size = 16,
	size = 18,
	weight = 500})

surface.CreateFontCC("CombineControl.ChatItalic", {
	font = GM.FontFace,
	--size = 16,
	size = 18,
	weight = 500,
	italic = true})

surface.CreateFontCC("CombineControl.ChatRadio", {
	font = "Lucida Console",
	--size = 12,
	size = 14,
	weight = 500})

surface.CreateFontCC("CombineControl.CombineCamera", {
	font = "Courier New",
	size = 30,
	weight = 500})

surface.CreateFontCC("CombineControl.CombineScanner", {
	font = "Lucida Sans Typewriter",
	antialias = false,
	weight = 800,
	size = 18 })

surface.CreateFontCC("CombineControl.CombineCameraSmall", {
	font = "Courier New",
	size = 15,
	weight = 500})

surface.CreateFontCC("CombineControl.ChatBold", {
	font = GM.FontFace,
	size = 18,
	weight = 1600})

surface.CreateFontCC("CombineControl.ChatBigItalic", {
	font = GM.FontFace,
	size = 21,
	weight = 700,
	italic = true})

surface.CreateFontCC("CombineControl.ChatHuge", {
	font = GM.FontFace,
	size = 20,
	weight = 700})

surface.CreateFontCC("CombineControl.HL2CreditText", {
	font = "Trebuchet MS",
	size = 20,
	weight = 900})

surface.CreateFontCC("CombineControl.PlayerFont", {
	font = GM.FontFace,
	size = 17,
	weight = 700})

surface.CreateFontCC("CombineControl.HUDAmmo", {
	font = GM.FontFace,
	size = 50,
	weight = 500})

surface.CreateFontCC("CombineControl.HUDAmmoSmall", {
	font = GM.FontFace,
	size = 30,
	weight = 500})

surface.CreateFontCC("CombineControl.WepSelectHeader", {
	font = GM.FontFace,
	size = 20,
	weight = 700})

surface.CreateFontCC("CombineControl.WepSelectWep", {
	font = GM.FontFace,
	size = 18,
	weight = 500})

surface.CreateFontCC("CombineControl.WepSelectInfo", {
	font = GM.FontFace,
	size = 16,
	weight = 500})

surface.CreateFontCC("CombineControl.Written", {
	font = "Comic Sans MS",
	size = 20,
	weight = 700})

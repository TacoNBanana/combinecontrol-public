youtubeParentFrame = vgui.Create("DPanel")
youtubeParentFrame:Hide()

local function stopYoutube()
	youtubeParentFrame:Clear()
end

local function youtubeHtml(id, volume)
	return [[
	<!DOCTYPE html>
	<html>
		<head>
			<script src="https://www.youtube.com/iframe_api"></script>
		</head>
	  <body>
	    <div id="player"></div>
	    <script>
	      function onYouTubeIframeAPIReady() {
	        new YT.Player('player', {
	          height: '0',
	          width: '0',
	          videoId: ']] .. id .. [[',
	          events: {
	            'onReady': onPlayerReady,
	          }
	        });
	      }

	      function onPlayerReady(event) {
					event.target.setVolume(]] .. volume .. [[)
	        event.target.playVideo();
	      }

	    </script>
	  </body>
	</html>
	]]
end

concommand.Add("rp_stopmusic", stopYoutube)
net.Receive("nAStopYT", stopYoutube)
net.Receive("nAPlayYT", function()
	if not GAMEMODE:CanPlayMusic() then return end

	local sender = net.ReadString()
	local id = net.ReadString()
	local volume = net.ReadFloat()

	stopYoutube()
	print(sender .. " has played a youtube video (" .. id .. "), you can stop this with rp_stopmusic")

	local page = vgui.Create("DHTML", youtubeParentFrame)
	page:Dock(FILL)
	page:SetHTML(youtubeHtml(id, volume))
end)

function DHTML:ConsoleMessage(msg)
	-- Do nothing
end

local function stopURL()
	if GAMEMODE.PlayURL then
		GAMEMODE.PlayURL:Stop()
		GAMEMODE.PlayURL = nil
	end
end

net.Receive("nAStopURL", stopURL)
net.Receive("nAPlayURL", function()
	if not GAMEMODE:CanPlayMusic() then return end

	local sender = net.ReadString()
	local url = net.ReadString()
	local volume = net.ReadFloat()

	print(sender .. " has played a url (" .. url .. "), you can stop this with stopsound")

	if GAMEMODE.PlayURL then
		GAMEMODE.PlayURL:Stop()
		GAMEMODE.PlayURL = nil
	end

	sound.PlayURL(url, "mono", function(station)
		if IsValid(station) then
			station:SetVolume(volume)
			station:Play()

			GAMEMODE.PlayURL = station
		end
	end)
end)
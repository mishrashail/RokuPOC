'Initialize video Screen child components
sub init()
	m.videoPlayer = m.top.findNode("videoPlayer")
	m.videoPlayer.observeField("state","videoPlayerStates")
	m.AppDailogbox = CreateObject("roSGNode", "AppDailogbox")
	m.AppDailogbox.id = "AppDailogbox"
	m.top.appendChild(m.AppDailogbox)
	m.AppDailogbox.observeField("setFocus","handelFocus")
	m.AppDailogbox.observeField("close","handelVideoplayer")

	m.ErrorDailogbox = CreateObject("roSGNode", "ErrorDailogbox")
	m.ErrorDailogbox.id = "ErrorDailogbox"
	m.top.appendChild(m.ErrorDailogbox)
	m.ErrorDailogbox.observeField("closeErrorPopup","handelVideoplayer")
end sub

'if user click cancel button on exit popup
sub handelFocus()
	m.exitPopup = false
	m.AppDailogbox.hideDailogbox = true
	m.videoPlayer.control = "resume"
	m.videoPlayer.setFocus(true)
end sub

'if user click ok button on exit popup
sub handelVideoplayer()
	m.AppDailogbox.hideDailogbox = true
	m.ErrorDailogbox.hideDailogbox = true
	m.videoPlayer.control = "stop"
	m.videoPlayer.visible = false
	m.top.gotoLastScreen = true
end sub

'setvideo player and assign content
sub setFocus()
	videoContent = CreateObject("roSGNode","ContentNode")
	videoContent.url = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
	videoContent.streamFormat = "mp4"
	m.videoPlayer.content = videoContent
	m.videoPlayer.control = "prebuffer"
	m.videoPlayer.control = "play"
	m.videoPlayer.visible = true
	m.videoPlayer.setFocus(true)
end sub
'handel videoplayer states like play,stop,resume,error and finish
sub videoPlayerStates()
	if m.videoPlayer.state = "error"
		m.ErrorDailogbox.setMSG = "Something went wrong, unable to play video."
		m.videoPlayer.control = "PAUSE"
		m.ErrorDailogbox.showDailogbox = true
	else if m.videoPlayer.state = "finished"
		m.videoPlayer.control = "stop"
		m.videoPlayer.visible = false
		m.top.gotoLastScreen = true
	else if m.videoPlayer.state = "playing"
		m.exitPopup = false
		m.videoPlayer.setFocus(true)
	end if
end sub

'Do the focus handling by remote
function onKeyEvent(key as string, press as boolean) as boolean
	result = false
	if press then
		if key = "back"
			if m.videoPlayer.visible and m.exitPopup = false
				m.exitPopup = true
				m.videoPlayer.control = "PAUSE"
				m.AppDailogbox.setMSG = "Are you sure you want to exit your video?"
				m.AppDailogbox.showDailogbox = true
			end if
			result = true
		else if key = "down"
			if m.videoPlayer.visible  and m.exitPopup
				m.AppDailogbox.handelNOButton = true
			end if
			result = true
		else if key = "up"
			if m.videoPlayer.visible  and m.exitPopup
				m.AppDailogbox.handelOKButton = true
			end if
			result = true
		end if
	end if
	return result
end function
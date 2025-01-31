'Initialize the MainScene componenets
sub init()
	m.top.backgroundURI = ""
	m.top.backgroundColor = "#000000"
	
	m.AppDailogbox = CreateObject("roSGNode", "AppDailogbox")
	m.AppDailogbox.id = "AppDailogbox"
	m.top.appendChild(m.AppDailogbox)
	m.AppDailogbox.observeField("setFocus","handelFocus")
	m.AppDailogbox.observeField("close","handelVideoplayer")

	m.contentRetriever = m.global.contentRetriever
	m.screens = m.top.findNode("screens")
	m.screensContainerArray = []
	showHomeScreen() 'call homescreen function 
end sub

sub showHomeScreen()
	m.homeScreen = m.screens.createChild("homeScreen")
	m.homeScreen.id = "homeScreen"
	m.screensContainerArray.Push(m.homeScreen)
	m.screensContainerArray[m.screens.getChildren(3000, 0).Count() - 1].ObserveField("selectedDataController", "selectedDataControllerTransport") 'set ObserveField on homescreen if user select any content then user navigate to other screen.
	m.homeScreen.setFocus = true
	m.homeScreen.setHomeData = true
end sub

sub selectedDataControllerTransport(event as object)
	contentData = event.getData()
	m.screensContainerArray[m.screens.getChildren(3000, 0).Count() - 1].visible = false
	m.characterScreen = m.screens.createChild("characterScreen")
	m.characterScreen.id = "characterScreen"
	m.characterScreen.contentData = contentData
	m.screensContainerArray.Push(m.characterScreen)
	m.screensContainerArray[m.screens.getChildren(3000, 0).Count() - 1].ObserveField("gotovideoScreen", "showvideoScreen")
	m.characterScreen.setFocus = true
end sub

sub showvideoScreen()
	m.screensContainerArray[m.screens.getChildren(3000, 0).Count() - 1].visible = false
	m.videoScreen = m.screens.createChild("videoScreen")
	m.videoScreen.id = "videoScreen"
	m.screensContainerArray.Push(m.videoScreen)
	m.screensContainerArray[m.screens.getChildren(3000, 0).Count() - 1].ObserveField("gotoLastScreen", "gotoLastScreen")
	m.videoScreen.setFocus = true
end sub

sub gotoLastScreen()
	previousScreenId = m.screensContainerArray[m.screens.getChildren(3000, 0).Count() - 1].id
	?"previousScreenId=============="previousScreenId
	m.screens.removeChildIndex(m.screens.getChildren(3000, 0).Count() - 1)
	m.screensContainerArray.Pop()
	m.screensContainerArray[m.screens.getChildren(3000, 0).Count() - 1].visible = true
	m.screensContainerArray[m.screens.getChildren(3000, 0).Count() - 1].setFocus = true
end sub

'Do focus handling
function onKeyEvent(key as string, press as boolean) as boolean
	result = false
	if press then
		if key = "back"
			?"m.screensContainerArray<>invalid and m.screensContainerArray.Count()===="m.screensContainerArray<>invalid and m.screensContainerArray.Count()
			if m.screensContainerArray<>invalid and m.screensContainerArray.Count() > 1
				if m.screensContainerArray[m.screens.getChildren(3000, 0).Count() - 1].id <> "videoScreen"
					m.screens.removeChildIndex(m.screens.getChildren(3000, 0).Count() - 1)
					m.screensContainerArray.Pop()
					m.screensContainerArray[m.screens.getChildren(3000, 0).Count() - 1].visible = true
					result = true
				end if
				if m.screensContainerArray[m.screens.getChildren(3000, 0).Count() - 1].id = "homeScreen"
					m.screensContainerArray[m.screens.getChildren(3000, 0).Count() - 1].setFocus = true
					result = true
				end if
			else
				m.AppDailogbox.setMSG = "Are you sure you want to exit your channel?"
				m.AppDailogbox.showDailogbox = true
				result = true
			end if 
		else if key = "down"
			m.AppDailogbox.handelNOButton = true
			result = true
		else if key = "up"
			m.AppDailogbox.handelOKButton = true
			result = true
		end if
	end if
	return result
end function

sub handelFocus()
	m.AppDailogbox.hideDailogbox = true
	m.homeScreen.setFocus = true
end sub

sub handelVideoplayer()
	m.AppDailogbox.hideDailogbox = true
	m.top.closeApp = "close"
end sub
'Channel entry point
Function Main(args as Dynamic) as Void
		showChannelSGScreen(args)        
end Function

sub showChannelSGScreen(args)
    'screen, scene and port initialization
    m.screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    'Set the roMessagePort to be used for all events from the screen.
    m.screen.setMessagePort(m.port) 
    m.global = m.screen.getGlobalNode()
    scene = m.screen.CreateScene("MainScene")
    scene.signalBeacon("AppLaunchComplete")
     'Show Scene Graph canvas that displays the contents of a Scene Graph Scene node tree
    m.screen.show()
    while(true)
        msg = wait(5, m.port)  

		scenescene = scene.closeApp
        if scenescene <> ""
            m.screen.Close()
        end if
        msgType = type(msg)
        
        if msgType = "roSGScreenEvent"
           
        end if
    end while
end sub


function scale(fromVal = 1 as Integer) as Dynamic
	dInfo = CreateObject("roDeviceInfo")
	mode = getDisplayMode()
	if mode = "FHD" then
		return (fromVal)
	else if mode = "HD" then 'FHD->HD:720/1080'
		return (fromVal)
	else if mode = "SD" then 'FHD->SD:480/1080'
		return (fromVal * 0.44444)
	end if
end function

function getDisplayMode() as String
	gaa = getGlobalAA()
	if gaa.displayMode = Invalid then
	    deviceinfo = CreateObject("roDeviceInfo")
	    displaySize = deviceinfo.getDisplaySize()
	    if displaySize.h = 1080
	        gaa.displayMode = "FHD"
	    else if displaySize.h = 720
	        gaa.displayMode = "HD"
	    else if displaySize.h = 480
	        gaa.displayMode = "SD"
	    end if
	    return gaa.displayMode
	else
		return gaa.displayMode
	end if
end function

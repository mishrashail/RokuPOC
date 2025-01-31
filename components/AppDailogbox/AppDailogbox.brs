'Initialize video Screen child components
sub init()
	m.ExitPopUp = m.top.findNode("ExitPopUp")
	m.noExitbutton = m.top.findNode("noExitbutton")
	m.yesExitbutton = m.top.findNode("yesExitbutton")
	m.yesFocusRect = m.top.findNode("yesFocusRect")
	m.noFocusRect = m.top.findNode("noFocusRect")
	m.yesLabel = m.top.findNode("yesLabel")
	m.noLabel = m.top.findNode("noLabel")
	m.ExitMSG = m.top.findNode("ExitMSG")
end sub

'setvideo player and assign content
sub showDailogbox()
	if m.top.setMSG<>""
		m.ExitMSG.text = m.top.setMSG
	else
		m.ExitMSG.text = "Are you sure you want to exit?"
	end if
	m.ExitPopUp.visible = true
	m.noExitbutton.observeField("buttonSelected","noExitbuttonSelected")
	m.yesExitbutton.observeField("buttonSelected","yesExitbuttonSelected")
	m.yesExitbutton.setFocus(true)
	m.yesFocusRect.blendColor="#ffffff"
	m.yesLabel.color="#000000"
	m.yesFocusRect.opacity="1.0"
	m.noExitbutton.setFocus(false)
	m.noFocusRect.blendColor="0x313135"
	m.noLabel.color="#ffffff"
	m.noFocusRect.opacity="0.4"
end sub

sub hideDailogbox()
	m.ExitPopUp.visible = false
	m.yesExitbutton.setFocus(false)
	m.yesFocusRect.blendColor="#ffffff"
	m.yesLabel.color="#000000"
	m.yesFocusRect.opacity="1.0"
	m.noExitbutton.setFocus(false)
	m.noFocusRect.blendColor="0x313135"
	m.noLabel.color="#ffffff"
	m.noFocusRect.opacity="0.4"
end sub
sub handelOKButton()
	if m.ExitPopUp.visible
		m.yesExitbutton.setFocus(true)
		m.yesFocusRect.blendColor="#ffffff"
		m.yesLabel.color="#000000"
		m.yesFocusRect.opacity="1.0"
		m.noExitbutton.setFocus(false)
		m.noFocusRect.blendColor="0x313135"
		m.noLabel.color="#ffffff"
		m.noFocusRect.opacity="0.4"
	end if
end sub

sub handelNOButton()
	if m.ExitPopUp.visible
		m.yesExitbutton.setFocus(false)
		m.yesFocusRect.blendColor="0x313135"
		m.yesLabel.color="#ffffff"
		m.yesFocusRect.opacity="0.4"
		m.noExitbutton.setFocus(true)
		m.noFocusRect.blendColor="#ffffff"
		m.noLabel.color="#000000"
		m.noFocusRect.opacity="1.0"
	end if
end sub

sub noExitbuttonSelected()
	m.noExitbutton.setFocus(false)
	m.yesExitbutton.setFocus(false)
	m.ExitPopUp.visible = false
	m.top.setFocus = true
end sub

sub yesExitbuttonSelected()
	m.noExitbutton.setFocus(false)
	m.yesExitbutton.setFocus(false)
	m.ExitPopUp.visible = false
	m.top.close = true
end sub
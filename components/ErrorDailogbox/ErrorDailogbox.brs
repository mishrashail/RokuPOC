'Initialize video Screen child components
sub init()
	m.ErrorPopUp = m.top.findNode("ErrorPopUp")
	m.yesErrorbutton = m.top.findNode("yesErrorbutton")
	m.yesFocusRect = m.top.findNode("yesFocusRect")
	m.yesLabel = m.top.findNode("yesLabel")
	m.ErrorMSG = m.top.findNode("ErrorMSG")
end sub

'setvideo player and assign content
sub showDailogbox()
	if m.top.setMSG<>""
		m.ErrorMSG.text = m.top.setMSG
	else
		m.ErrorMSG.text = "Something went wrong."
	end if
	m.ErrorPopUp.visible = true
	m.yesErrorbutton.observeField("buttonSelected","yesErrorbuttonSelected")
	m.yesErrorbutton.setFocus(true)
	m.yesFocusRect.blendColor="#ffffff"
	m.yesLabel.color="#000000"
	m.yesFocusRect.opacity="1.0"
end sub

sub hideDailogbox()
	m.ErrorPopUp.visible = false
	m.yesErrorbutton.setFocus(false)
	m.yesFocusRect.blendColor="#ffffff"
	m.yesLabel.color="#000000"
	m.yesFocusRect.opacity="1.0"
end sub

sub handelOKButton()
	if m.ErrorPopUp.visible
		m.yesErrorbutton.setFocus(true)
		m.yesFocusRect.blendColor="#ffffff"
		m.yesLabel.color="#000000"
		m.yesFocusRect.opacity="1.0"
	end if
end sub

sub yesErrorbuttonSelected()
	m.yesErrorbutton.setFocus(false)
	m.ErrorPopUp.visible = false
	m.top.closeErrorPopup = true
end sub
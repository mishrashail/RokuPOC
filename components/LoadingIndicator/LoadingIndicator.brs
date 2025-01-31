'Initialize the Loading Indicator
'LoadingIndicator of all the screen except VideoPlayer
sub init()
  m.loadingImage = m.top.findNode("LoadingImage")
  m.loadingImage.width = scale(50)
  m.loadingImage.height = scale(50)
  m.rotationAnimation = m.top.findNode("RotationAnimation")
  m.fadeAnimation = m.top.findNode("FadeAnimation")
  m.fadeInterpolator = m.top.findNode("FadeInterpolator")
  m.loadingImage.scaleRotateCenter = [scale(25), scale(25)]

end sub

'Changes the LoadingIndicator dimensions
sub onSizeChange()
  m.loadingImage.height = m.top.height
  m.loadingImage.width = m.top.width
  m.loadingImage.scaleRotateCenter = [m.top.width / 2, m.top.height / 2]
end sub

'Controls the loading indicator
sub onControl()
  if m.top.control = "start"
    m.top.visible = true
    m.rotationAnimation.control = "start"
  else if m.top.control = "stop"
    m.top.visible = false
    m.rotationAnimation.control = "stop"
  end if
end sub

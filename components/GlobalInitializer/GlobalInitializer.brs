'Initialize all globals needed for the Channel
sub init()
  contentRetriever = CreateObject("roSGNode", "ContentRetriever")
  m.global.addFields({isProduction:true})

  m.global.addFields({
    api: setAPIbaseurl(),
    publickey: "4af734f4d358b39322dd3a544dbeb84d",
    hash: "aa4938dcb126e7cc155cf80b90a704a4",
    ts: "1738313610026",
    contentRetriever: contentRetriever,
  })
end sub

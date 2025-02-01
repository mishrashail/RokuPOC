'Initialize all globals needed for the Channel
sub init()
  contentRetriever = CreateObject("roSGNode", "ContentRetriever")
  m.global.addFields({isProduction:true})

  m.global.addFields({
    api: setAPIbaseurl(),
    contentRetriever: contentRetriever,
  })
end sub

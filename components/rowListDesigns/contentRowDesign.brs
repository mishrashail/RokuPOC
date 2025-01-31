'Initialize child components
sub init()
  m.pageItemImage = m.top.findNode("pageItemImage")
  m.ContentDetailGroup = m.top.findNode("ContentDetailGroup")
  m.title = m.top.findNode("Title")
  m.description = m.top.findNode("description")
end sub

'Set RowItem data
sub onItemContentChanged()
  itemcontent = m.top.itemContent
  
  m.pageItemImage.uri = itemcontent.posterURL 'set grid thumbnail uri on posternode

  if itemcontent.screen = "characterScreen"
    m.ContentDetailGroup.visible = true
    m.title.text = itemcontent.title
    m.description.text = itemcontent.description
    m.pageItemImage.loadWidth = m.top.width
    m.pageItemImage.loadHeight = m.top.height
    m.pageItemImage.width = m.top.width
    m.pageItemImage.height = m.top.height 
  else
    m.ContentDetailGroup.visible = false
    m.pageItemImage.loadWidth = m.top.width
    m.pageItemImage.loadHeight = m.top.height
    m.pageItemImage.width = m.top.width
    m.pageItemImage.height = m.top.height 
  end if
end sub



'Initialize Home Screen child components
sub init()
	m.loadingIndicator = m.top.findNode("loadingIndicator")
	m.loadingIndicator.translation = [900, 550]
	m.contentRow = m.top.findNode("contentRow")
	m.contentRow.numRows = 3
	m.contentRow.numColumns = 6
	m.contentRow.itemSize = [ 260, 395]
	m.contentRow.itemSpacing = [(50), (80)]
	m.contentRow.ObserveField("itemSelected", "contentSelectionMade")' as Boolean 
end sub

'handel focus on homescreen 
sub setFocus()
	m.contentRow.setFocus(true)
end sub

sub setHomeScreenData()
  	m.loadingIndicator.control = "start"
  	m.loadingIndicator.visible = true
	'call api and get homescreen content
	getURLCallGet(m.global.api.baseURL+"public/comics?ts="+m.global.ts+"&apikey="+m.global.publickey+"&hash="+m.global.hash+"&orderBy=-onsaleDate&limit=18", "HomeContentCall")
end sub

'fetch data from server and show in grid
sub loadHomeContentCallData(json)
	if json<>invalid and json.data<>invalid and json.data.results<>invalid and json.data.results.count()>0
		jsonData = json.data.results
		parentNode = createObject("roSGNode", "ContentNode")
		m.contentRow.content = parentNode

		for each item in jsonData
			itemNode = parentNode.createChild("CustomContentNode")
			itemNode.posterURL = item.thumbnail.path+"."+item.thumbnail.extension
			itemNode.id = item.id
			itemNode.screen = "homeScreen"
		end for

		if parentNode.getChildren(3000, 0).Count() > 0
			m.loadingIndicator.control = "stop"
  			m.loadingIndicator.visible = false
			m.contentRow.visible = true
			m.contentRow.setFocus(true)
		end if
	end if
end sub

'Callback for home item click for the event row
sub contentSelectionMade()
	itemContent = m.contentRow.content.getChild(m.contentRow.itemSelected)
	m.top.selectedDataController = itemContent
end sub
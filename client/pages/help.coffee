templateName = 'page_help'

Template[templateName].events
	
	'click .clickShowsGenerateRandomDataModal': (event, template) ->
		Modal.show('modal_generateRandomData')
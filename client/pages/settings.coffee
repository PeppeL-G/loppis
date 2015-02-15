templateName = 'page_settings'

Template[templateName].events
	'click .clickShowsDeleteEverythingModal': (event, template) ->
		Modal.show('modal_deleteEverything')
templateName = 'modal_deleteEverything'

Template[templateName].events
	
	'click .clickDeletesEverything': (event, template) ->
		
		Sellers.remove({})
		Purchases.remove({})
		
		Modal.hide()
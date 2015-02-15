templateName = 'modal_deletePurchase'

Template[templateName].events
	
	'submit form': (event, template) ->
		
		event.preventDefault()
		
		Purchases.remove(@getId())
		
		Modal.hide()
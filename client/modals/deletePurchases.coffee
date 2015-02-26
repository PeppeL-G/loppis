templateName = 'modal_deletePurchases'

Template[templateName].events
	
	'click .clickDeletesPurchases': (event, template) ->
		
		Purchases.remove({})
		
		Modal.hide()
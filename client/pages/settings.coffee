templateName = 'page_settings'

Template[templateName].events
	'click .clickShowsDeleteEverythingModal': (event, template) ->
		Modal.show('modal_deleteEverything')
	'click .clickShowsDeletePurchasesModal': (event, template) ->
		Modal.show('modal_deletePurchases')
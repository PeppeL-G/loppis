templateName = 'page_purchases'

Template[templateName].created = ->
	@purchasesPaginator = new Paginator(Purchases)

Template[templateName].helpers
	
	sellersExist: () ->
		return 0 < Sellers.find().count()
	
	purchases: () ->
		options =
			sort:
				[['number', 'desc']]
			itemsPerPage: 25
		return Template.instance().purchasesPaginator.find({}, options)

Template[templateName].events
	
	'click .clickShowsAddPurchaseModal': (event, template) ->
		Modal.show('modal_addPurchase')
	
	'click .clickShowsEditPurchaseModal': (event, template) ->
		Modal.show('modal_editPurchase', @)
	
	'click .clickShowsDeletePurchaseModal': (event, template) ->
		Modal.show('modal_deletePurchase', @)
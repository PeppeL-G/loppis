templateName = 'page_summary'

Template[templateName].helpers
	
	sellerCount: () ->
		return Sellers.find().count()
	
	purchaseCount: () ->
		return Purchases.find().count()
	
	purchaseAmount: () ->
		
		options =
			transform: null
		
		return Purchases.find({}, options).sum('price')

Template[templateName].events
	
	'click .clickShowsAddSellerModal': (event, template) ->
		Modal.show('modal_addSeller')
templateName = 'page_sellers'

Template[templateName].helpers
	
	sellers: () ->
		options =
			sort:
				[['number', 'desc']]
		return Sellers.find({}, options)

Template[templateName].events
	
	'click .clickShowsAddSellerModal': (event, template) ->
		Modal.show('modal_addSeller')
	
	'click .clickShowsSellerInfo': (event, template) ->
		Modal.show('modal_showSeller', this)
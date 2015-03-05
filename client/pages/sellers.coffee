templateName = 'page_sellers'

Template[templateName].created = ->
	@sellersPaginator = new Paginator(Sellers)

Template[templateName].helpers
	
	sellers: () ->
		options =
			sort:
				[['number', 'desc']]
			itemsPerPage: 25
		return Template.instance().sellersPaginator.find({}, options)

Template[templateName].events
	
	'click .clickShowsAddSellerModal': (event, template) ->
		Modal.show('modal_addSeller')
	
	'click .clickShowsSellerInfo': (event, template) ->
		Modal.show('modal_showSeller', this)
templateName = 'page_export'

Template[templateName].created = ->
	@dataString = new ReactiveVar("")

Template[templateName].helpers
	dataString: () ->
		return Template.instance().dataString.get()

Template[templateName].events
	'submit form': (event, template) ->
		event.preventDefault()
		
		data = {}
		
		if template.find('#exportSellers').checked
			options =
				fields:
					_id: 0
				transform: null
			data.sellers = Sellers.find({}, options).fetch()
		
		if template.find('#exportPurchases').checked
			options =
				fields:
					_id: 0
				transform: null
			data.purchases = Purchases.find({}, options).fetch()
		
		template.dataString.set(JSON.stringify(data))
		Tracker.afterFlush ->
			template.$('#dataString').select()
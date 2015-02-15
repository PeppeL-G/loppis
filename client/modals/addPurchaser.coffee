templateName = 'modal_addPurchase'

NewPurchases = new Mongo.Collection null, transform: (doc) ->
	return new Purchase(doc)

Template[templateName].created = ->
	
	@paid = new ReactiveVar(0)
	
	@autorun =>
		
		# Should always be at least one product.
		if NewPurchases.find().count() == 0
			
			options =
				sort:
					[['number', 'desc']]
			prevPurchase = Purchases.findOne({}, options)
			if prevPurchase
				number = prevPurchase.getNumber()+1
			else
				number = 1
			
			NewPurchases.insert
				number: number
				sellerNumber: -1
				price: 0

Template[templateName].helpers
	
	newPurchases: () ->
		options =
			sort:
				[['number', 'asc']]
		return NewPurchases.find({}, options)
	
	totalPrice: () ->
		
		where =
			price: {$type: 1}
		
		options =
			transform: null
		
		return NewPurchases.find(where, options).sum('price')
	
	change: () ->
		
		where =
			price: {$type: 1}
		
		options =
			transform: null
		
		totalPrice = NewPurchases.find(where, options).sum('price')
		
		return Template.instance().paid.get() - totalPrice

Template[templateName].events
	
	'click .clickAddsProduct': (event, template) ->
		options =
			sort:
				[['number', 'desc']]
		prevPurchase = NewPurchases.findOne({}, options)
		
		NewPurchases.insert
			number: prevPurchase.getNumber()+1
			sellerNumber: ""
			price: ""
	
	'input .sellerNumber': (event, template) ->
		
		sellerNumber = event.currentTarget.value
		
		if sellerNumber != ""
			
			updates =
				$set:
					sellerNumber: parseInt(sellerNumber)
			
			NewPurchases.update(@getId(), updates)
	
	'input .price': (event, template) ->
		
		price = event.currentTarget.value
		
		if price != ""
			
			updates =
				$set:
					price: parseInt(price)
			
			NewPurchases.update(@getId(), updates)
	
	'click .clickRemovesPurchase': (event, template) ->
		NewPurchases.remove(@getId())
	
	'input .paid': (event, template) ->
		
		paid = event.currentTarget.value
		
		if paid != ""
			template.paid.set(parseInt(paid))
	
	'submit form': (event, template) ->
		
		event.preventDefault()
		
		NewPurchases.find().forEach (purchase) ->
			
			purchase =
				number: purchase.getNumber()
				sellerNumber: purchase.getSellerNumber()
				price: purchase.getPrice()
			
			Purchases.insert(purchase)
		
		Modal.hide()
	
	'click .showNew': (event, template) ->
		setTimeout ->
			Modal.show('modal_addPurchase')
		, 700

Template[templateName].destroyed = ->
	NewPurchases.remove({})

################################################################################
templateName = 'newPurchase'

Template[templateName].helpers
	
	maxSellerNumber: () ->
		return Sellers.find().count()

Template[templateName].rendered = ->
	@find('.sellerNumber').focus()
templateName = 'modal_addPurchase'

NewPurchases = new Mongo.Collection null, transform: (doc) ->
	return new Purchase(doc)

previousPurchase = null

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
	
	previousPurchase: () ->
		return previousPurchase

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
		
		# Check so all sellers exists.
		wrongNumber = -1
		NewPurchases.find().forEach (purchase) ->
			if not Sellers.findOne({number: purchase.getSellerNumber()})
				wrongNumber = purchase.getSellerNumber()
		
		if wrongNumber != -1
			alert("Det finns ingen säljare med nummer "+wrongNumber+". Avbryter.")
			return
		
		# Remember info about this purchase.
		where =
			price: {$type: 1}
		
		options =
			transform: null
		
		totalPrice = NewPurchases.find(where, options).sum('price')
		paid = template.paid.get()
		previousPurchase =
			paid: paid
			totalPrice: totalPrice
			change: paid - totalPrice
		
		# Add the purchases.
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
	
	'click .clickShowsPreviousPurchase': (event, template) ->
		alert("Förra köpet kostade "+previousPurchase.totalPrice+" kr. Kunden betalade "+previousPurchase.paid+" kr och ska ha "+previousPurchase.change+" kr tillbaka.")

Template[templateName].destroyed = ->
	NewPurchases.remove({})

################################################################################
templateName = 'newPurchase'

Template[templateName].helpers
	
	maxSellerNumber: () ->
		options =
			sort:
				[['number', 'desc']]
		return Sellers.findOne({}, options).getNumber()

Template[templateName].rendered = ->
	@find('.sellerNumber').focus()

Template[templateName].events
	
	'input .sellerNumber': (event, template) ->
		
		sellerNumber = event.currentTarget.value
		
		if sellerNumber == ""
			sellerNumber = -1
		
		updates =
			$set:
				sellerNumber: parseInt(sellerNumber)
		
		NewPurchases.update(template.data.getId(), updates)
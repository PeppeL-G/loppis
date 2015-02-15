templateName = 'modal_generateRandomData'

Template[templateName].events
	
	'submit form': (event, template) ->
		
		event.preventDefault()
		
		# Add sellers.
		numberOfSellers = template.find('.numberOfSellers').value
		
		if numberOfSellers != ''
			
			number = Sellers.find().count()+1
			
			for i in [1..numberOfSellers]
				Sellers.insert
					number: number
					name: "Säljare #"+number
				number++
		
		# Add purchases.
		numberOfPurchases = template.find('.numberOfPurchases').value
		
		if numberOfPurchases == ''
			Modal.hide()
			return
		
		if Sellers.find().count() == 0
			alert("Kan inte lägga till säljningar om det inte finns några säljare!")
			Modal.hide()
			return
		
		sellers = Sellers.find().fetch()
		
		options =
			sort:
				[['number', 'desc']]
		prevPurchase = Purchases.findOne({}, options)
		if prevPurchase
			number = prevPurchase.getNumber()+1
		else
			number = 1
		
		for i in [1..numberOfPurchases]
			Purchases.insert
				number: number
				sellerNumber: sellers[Math.floor(Math.random()*sellers.length)].getNumber()
				price: Math.ceil(Math.random()*300)
			number++
		
		Modal.hide()
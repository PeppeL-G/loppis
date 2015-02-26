templateName = 'page_import'

Template[templateName].events
	'submit form': (event, template) ->
		event.preventDefault()
		
		try
			data = JSON.parse(template.find('#dataString').value)
		catch
			alert("Importeringen misslyckades. Datatexten är i fel format.")
			return
		
		if data.sellers
			for seller in data.sellers
				if Sellers.findOne({number: seller.number})
					alert("Du försöker importera en säljare med säljarnummer "+seller.number+", men det finns redan en säljare med detta säljarnummer på denna datorn. Avbryter importeringen (inget har importerats).")
					return
			
			for seller in data.sellers
				Sellers.insert(seller)
			alert(data.sellers.length+" säljare har blivit importerade. Fortsätter nu med att importera eventuella köp.")
		
		if data.purchases
			
			for purchase in data.purchases
				if not Sellers.findOne({number: purchase.sellerNumber})
					alert("Du försöker importera ett köp med säljarnummer "+purchase.sellerNumber+", men det finns ingen säljare med detta säljarnummer på denna datorn. Avbryter importeringen (enbart eventuella säljare har blivit importerade).")
					return
			
			options =
				sort:
					[['number', 'desc']]
			prevPurchase = Purchases.findOne({}, options)
			if prevPurchase
				number = prevPurchase.getNumber()+1
			else
				number = 1
			
			for purchase in data.purchases
				purchase.number = number
				Purchases.insert(purchase)
				number++
			alert(data.purchases.length+" köp har blivit importerade. De importerade köpten har fått nya köpnummer.")
		
		alert("Klar med all importering!")
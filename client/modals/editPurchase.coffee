templateName = 'modal_editPurchase'

sellerNumber = new ReactiveVar(-1)

Template[templateName].created = ->
	sellerNumber.set(@data.getSellerNumber())

Template[templateName].helpers
	
	maxSellerNumber: () ->
		return Sellers.find().count()
	
	seller: () ->
		return Sellers.findOne({number: sellerNumber.get()})

Template[templateName].events
	
	'input .sellerNumber, ': (event, template) ->
		sellerNumber.set(parseInt(event.currentTarget.value))
	
	'submit form': (event, template) ->
		
		event.preventDefault()
		
		updates =
			$set:
				sellerNumber: sellerNumber.get()
				price: parseInt(template.find('.price').value)
		
		Purchases.update(@getId(), updates)
		
		Modal.hide()
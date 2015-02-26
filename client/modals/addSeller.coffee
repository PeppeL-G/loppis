templateName = 'modal_addSeller'

Template[templateName].helpers
	number: () ->
		options =
			sort:
				[['number', 'desc']]
		prevSeller = Sellers.findOne({}, options)
		if prevSeller
			return prevSeller.getNumber()+1
		else
			return 1

Template[templateName].events
	
	'submit form': (event, template) ->
		
		event.preventDefault()
		
		number = parseInt(template.find('.number').value)
		
		# Validate.
		if Sellers.findOne({number: number})
			alert("Det finns redan en säljare registrerad med numret "+number+".")
			return
		
		seller =
			number: number
			name: template.find('.name').value
		
		Sellers.insert(seller)
		
		Modal.hide()
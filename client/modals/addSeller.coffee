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
		
		seller =
			number: parseInt(template.find('.number').value)
			name: template.find('.name').value
		
		Sellers.insert(seller)
		
		Modal.hide()
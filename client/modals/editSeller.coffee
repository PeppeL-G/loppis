templateName = 'modal_editSeller'

Template[templateName].events
	
	'submit form': (event, template) ->
		
		event.preventDefault()
		
		number = template.data.getNumber()
		name = template.find('.name').value.trim()
		isHelper = template.find('#isHelper').value == 'yes'
		
		# Validate.
		if Sellers.findOne({number: {$ne: number}, name: name})
			alert("Det finns redan en annan säljare registrerad med namnet "+name+".")
			return
		
		updates =
			$set:
				name: name
				isHelper: isHelper
		
		Sellers.update(template.data.getId(), updates)
		
		Modal.hide()
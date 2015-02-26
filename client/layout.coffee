templateName = 'layout'

pages = [
	name: 'Säljare'
	template: 'page_sellers'
,
	name: 'Köp'
	template: 'page_purchases'
,
	name: 'Sammanställning'
	template: 'page_summary'
,
	name: 'Inställningar'
	template: 'page_settings'
,
	name: 'Exportera'
	template: 'page_export'
,
	name: 'Importera'
	template: 'page_import'
,
	name: 'Hjälp/Om'
	template: 'page_help'
]

pages.forEach (page, index) ->
	page.index = index

currentPageIndex = new ReactiveVar(0)

Template[templateName].helpers
	
	getPages: () ->
		return pages
	
	isCurrentPage: () ->
		return currentPageIndex.get() == @index
	
	getCurrentPage: () ->
		return pages[currentPageIndex.get()]

Template[templateName].events
	
	'click .clickChangesPage': (event, template) ->
		event.preventDefault()
		currentPageIndex.set(@index)
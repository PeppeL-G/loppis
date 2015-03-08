tax = 0.20

class Seller
	
	constructor: (@doc) ->
		
	
	getId: () ->
		return @doc._id
	
	getNumber: () ->
		return @doc.number
	
	isHelper: () ->
		return @doc.isHelper
	
	getName: () ->
		return @doc.name
	
	getSales: () ->
		options =
			sort:
				[['number', 'asc']]
		Purchases.find({sellerNumber: @getNumber()})
	
	getSellCount: () ->
		return Purchases.find({sellerNumber: @getNumber()}).count()
	
	getSellAmount: () ->
		amount = 0
		Purchases.find({sellerNumber: @getNumber()}).forEach (purchase) ->
			amount += purchase.getPrice()
		return amount
	
	getProfit: () ->
		if @isHelper()
			return (@getSellAmount()).toFixed(2)
		else
			return (@getSellAmount()*(1-tax)).toFixed(2)

@Sellers = new Ground.Collection 'sellers',
	connection: null
	transform: (doc) ->
		return new Seller(doc)
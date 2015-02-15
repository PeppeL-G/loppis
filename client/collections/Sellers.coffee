class Seller
	
	constructor: (@doc) ->
		
	
	getId: () ->
		return @doc._id
	
	getNumber: () ->
		return @doc.number
	
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
	
	getPartOfSellAmountAsString: (part) ->
		return (@getSellAmount()*part).toFixed(2)

@Sellers = new Ground.Collection 'sellers',
	connection: null
	transform: (doc) ->
		return new Seller(doc)
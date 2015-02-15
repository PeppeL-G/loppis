class @Purchase
	
	constructor: (@doc) ->
		
	
	getId: () ->
		return @doc._id
	
	getNumber: () ->
		return @doc.number
	
	getSellerNumber: () ->
		return @doc.sellerNumber
	
	getSeller: () ->
		return Sellers.findOne({number: @getSellerNumber()})
	
	getPrice: () ->
		return @doc.price

@Purchases = new Ground.Collection 'purchases',
	connection: null
	transform: (doc) ->
		return new Purchase(doc)
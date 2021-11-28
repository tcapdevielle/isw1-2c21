!classDefinition: #Cart category: #'TusLibros-Model'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^self class invalidItemErrorMessage ! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 00:00'!
invalidQuantityErrorMessage

	^self class invalidQuantityErrorMessage ! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:17'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self signalInvalidItem ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:18'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [self signalInvalidQuantity ]! !


!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/22/2013 12:17'!
catalog

	^ catalog! !

!Cart methodsFor: 'content' stamp: 'ds 11/28/2021 16:40:02'!
clean

	items := Bag new.! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/22/2013 12:30'!
content

	^items copy! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/23/2013 12:10'!
itemsAndQuantitiesDo: aBlock

	^ items contents keysAndValuesDo: [ :anItem :aQuantity | aBlock value: anItem value: aQuantity ]! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:29'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:18'!
signalInvalidItem

	self error: self invalidItemErrorMessage! !

!Cart methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:19'!
signalInvalidQuantity

	self error: self invalidQuantityErrorMessage ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty

	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/22/2013 12:31'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity ! !

!Cart methodsFor: 'adding' stamp: 'ds 11/22/2021 14:54:10'!
remove: anItem

	^ items remove: anItem ifAbsent: [].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Model'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^'Item is not in catalog'! !

!Cart class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 00:00'!
invalidQuantityErrorMessage

	^'Invalid number of items'! !


!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CartSession category: #'TusLibros-Model'!
Object subclass: #CartSession
	instanceVariableNames: 'owner cart lastUsedTime systemFacade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:34'!
assertIsNotExpirtedAt: aTime

	(self isExpiredAt: aTime) ifTrue: [ self signalCartSessionExpired ]! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:36'!
isExpiredAt: aTime

	^ (lastUsedTime + systemFacade sessionDuration) < aTime! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:36'!
now

	^systemFacade now! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:37'!
today

	^systemFacade today! !


!CartSession methodsFor: 'session management' stamp: 'HernanWilkinson 6/17/2015 20:35'!
do: aBlock

	| now |

	now := self now.
	self assertIsNotExpirtedAt: now.

	^ [ aBlock value: self ] ensure: [ lastUsedTime := now  ]! !


!CartSession methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2015 20:36'!
initializeOwnedBy: aCustomer with: aCart on: aSystemFacade

	owner := aCustomer.
	cart := aCart.
	systemFacade := aSystemFacade.
	lastUsedTime := self now.! !


!CartSession methodsFor: 'error signal' stamp: 'HernanWilkinson 6/17/2015 20:37'!
signalCartSessionExpired

	self error: systemFacade sessionHasExpiredErrorDescription ! !


!CartSession methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2015 20:34'!
addToCart: anAmount of: aBook

	^cart add: anAmount of: aBook! !

!CartSession methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2015 20:35'!
cartContent

	^cart content! !

!CartSession methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2015 20:35'!
checkOutCartWithCreditCardNumbered: aCreditCartNumber ownedBy: anOwner expiringOn: anExpirationMonthOfYear

	^(Cashier
		toCheckout: cart
		ownedBy: owner
		charging: (CreditCard expiringOn: anExpirationMonthOfYear)
		throught: systemFacade merchantProcessor
		on: self today
		registeringOn: systemFacade salesBook) checkOut ! !

!CartSession methodsFor: 'cart' stamp: 'ds 11/28/2021 16:40:31'!
cleanCart

	cart clean.! !

!CartSession methodsFor: 'cart' stamp: 'ds 11/22/2021 14:55:22'!
removeFromCart: aBook

	^cart remove: aBook.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: #'TusLibros-Model'!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2015 20:37'!
ownedBy: aCustomer with: aCart on: aSystemFacade

	^self new initializeOwnedBy: aCustomer with: aCart on: aSystemFacade! !


!classDefinition: #Cashier category: #'TusLibros-Model'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard owner ticket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:17'!
createLineItemOf: anItem quantity: aQuantity

	^LineItem of: anItem quantity: aQuantity total: (self totalOf: anItem quantity: aQuantity) ! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:25'!
createSale

	^ Sale doneBy: owner certifiedWith: ticket
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:28'!
createTicket

	| lineItems |

	lineItems := OrderedCollection new.
	cart itemsAndQuantitiesDo: [ :anItem :aQuantity |
		lineItems add: (self createLineItemOf: anItem quantity: aQuantity)].

	ticket := Ticket of: lineItems
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:20'!
debitTotal

	merchantProcessor debit: ticket total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:17'!
totalOf: anItem quantity: aQuantity

	^(cart catalog at: anItem) * aQuantity  ! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/22/2013 12:28'!
checkOut

	self createTicket.
	self debitTotal.
	self registerSale.

	^ ticket ! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:02'!
initializeToCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook

	cart := aCart.
	owner := anOwner.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros-Model'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:22'!
assertIsNotEmpty: aCart

	aCart isEmpty ifTrue: [self signalCartCanNotBeEmpty ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:22'!
assertIsNotExpired: aCreditCard on: aDate

	(aCreditCard isExpiredOn: aDate) ifTrue: [self signalCanNotChargeAnExpiredCreditCard]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:00'!
toCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook

	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.

	^self new initializeToCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage

	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage

	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage

	^'Credit card has no credit'! !


!Cashier class methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:22'!
signalCanNotChargeAnExpiredCreditCard

	 self error: self canNotChargeAnExpiredCreditCardErrorMessage ! !

!Cashier class methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:22'!
signalCartCanNotBeEmpty

	self error: self cartCanNotBeEmptyErrorMessage! !


!classDefinition: #Clock category: #'TusLibros-Model'!
Object subclass: #Clock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Clock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 14:23'!
now

	self subclassResponsibility ! !

!Clock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 14:23'!
today

	self subclassResponsibility ! !


!classDefinition: #RealClock category: #'TusLibros-Model'!
Clock subclass: #RealClock
	instanceVariableNames: 'now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!RealClock methodsFor: 'time' stamp: 'ds 11/15/2021 20:12:33'!
initialize
	
	now := DateAndTime now.! !

!RealClock methodsFor: 'time' stamp: 'ds 11/15/2021 20:12:37'!
now
	^ now.! !

!RealClock methodsFor: 'time' stamp: 'ds 11/15/2021 20:12:42'!
today
	^ now date.! !


!classDefinition: #CreditCard category: #'TusLibros-Model'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate

	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth

	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibros-Model'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth

	^self new initializeExpiringOn: aMonth! !


!classDefinition: #LineItem category: #'TusLibros-Model'!
Object subclass: #LineItem
	instanceVariableNames: 'item quantity total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!LineItem methodsFor: 'accessing' stamp: 'HernanWilkinson 6/22/2013 12:33'!
item

	^ item! !

!LineItem methodsFor: 'accessing' stamp: 'ds 11/27/2021 19:06:37'!
quantity

	^ quantity.! !

!LineItem methodsFor: 'accessing' stamp: 'HernanWilkinson 6/22/2013 12:21'!
total

	^ total! !


!LineItem methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:18'!
initializeOf: anItem quantity: aQuantity total: aTotal

	item := anItem.
	quantity := aQuantity.
	total := aTotal

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LineItem class' category: #'TusLibros-Model'!
LineItem class
	instanceVariableNames: ''!

!LineItem class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:18'!
of: anItem quantity: aQuantity total: aTotal

	^self new initializeOf: anItem quantity: aQuantity total: aTotal

! !


!classDefinition: #MerchantProcessor category: #'TusLibros-Model'!
Object subclass: #MerchantProcessor
	instanceVariableNames: 'debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!MerchantProcessor methodsFor: 'debit' stamp: 'HernanWilkinson 6/22/2013 14:31'!
README

	"Aunque nadie subclasifica esta clase, esta para definir el protocolo que se espera que todo MerchantProcessor sepa responder - Hernan"! !

!MerchantProcessor methodsFor: 'debit' stamp: 'ds 11/15/2021 20:44:03'!
debit: anAmount from: aCreditCard

	nil.! !

!MerchantProcessor methodsFor: 'debit' stamp: 'ds 11/15/2021 20:43:50'!
initializeWith: aDebitBehavior
	
	debitBehavior := aDebitBehavior.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessor class' category: #'TusLibros-Model'!
MerchantProcessor class
	instanceVariableNames: ''!

!MerchantProcessor class methodsFor: 'as yet unclassified' stamp: 'ds 11/15/2021 20:43:42'!
withDebitBehavior: aDebitBehavior
	
	^ self new initializeWith: aDebitBehavior.! !


!classDefinition: #Sale category: #'TusLibros-Model'!
Object subclass: #Sale
	instanceVariableNames: 'customer ticket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Sale methodsFor: 'testing' stamp: 'HernanWilkinson 6/22/2013 12:06'!
wasDoneBy: aCustomer

	^customer = aCustomer ! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:26'!
initializeDoneBy: aCustomer certifiedWith: aTicket

	customer := aCustomer.
	ticket := aTicket ! !


!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/22/2013 12:26'!
total

	^ ticket total! !


!Sale methodsFor: 'line items' stamp: 'HernanWilkinson 6/22/2013 12:33'!
lineItemsDo: aBlock

	^ticket lineItemsDo: aBlock ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #'TusLibros-Model'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:25'!
doneBy: aCustomer certifiedWith: aTicket

	^self new initializeDoneBy: aCustomer certifiedWith: aTicket ! !


!classDefinition: #Ticket category: #'TusLibros-Model'!
Object subclass: #Ticket
	instanceVariableNames: 'lineItems'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Ticket methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2015 20:39'!
total

	^lineItems sum: [ :aLineItem | aLineItem total]! !


!Ticket methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:20'!
initializeOf: aCollectionOfLineItems

	lineItems := aCollectionOfLineItems ! !


!Ticket methodsFor: 'line items' stamp: 'HernanWilkinson 6/22/2013 12:33'!
lineItemsDo: aBlock

	^lineItems do: aBlock ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ticket class' category: #'TusLibros-Model'!
Ticket class
	instanceVariableNames: ''!

!Ticket class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:20'!
of: aCollectionOfLineItems

	^self new initializeOf: aCollectionOfLineItems ! !


!classDefinition: #TusLibrosRestServer category: #'TusLibros-Model'!
Object subclass: #TusLibrosRestServer
	instanceVariableNames: 'webServer port tusLibros'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosRestServer methodsFor: 'enabling services' stamp: 'ds 11/15/2021 19:39:56'!
destroy
	
	webServer ifNotNil:[webServer destroy].! !

!TusLibrosRestServer methodsFor: 'enabling services' stamp: 'ds 11/15/2021 19:39:56'!
startListening
	
	webServer startListener.

	^'Listening on port: ', self port asString.
	! !

!TusLibrosRestServer methodsFor: 'enabling services' stamp: 'ds 11/15/2021 19:39:56'!
stopListening
	
	webServer stopListener.
	
	^'Stopped listening from port: ', self port asString! !


!TusLibrosRestServer methodsFor: 'initialization' stamp: 'ds 11/28/2021 18:01:26'!
initializeWith: aPortNumber andTusLibrosInstance: aTusLibrosInstance
		
	tusLibros := aTusLibrosInstance.
	port:= aPortNumber.
	webServer := WebServer new listenOn: self port.
	
	webServer addService: '/createCart' action:           [:request |	 self handleCreateCart: request].
	webServer addService: '/addToCart' action:            [:request |	 self handleAddToCart: request].
	webServer addService: '/removeFromCart' action: [:request |	 self handleRemoveFromCart: request].
	webServer addService: '/cleanCart' action:              [:request |	 self handleCleanCart: request].
	webServer addService: '/listCart' action:                  [:request |	 self handleListCart: request].
	webServer addService: '/checkOutCart' action:       [:request |	 self handleCheckOutCart: request].
	webServer addService: '/listPurchases' action:        [:request |	 self handleListPurchases: request].
	webServer addService: '/catalog' action:                 [:request |	 self handleCatalog: request].! !


!TusLibrosRestServer methodsFor: 'parameter extractors' stamp: 'ds 11/15/2021 21:15:47'!
extractBookFrom: aRequest
	
	^ aRequest fields at: 'bookIsbn'.
		! !

!TusLibrosRestServer methodsFor: 'parameter extractors' stamp: 'ds 11/15/2021 21:12:48'!
extractCartIdFrom: aRequest
	
	^ (aRequest fields at: 'cartId') asNumber.
		! !

!TusLibrosRestServer methodsFor: 'parameter extractors' stamp: 'ds 11/15/2021 21:12:56'!
extractCreditCardNumberFrom: aRequest
	
	^ (aRequest fields at: 'ccn') asNumber.
		! !

!TusLibrosRestServer methodsFor: 'parameter extractors' stamp: 'ds 11/28/2021 17:33:08'!
extractCreditCardOwnerFrom: aRequest

	^ aRequest fields at: 'cco'! !

!TusLibrosRestServer methodsFor: 'parameter extractors' stamp: 'ds 11/15/2021 21:13:00'!
extractExpirationMonthFrom: aRequest
	
	^ ((aRequest fields at: 'cced') copyFrom: 1 to: 2) asNumber.
		! !

!TusLibrosRestServer methodsFor: 'parameter extractors' stamp: 'ds 11/15/2021 21:13:04'!
extractExpirationYearFrom: aRequest
	
	^ ((aRequest fields at: 'cced') copyFrom: 3 to: 6) asNumber.
		! !

!TusLibrosRestServer methodsFor: 'parameter extractors' stamp: 'ds 11/15/2021 21:14:21'!
extractPasswordFrom: aRequest
	
	^ aRequest fields at: 'password'.
		! !

!TusLibrosRestServer methodsFor: 'parameter extractors' stamp: 'ds 11/15/2021 21:15:32'!
extractQuantityFrom: aRequest
	
	^ (aRequest fields at: 'bookQuantity') asNumber.
		! !

!TusLibrosRestServer methodsFor: 'parameter extractors' stamp: 'ds 11/15/2021 21:14:10'!
extractUserFrom: aRequest
	
	^ aRequest fields at: 'clientId'.
		! !


!TusLibrosRestServer methodsFor: 'route handlers' stamp: 'ds 11/28/2021 17:19:52'!
handleAddToCart: aRequest
	
	|cart book quantity |
	
	self onErrorReturn400: [
		cart := self extractCartIdFrom: aRequest.
		book := self extractBookFrom: aRequest.
		quantity := self extractQuantityFrom: aRequest.
	] with: aRequest.
		
	self onErrorReturn200: [
		tusLibros add: quantity of: book toCartIdentifiedAs: cart.
		aRequest send200Response: '0|OK'.
	] with: aRequest.
! !

!TusLibrosRestServer methodsFor: 'route handlers' stamp: 'ds 11/28/2021 17:47:48'!
handleCatalog: aRequest

	self
		send200Json: aRequest
		withData: (tusLibros catalog).
! !

!TusLibrosRestServer methodsFor: 'route handlers' stamp: 'ds 11/28/2021 17:46:38'!
handleCheckOutCart: aRequest
	
	|cart creditCardNumber creditCardExpirationMonth creditCardExpirationYear creditCardOwner|
	
	self onErrorReturn400: [
		cart := self extractCartIdFrom: aRequest.
		creditCardNumber := self extractCreditCardNumberFrom: aRequest.
		creditCardExpirationMonth := self extractExpirationMonthFrom: aRequest.
		creditCardExpirationYear := self extractExpirationYearFrom: aRequest.
		creditCardOwner := (self extractCreditCardOwnerFrom: aRequest).
	] with: aRequest.
		
	self onErrorReturn200: [  | ticket|
		ticket := tusLibros
				checkOutCartIdentifiedAs: cart
				withCreditCardNumbered: creditCardNumber
				ownedBy: creditCardOwner
				expiringOn: (Month month: creditCardExpirationMonth year: creditCardExpirationYear).
				
		self
			send200Json: aRequest
			withData: (self buildTicketResponseFor: ticket).
	] with: aRequest.
! !

!TusLibrosRestServer methodsFor: 'route handlers' stamp: 'ds 11/28/2021 17:23:46'!
handleCleanCart: aRequest
	
	| cart |
	
	self onErrorReturn400: [
		cart := self extractCartIdFrom: aRequest
	] with: aRequest.
		
	self onErrorReturn200: [
		tusLibros cleanCart: cart.
		aRequest send200Response: '0|OK'.
	] with: aRequest.
! !

!TusLibrosRestServer methodsFor: 'route handlers' stamp: 'ds 11/28/2021 17:45:46'!
handleCreateCart: aRequest
	
	|user password|
	
	self onErrorReturn400: [
		user := self extractUserFrom: aRequest.
		password := self extractPasswordFrom: aRequest
	] with: aRequest.
		
	self onErrorReturn200: [ |cartId |
		cartId := tusLibros createCartFor: user authenticatedWith: password.
		self
			send200Json: aRequest
			withData: (Dictionary newFromPairs: {'cartId'. cartId}).
	] with: aRequest.
! !

!TusLibrosRestServer methodsFor: 'route handlers' stamp: 'ds 11/28/2021 17:44:23'!
handleListCart: aRequest
	
	| cart listCart|
	
	self onErrorReturn400: [
		cart := self extractCartIdFrom: aRequest.
	] with: aRequest.
		
	self onErrorReturn200: [
		listCart := tusLibros listCartIdentifiedAs: cart.
		self
			send200Json: aRequest
			withData: (listCart asOrderedCollection asArray).
	] with: aRequest.
! !

!TusLibrosRestServer methodsFor: 'route handlers' stamp: 'ds 11/28/2021 17:42:40'!
handleListPurchases: aRequest
	
	| user password  |

	self onErrorReturn400: [
		user := self extractUserFrom: aRequest.
		password := self extractPasswordFrom: aRequest
	] with: aRequest.
		
	self onErrorReturn200: [
		self
			send200Json: aRequest
			withData: (tusLibros listPurchasesOf: user authenticatingWith: password).
	] with: aRequest.
! !

!TusLibrosRestServer methodsFor: 'route handlers' stamp: 'ds 11/28/2021 17:22:02'!
handleRemoveFromCart: aRequest
	
	| cart book |
	
	self onErrorReturn400: [
		cart := self extractCartIdFrom: aRequest.
		book := self extractBookFrom: aRequest.
	] with: aRequest.
		
	self onErrorReturn200: [
		tusLibros remove: book fromCartIdentifiedAs: cart.
	 	aRequest send200Response: '0|OK'.
	] with: aRequest.
! !


!TusLibrosRestServer methodsFor: 'responses' stamp: 'ds 11/27/2021 18:08:40'!
onErrorReturn200: aBlockOfCode with: request

	^ [aBlockOfCode value]
		on: Error
		do: [:anError |
			request send200Response: 
				(WebUtils jsonEncode: ((Dictionary newFromPairs: {'message'. (anError messageText)})))
		].! !

!TusLibrosRestServer methodsFor: 'responses' stamp: 'ds 11/15/2021 21:05:56'!
onErrorReturn400: aBlockOfCode with: request

	^ [aBlockOfCode value]
		on: Error
		do: [:anError | request send400Response: (anError messageText)].! !

!TusLibrosRestServer methodsFor: 'responses' stamp: 'ds 11/28/2021 17:45:11'!
send200Json: aRequest withData: aCollection

	aRequest send200Response: (WebUtils jsonEncode: aCollection).! !


!TusLibrosRestServer methodsFor: 'accessing' stamp: 'ds 11/28/2021 17:15:39'!
port
	
	^port ifNil: [port:=8080].
	
	! !


!TusLibrosRestServer methodsFor: 'tickets' stamp: 'ds 11/28/2021 17:37:54'!
addLineDetail: aLineItem to: aTicketList 

	aTicketList add: (Dictionary newFromPairs: {
		'item'. aLineItem item. 'total'. aLineItem total
	}).! !

!TusLibrosRestServer methodsFor: 'tickets' stamp: 'ds 11/28/2021 17:39:31'!
buildTicketResponseFor: aTicket

	| responseDict ticketList |
	
	responseDict := Dictionary newFromPairs: {'total'. aTicket total}.
			
	ticketList := OrderedCollection new.
	aTicket lineItemsDo: [:aLineItem | self addLineDetail: aLineItem to: ticketList].
	responseDict add: 'items'->(ticketList asArray).	
	
	^ responseDict.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosRestServer class' category: #'TusLibros-Model'!
TusLibrosRestServer class
	instanceVariableNames: ''!

!TusLibrosRestServer class methodsFor: 'as yet unclassified' stamp: 'ds 11/28/2021 16:09:17'!
listeningOn: aPortNumber

	|authDict tusLibros|
	authDict := Dictionary new.
	authDict add: 'john'->'hunter2'.
	
	tusLibros := TusLibrosSystemFacade
		authenticatingWith: authDict 
		acceptingItemsOf: StoreTestObjectsFactory sampleServerCatalog
		registeringOn: OrderedCollection new
		debitingThrought: (MerchantProcessor withDebitBehavior: [ :anAmount :aCreditCard | ])
		measuringTimeWith: RealClock new.

	^self new initializeWith: aPortNumber andTusLibrosInstance: tusLibros.! !


!classDefinition: #TusLibrosSystemFacade category: #'TusLibros-Model'!
Object subclass: #TusLibrosSystemFacade
	instanceVariableNames: 'validUsersAndPasswords catalog lastId merchantProcessor salesBook clock cartSessions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 11:24'!
canNotChargeAnExpiredCreditCardErrorMessage

	^Cashier canNotChargeAnExpiredCreditCardErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 11:17'!
cartCanNotBeEmptyErrorMessage

	^Cashier cartCanNotBeEmptyErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:27'!
invalidCartIdErrorDescription

	^'Invalid cart id'! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^Cart invalidItemErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'ds 11/28/2021 15:31:00'!
invalidUserAndOrPasswordErrorDescription

	^ self class invalidUserAndOrPasswordErrorDescription.! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 13:07'!
sessionHasExpiredErrorDescription

	^'Can not use the cart after ', self sessionDuration minutes printString , ' minutes of inactivity'! !


!TusLibrosSystemFacade methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 13:02'!
now

	^clock now! !

!TusLibrosSystemFacade methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:49'!
today

	^clock today! !


!TusLibrosSystemFacade methodsFor: 'authentication' stamp: 'HernanWilkinson 6/23/2013 12:18'!
does: aUser authenticatesWith: aPassword

	"Recordar que esto es solo un ejemplo. No se deben guardar passwords en un sistema de verdad sino un
	hash o similar - Hernan"

	| storedPassword |

	storedPassword := validUsersAndPasswords at: aUser ifAbsent: [ ^false ].
	^aPassword = storedPassword ! !

!TusLibrosSystemFacade methodsFor: 'authentication' stamp: 'HernanWilkinson 6/23/2013 12:18'!
if: aUser authenticatesWith: aPassword do: aBlock

	^ (self does: aUser authenticatesWith: aPassword)
		ifTrue: aBlock
		ifFalse: [ self signalInvalidUserAndOrPassword ].
	! !


!TusLibrosSystemFacade methodsFor: 'error signal' stamp: 'HernanWilkinson 6/21/2013 23:27'!
signalInvalidCartId

	self error: self invalidCartIdErrorDescription ! !

!TusLibrosSystemFacade methodsFor: 'error signal' stamp: 'HernanWilkinson 6/21/2013 23:02'!
signalInvalidUserAndOrPassword

	self error: self invalidUserAndOrPasswordErrorDescription! !


!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/21/2013 23:32'!
generateCartId

	"Recuerden que esto es un ejemplo, por lo que voy a generar ids numericos consecutivos, pero en una
	implementacion real no deberian se numeros consecutivos ni nada que genere problemas de seguridad - Hernan"

	lastId := lastId + 1.
	^lastId! !

!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/22/2013 13:02'!
sessionDuration

	^30 minutes! !

!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/17/2015 20:50'!
withCartSessionIdentifiedAs: aCartId do: aBlock

	| cartSession |

	cartSession := cartSessions at: aCartId ifAbsent: [self signalInvalidCartId ].
	^cartSession do: aBlock
! !


!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HAW 11/26/2018 20:18:41'!
add: anAmount of: aBook toCartIdentifiedAs: aCartId

	self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession addToCart: anAmount of: aBook ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'ds 11/18/2021 19:35:24'!
catalog

	^ catalog.! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'ds 11/27/2021 17:36:38'!
checkOutCartIdentifiedAs: aCartId withCreditCardNumbered: aCreditCartNumber ownedBy: anOwner expiringOn: anExpirationMonthOfYear

	self
		withCartSessionIdentifiedAs: aCartId
		do: [ :cartSession |
			^(cartSession
			checkOutCartWithCreditCardNumbered: aCreditCartNumber
			ownedBy: anOwner
			expiringOn: anExpirationMonthOfYear) ]
! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'ds 11/28/2021 16:38:33'!
cleanCart: aCartId

	self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession cleanCart ].! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HernanWilkinson 6/17/2015 20:52'!
createCartFor: aUser authenticatedWith: aPassword

	^ self if: aUser authenticatesWith: aPassword do: [ | cartId cartSession |

		cartId := self generateCartId.
		cartSession := CartSession ownedBy: aUser with: (Cart acceptingItemsOf: catalog) on: self..
		cartSessions at: cartId put: cartSession.

		cartId  ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HernanWilkinson 6/17/2015 20:48'!
listCartIdentifiedAs: aCartId

	^ self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession cartContent ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'ds 11/27/2021 19:47:47'!
listPurchasesOf: aUser authenticatingWith: aPassword

	^self if: aUser authenticatesWith: aPassword do: [ | sales itemsDictionary returnDictionary totalSpent|
		sales := self salesDoneBy: aUser.
		returnDictionary := Dictionary new.
		itemsDictionary :=sales
						inject: Dictionary new
						into: [ :salesOrderedByBook :aSale |
								self list: aSale on: salesOrderedByBook.
								salesOrderedByBook 
							].
		returnDictionary add: 'items'->itemsDictionary.
		totalSpent := 0.
		itemsDictionary do: [:detail | totalSpent := totalSpent + (detail at: 'price')].
		returnDictionary add: 'total'->totalSpent.
		^ returnDictionary.
		].! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'ds 11/22/2021 14:55:51'!
remove: aBook fromCartIdentifiedAs: aCartId

	self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession removeFromCart: aBook ]! !


!TusLibrosSystemFacade methodsFor: 'checkout support' stamp: 'HernanWilkinson 6/17/2015 20:49'!
merchantProcessor

	^ merchantProcessor! !

!TusLibrosSystemFacade methodsFor: 'checkout support' stamp: 'HernanWilkinson 6/17/2015 20:50'!
salesBook

	^ salesBook! !


!TusLibrosSystemFacade methodsFor: 'private' stamp: 'ds 11/28/2021 17:56:26'!
list: aSale on: salesOrderedByBook

	aSale lineItemsDo: [ :aLineItem | | oldPriceTotal newPriceTotal oldQuantityTotal newQuantityTotal saleItem|
		saleItem := salesOrderedByBook at: (aLineItem item) ifAbsentPut: [Dictionary new].
		
		oldPriceTotal := saleItem at: 'price' ifAbsentPut: [ 0 ].
		newPriceTotal := oldPriceTotal + aLineItem total.
		saleItem at: 'price' put: newPriceTotal.
				
		oldQuantityTotal := saleItem at: 'quantity' ifAbsentPut: [ 0 ].
		newQuantityTotal := oldQuantityTotal + aLineItem quantity.
		saleItem at: 'quantity' put: newQuantityTotal.

		salesOrderedByBook at: (aLineItem item) put: saleItem.
	].! !

!TusLibrosSystemFacade methodsFor: 'private' stamp: 'HernanWilkinson 6/17/2015 20:55'!
salesDoneBy: aUser

	"Esto es un indicio de que por ahi conviene empezar a pensar en modelar un SaleBook - Hernan"
	^ salesBook select: [ :aSale | aSale wasDoneBy: aUser ]! !


!TusLibrosSystemFacade methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 14:17'!
initializeAuthenticatingWith: aValidUsersAndPasswords
	acceptingItemsOf: aCatalog
	registeringOn: aSalesBook
	debitingThrought: aMerchantProcessor
	measuringTimeWith: aClock

	validUsersAndPasswords := aValidUsersAndPasswords.
	catalog := aCatalog.
	salesBook := aSalesBook.
	merchantProcessor := aMerchantProcessor.
	clock := aClock.

	cartSessions := Dictionary new.
	lastId := 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosSystemFacade class' category: #'TusLibros-Model'!
TusLibrosSystemFacade class
	instanceVariableNames: ''!

!TusLibrosSystemFacade class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 14:17'!
authenticatingWith: aValidUsersAndPasswords
	acceptingItemsOf: aCatalog
	registeringOn: aSalesBook
	debitingThrought: aMerchantProcessor
	measuringTimeWith: aClock

	^self new
		initializeAuthenticatingWith: aValidUsersAndPasswords
		acceptingItemsOf: aCatalog
		registeringOn: aSalesBook
		debitingThrought: aMerchantProcessor
		measuringTimeWith: aClock! !


!TusLibrosSystemFacade class methodsFor: 'errors' stamp: 'ds 11/28/2021 15:31:06'!
invalidUserAndOrPasswordErrorDescription

	^'Invalid user and/or password'.! !

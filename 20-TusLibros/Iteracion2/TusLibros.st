!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'asserts' stamp: 'ds 11/2/2021 19:48:19'!
assertCheckoutWithCashier: aCashier cart: aCart andCreditCard: aCreditCard failsWithError: anError

	self 
		should: [aCashier checkout: aCart withCreditCard: aCreditCard ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :err |
			self assert: err messageText = anError.
		].! !

!CashierTest methodsFor: 'asserts' stamp: 'ds 11/3/2021 18:14:56'!
assertStandardCheckoutWithCart: aCart hasReceipt: aReceiptValue
	
	| creditCard cashier receipt |
	
	creditCard := self sampleCreditCard.
	cashier := self sampleCashier.
	
	receipt := cashier checkout: aCart withCreditCard: creditCard.
	self assert: aReceiptValue equals: receipt.
	
	! !


!CashierTest methodsFor: 'instance creation' stamp: 'ds 11/2/2021 18:07:04'!
expiredCreditCard
	
	^ CreditCard withNumber: 12345 owner: 'Mauricio' expiring: (GregorianMonthOfYear juneOf: 2020).! !

!CashierTest methodsFor: 'instance creation' stamp: 'ds 11/1/2021 20:04:26'!
sampleCart
	
	^ Cart acceptingItemsOf: #('333' '555' '777').! !

!CashierTest methodsFor: 'instance creation' stamp: 'ds 11/2/2021 19:58:00'!
sampleCartWithBook: aBook
	
	| cart |
	
	cart := Cart acceptingItemsOf: #('333' '555' '777').
	cart add: aBook.
	^ cart.! !

!CashierTest methodsFor: 'instance creation' stamp: 'ds 11/2/2021 19:57:10'!
sampleCartWithDefaultBooks
	
	| cart |
	
	cart := Cart acceptingItemsOf: #('333' '555' '777').
	cart add: 3 of: '333'.
	cart add: '555'.
	^ cart.! !

!CashierTest methodsFor: 'instance creation' stamp: 'ds 11/3/2021 17:43:31'!
sampleCashier

	^ Cashier 
		with: (Dictionary newFromPairs: {'333'. 3.14. '555'. 4.75. '777'. 8.00})
		andMerchantProcessor: SimulatedValidMerchantProcessorInterface new.! !

!CashierTest methodsFor: 'instance creation' stamp: 'ds 11/2/2021 19:25:55'!
sampleCashierWithMerchantProcessor: aMerchantProcessor

	^ Cashier with: (Dictionary newFromPairs: {'333'. 3.14. '555'. 4.75. '777'. 8.00}) andMerchantProcessor: aMerchantProcessor.! !

!CashierTest methodsFor: 'instance creation' stamp: 'ds 11/2/2021 18:06:06'!
sampleCreditCard
	
	^ CreditCard withNumber: 12345 owner: 'Mauricio' expiring: (GregorianMonthOfYear juneOf: 2025).! !


!CashierTest methodsFor: 'test - correct checkout' stamp: 'ds 11/3/2021 18:16:18'!
test02checkingOutASingleBook
	
	self
		assertStandardCheckoutWithCart: (self sampleCartWithBook: '555')
		hasReceipt: 4.75.
	
	! !

!CashierTest methodsFor: 'test - correct checkout' stamp: 'ds 11/3/2021 18:17:07'!
test03checkingOutASingleDifferentBook
	
	self
		assertStandardCheckoutWithCart: (self sampleCartWithBook: '333')
		hasReceipt: 3.14.
	
	! !

!CashierTest methodsFor: 'test - correct checkout' stamp: 'ds 11/3/2021 18:17:55'!
test05checkingOutMultipleBooks
	
	| cart |
	
	cart := self sampleCartWithDefaultBooks.
	cart add: 2 of: '777'.
	
	self
		assertStandardCheckoutWithCart: cart
		hasReceipt: ((3*3.14) + 4.75 + (2*8.00)).
	
	! !


!CashierTest methodsFor: 'test - invalid checkout' stamp: 'ds 11/3/2021 18:20:10'!
test01checkingOutAnEmptyCartProducesError

	self assertCheckoutWithCashier: self sampleCashier 
		cart: self sampleCart
		andCreditCard: self sampleCreditCard 
		failsWithError: Cashier canNotCheckOutEmptyCartErrorMessage.! !

!CashierTest methodsFor: 'test - invalid checkout' stamp: 'ds 11/3/2021 18:18:57'!
test06creditCardMustNotBeExpiredForCheckout
	
	self assertCheckoutWithCashier: self sampleCashier 
		cart: self sampleCartWithDefaultBooks
		andCreditCard: self expiredCreditCard 
		failsWithError: Cashier expiredCreditCardErrorMessage.! !

!CashierTest methodsFor: 'test - invalid checkout' stamp: 'ds 11/3/2021 18:19:27'!
test07canNotCheckOutWithOutOfFundsCard
	
	self assertCheckoutWithCashier: (self sampleCashierWithMerchantProcessor: SimulatedNoFundsMerchantProcessorInterface new)
		cart: self sampleCartWithDefaultBooks
		andCreditCard: self sampleCreditCard 
		failsWithError: MerchantProcessorInterface invalidNoFundsErrorDescription.! !

!CashierTest methodsFor: 'test - invalid checkout' stamp: 'ds 11/3/2021 18:19:48'!
test08canNotCheckOutWithStolenCard

	self assertCheckoutWithCashier: (self sampleCashierWithMerchantProcessor: SimulatedStolenCardMerchantProcessorInterface new)
		cart: self sampleCartWithDefaultBooks
		andCreditCard: self sampleCreditCard 
		failsWithError: MerchantProcessorInterface invalidStolenCardErrorDescription.! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'asserts' stamp: 'ds 11/2/2021 20:00:14'!
assertCreatingCardWithNumber: aNumber andOwner: anOwner expiring: aDate failsWithError: anError

	self 
		should: [ CreditCard withNumber: aNumber owner: anOwner  expiring: aDate. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :err |
			self assert: err messageText = anError.
		].! !


!CreditCardTest methodsFor: 'tests' stamp: 'ds 11/2/2021 20:03:02'!
test01createACreditCard
	
	| date creditCard |
	
	date := GregorianMonthOfYear marchOf: 2025.
	
	creditCard := CreditCard withNumber: 12345 owner: 'Mauricio Macri'  expiring: date.
	
	self assert: 12345 equals: creditCard number.
	self assert: 'Mauricio Macri' equals: creditCard owner.
	self assert: date equals: creditCard expirationDate.
	self assert: 3 equals: creditCard expirationMonth.
	self assert: 2025 equals: creditCard expirationYear.! !

!CreditCardTest methodsFor: 'tests' stamp: 'ds 11/2/2021 20:01:04'!
test02creditCardMustHaveNonEmptyName

	self assertCreatingCardWithNumber: 12345 
		andOwner: ''
		expiring: (GregorianMonthOfYear marchOf: 2025)
		failsWithError: CreditCard invalidNameErrorMessage.! !

!CreditCardTest methodsFor: 'tests' stamp: 'ds 11/2/2021 20:01:23'!
test03creditCardMustHaveNonBlankName
	
	self assertCreatingCardWithNumber: 12345 
		andOwner: '     '
		expiring: (GregorianMonthOfYear marchOf: 2025)
		failsWithError: CreditCard invalidNameErrorMessage.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidItem: anItem

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'ds 11/1/2021 20:11:43'!
items
	
	^ items.! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !

!Cart methodsFor: 'testing' stamp: 'ds 11/1/2021 20:08:36'!
listBooksAndQuantities
	
	| list |
	
	list :=  OrderedCollection new.
	items keysAndValuesDo: [:book :amount| list addLast: {book. amount}].
	^ list.! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'prices merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'ds 11/2/2021 19:29:38'!
checkout: aCart withCreditCard: aCreditCard
	
	| totalPrice processorResponse |
	
	self assertCartIsNotEmpty: aCart.
	self assertCreditCardIsNotExpired: aCreditCard.
	
	totalPrice := self totalCartPriceFor: aCart.
	
	processorResponse := merchantProcessor debitFrom: aCreditCard withAmount: totalPrice.
	
		
	^ self totalCartPriceFor: aCart.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'ds 11/1/2021 20:15:30'!
priceFor: aBook

	^ prices at: aBook.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'ds 11/1/2021 20:17:19'!
totalCartPriceFor: aCart

	^ aCart items sum: [:book | self priceFor: book].! !


!Cashier methodsFor: 'asserts' stamp: 'ds 11/1/2021 20:16:49'!
assertCartIsNotEmpty: aCart
	
	aCart isEmpty ifTrue: [self error: Cashier canNotCheckOutEmptyCartErrorMessage].! !

!Cashier methodsFor: 'asserts' stamp: 'ds 11/2/2021 18:37:10'!
assertCreditCardIsNotExpired: aCreditCard

	| today |
	
	today := FixedGregorianDate today.
	
	(today year number < (aCreditCard expirationYear)) ifTrue: [^ false].
	(today month number <= (aCreditCard expirationMonth)) ifTrue: [^ false].
	self error: Cashier expiredCreditCardErrorMessage.! !

!Cashier methodsFor: 'asserts' stamp: 'ds 11/2/2021 19:35:01'!
assertMerchantProcessorResponseIsOK: aMerchantProcessorResponse
	
	aMerchantProcessorResponse ! !


!Cashier methodsFor: 'initialization' stamp: 'ds 11/2/2021 19:46:04'!
initializeWith: aDictOfPrices
	
	prices := aDictOfPrices.
	merchantProcessor := SimulatedValidMerchantProcessorInterface new.! !

!Cashier methodsFor: 'initialization' stamp: 'ds 11/2/2021 19:23:26'!
initializeWith: aDictOfPrices andMerchantProcessor: aMerchantProcessor
	
	prices := aDictOfPrices.
	merchantProcessor := aMerchantProcessor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'ds 11/2/2021 19:25:34'!
with: aDictOfPrices andMerchantProcessor: aMerchantProcessor
	
	^ self new initializeWith: aDictOfPrices andMerchantProcessor: aMerchantProcessor.! !


!Cashier class methodsFor: 'errors' stamp: 'ds 11/1/2021 19:45:56'!
canNotCheckOutEmptyCartErrorMessage
	
	^ 'can not check out empty cart!!!!!!'.! !

!Cashier class methodsFor: 'errors' stamp: 'ds 11/1/2021 20:29:44'!
creditCardInvalidNameErrorMessage
	
	^ 'credit card has invalid name!!!!!!'.! !

!Cashier class methodsFor: 'errors' stamp: 'ds 11/2/2021 18:09:08'!
expiredCreditCardErrorMessage
	
	^ 'credit card is expired!!!!!!'.! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'number ownerName expirationMonthAndYear'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'expiration dates' stamp: 'ds 11/1/2021 19:41:17'!
expirationDate

	^ expirationMonthAndYear.! !

!CreditCard methodsFor: 'expiration dates' stamp: 'ds 11/2/2021 18:31:20'!
expirationMonth

	^ expirationMonthAndYear month number.! !

!CreditCard methodsFor: 'expiration dates' stamp: 'ds 11/2/2021 18:31:31'!
expirationYear

	^ expirationMonthAndYear year.! !


!CreditCard methodsFor: 'initialization' stamp: 'ds 11/2/2021 18:02:15'!
initializeWithNumber: aNumber owner: aName expiring: aMonthAndYear
	
	self assertNameIsNotBlankOrEmpty: aName.
		
	number := aNumber.
	ownerName := aName.
	expirationMonthAndYear := aMonthAndYear.! !


!CreditCard methodsFor: 'asserts' stamp: 'ds 11/2/2021 18:02:15'!
assertNameIsNotBlankOrEmpty: aName

	^ aName withoutSeparators isEmptyOrNil ifTrue: [self error: CreditCard invalidNameErrorMessage]! !


!CreditCard methodsFor: 'accessing' stamp: 'ds 11/1/2021 19:40:54'!
number

	^ number.! !

!CreditCard methodsFor: 'accessing' stamp: 'ds 11/1/2021 19:41:02'!
owner

	^ ownerName.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'errors' stamp: 'ds 11/2/2021 17:54:44'!
invalidNameErrorMessage
	
	^ 'credit card must have valid name!!!!!!'.! !


!CreditCard class methodsFor: 'instance creation' stamp: 'ds 11/1/2021 19:40:45'!
withNumber: aNumber owner: aName expiring: aMonthAndYear
	
	^ self new initializeWithNumber: aNumber owner: aName expiring: aMonthAndYear.! !


!classDefinition: #MerchantProcessorInterface category: 'TusLibros'!
Object subclass: #MerchantProcessorInterface
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorInterface methodsFor: 'debit' stamp: 'ds 11/2/2021 19:31:09'!
debitFrom: aCreditCard withAmount: anAmount
	
	^ self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorInterface class' category: 'TusLibros'!
MerchantProcessorInterface class
	instanceVariableNames: ''!

!MerchantProcessorInterface class methodsFor: 'errors' stamp: 'ds 11/2/2021 19:36:25'!
invalidNoFundsErrorDescription
	
	^ 'invalid transaction: no funds!!!!!!'.! !

!MerchantProcessorInterface class methodsFor: 'errors' stamp: 'ds 11/2/2021 19:36:22'!
invalidStolenCardErrorDescription
	
	^ 'invalid transaction: stolen card!!!!!!'.! !


!classDefinition: #SimulatedNoFundsMerchantProcessorInterface category: 'TusLibros'!
MerchantProcessorInterface subclass: #SimulatedNoFundsMerchantProcessorInterface
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SimulatedNoFundsMerchantProcessorInterface methodsFor: 'debit' stamp: 'ds 11/2/2021 19:44:09'!
debitFrom: aCreditCard withAmount: anAmount
	
	^ self error: MerchantProcessorInterface invalidNoFundsErrorDescription.! !


!classDefinition: #SimulatedStolenCardMerchantProcessorInterface category: 'TusLibros'!
MerchantProcessorInterface subclass: #SimulatedStolenCardMerchantProcessorInterface
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SimulatedStolenCardMerchantProcessorInterface methodsFor: 'debit' stamp: 'ds 11/2/2021 19:44:09'!
debitFrom: aCreditCard withAmount: anAmount
	
	^ self error: MerchantProcessorInterface invalidStolenCardErrorDescription.! !


!classDefinition: #SimulatedValidMerchantProcessorInterface category: 'TusLibros'!
MerchantProcessorInterface subclass: #SimulatedValidMerchantProcessorInterface
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SimulatedValidMerchantProcessorInterface methodsFor: 'debit' stamp: 'ds 11/2/2021 19:36:57'!
debitFrom: aCreditCard withAmount: anAmount
	
	^ true.! !

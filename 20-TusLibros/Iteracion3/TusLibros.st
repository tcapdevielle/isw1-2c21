!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!classDefinition: #RESTInterfaceTest category: 'TusLibros'!
TestCase subclass: #RESTInterfaceTest
	instanceVariableNames: 'testObjectsFactory timeProvider'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RESTInterfaceTest methodsFor: 'auxiliary' stamp: 'ds 11/8/2021 20:20:29'!
assertRunning: aBlockOfCode producesError: anError
	
	self 
		should: aBlockOfCode
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :err | self assert: anError equals: err messageText].! !

!RESTInterfaceTest methodsFor: 'auxiliary' stamp: 'ds 11/8/2021 20:29:29'!
createFirstCart: anInterface

	^ anInterface createCartFor: 'john' withPassword: 'hunter2'.! !

!RESTInterfaceTest methodsFor: 'auxiliary' stamp: 'TC 11/11/2021 14:54:34'!
sampleInterface 

	| users |
	users := Dictionary new.
	users add: 'john'->'hunter2'.
	
	^ RESTInterface 
		withUsers: users 
		withCatalog: (testObjectsFactory defaultCatalog) 
		withTimeProvider: timeProvider 
		withMerchantProcessor: (MerchantProcessor 
		withDebitBehavior: [ :anAmount :aCreditCard | ]).! !

!RESTInterfaceTest methodsFor: 'auxiliary' stamp: 'TC 11/11/2021 15:02:23'!
withTestContext: aBlockOfCode
	
	|interface cartId creditCard|
	
	interface := self sampleInterface.
	cartId := self createFirstCart: interface.
	creditCard := testObjectsFactory notExpiredCreditCard.
	
	aBlockOfCode value: interface value: cartId value: creditCard.! !


!RESTInterfaceTest methodsFor: 'setUp/tearDown' stamp: 'ds 11/9/2021 17:47:10'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	timeProvider := TestTimeProvider new.! !


!RESTInterfaceTest methodsFor: 'tests - cart adding' stamp: 'TC 11/11/2021 15:05:47'!
test07addingItemToInvalidCartThrowsAnError
		
	self withTestContext: [:interface :cartId :creditCard |
		self
			assertRunning: [ interface addToCart: (cartId + 1) book: 123 times: 1 ]
			producesError: RESTInterface invalidCartIdErrorMessage.
	].! !

!RESTInterfaceTest methodsFor: 'tests - cart adding' stamp: 'TC 11/11/2021 15:06:47'!
test11addingAnItemToExistingCartAddsItToTheCollection
		
	self withTestContext: [:interface :cartId :creditCard |
		interface addToCart: cartId book: 'validBook' times: 3.
	
		self 
			assert: (Bag new add: 'validBook' withOccurrences: 3; yourself)
			equals: (interface listCart: cartId).
	
	].! !


!RESTInterfaceTest methodsFor: 'tests - cart checkout' stamp: 'TC 11/11/2021 15:10:18'!
test13checkOutNonExistingCartThrowsAnError
		
	self withTestContext: [:interface :cartId :creditCard |
		self
			assertRunning: [ interface checkOutCart: (cartId + 1) withCard: creditCard ]
			producesError: RESTInterface invalidCartIdErrorMessage.
	].! !

!RESTInterfaceTest methodsFor: 'tests - cart checkout' stamp: 'TC 11/11/2021 15:10:56'!
test17checkOutCorrectlyOnce
	
	self withTestContext: [:interface :cartId :creditCard |
		interface addToCart: cartId book: 'validBook' times: 3.
		interface addToCart: cartId book: 'validBook2' times: 1.
		self assert: 0 equals: (interface checkOutCart: cartId withCard: creditCard).
	].! !

!RESTInterfaceTest methodsFor: 'tests - cart checkout' stamp: 'TC 11/11/2021 15:13:07'!
test18checkOutCorrectlySeveralTimes

	self withTestContext: [:interface :cartId :creditCard |
		interface addToCart: cartId book: 'validBook' times: 3.
		interface addToCart: cartId book: 'validBook2' times: 1.
	
		self assert: 0 equals: (interface checkOutCart: cartId withCard: creditCard).
	
		interface addToCart: cartId book: 'validBook3' times: 5.
	
		self assert: 1 equals: (interface checkOutCart: cartId withCard: creditCard).
		
	].
	! !


!RESTInterfaceTest methodsFor: 'tests - cart creation' stamp: 'TC 11/11/2021 14:44:05'!
test01creatingCartWithInvalidUserThrowsAnError
	
	self
		assertRunning: [ self sampleInterface createCartFor: 'andrew' withPassword: 'pass123' ]
		producesError: RESTInterface invalidCredentialsErrorMessage.! !

!RESTInterfaceTest methodsFor: 'tests - cart creation' stamp: 'TC 11/11/2021 14:44:05'!
test02creatingCartWithIncorrectPasswordThrowsAnError
	
	self
		assertRunning: [ self sampleInterface createCartFor: 'john' withPassword: 'pass123' ]
		producesError: RESTInterface invalidCredentialsErrorMessage.! !

!RESTInterfaceTest methodsFor: 'tests - cart creation' stamp: 'TC 11/11/2021 14:33:13'!
test03creatingCartWithValidCredentialsReturnsCartId
	
	| interface |
	
	interface := self sampleInterface.
	
	self assert: 0 equals: (interface createCartFor: 'john' withPassword: 'hunter2').! !

!RESTInterfaceTest methodsFor: 'tests - cart creation' stamp: 'TC 11/11/2021 14:33:33'!
test04cartIdsAreAssignedIncrementally
	
	| interface |
	
	interface := self sampleInterface.
	
	self assert: 0 equals: (interface createCartFor: 'john' withPassword: 'hunter2').
	self assert: 1 equals: (interface createCartFor: 'john' withPassword: 'hunter2').! !


!RESTInterfaceTest methodsFor: 'tests - cart expiration' stamp: 'TC 11/11/2021 15:14:03'!
test19canNotListAnExpiredCart
		
	self withTestContext: [:interface :cartId :creditCard |
		timeProvider advanceTimeByMinutes: 31.
		self
			assertRunning: [ interface listCart: cartId ]
			producesError: RESTInterface canNotUseCartAfter30MinutesErrorMessage.
	].
	
	
	! !

!RESTInterfaceTest methodsFor: 'tests - cart expiration' stamp: 'TC 11/11/2021 15:14:40'!
test20canNotAddItemsToExpiredCart	
		
	self withTestContext: [:interface :cartId :creditCard |
		timeProvider advanceTimeByMinutes: 31.
		self
			assertRunning: [ interface addToCart: cartId book: 'validBook' times: 1 ]
			producesError: RESTInterface canNotUseCartAfter30MinutesErrorMessage.
	].
	
	
	! !

!RESTInterfaceTest methodsFor: 'tests - cart expiration' stamp: 'TC 11/11/2021 15:15:15'!
test21canNotCheckoutExpiredCart
		
	self withTestContext: [:interface :cartId :creditCard |
		timeProvider advanceTimeByMinutes: 31.
		self
			assertRunning: [ interface checkOutCart: cartId withCard: testObjectsFactory notExpiredCreditCard ]
			producesError: RESTInterface canNotUseCartAfter30MinutesErrorMessage.
	].
	
	
	! !

!RESTInterfaceTest methodsFor: 'tests - cart expiration' stamp: 'TC 11/11/2021 15:16:07'!
test22cartLastTimeUsedIsRefreshedAfterEachUse
		
	self withTestContext: [:interface :cartId :creditCard |
		timeProvider advanceTimeByMinutes: 20.
		self assert: (interface listCart: cartId) isEmpty.
	
		timeProvider advanceTimeByMinutes: 15.
		self assert: (interface listCart: cartId) isEmpty.
	
		timeProvider advanceTimeByMinutes: 31.
		self
			assertRunning: [ interface listCart: cartId ]
			producesError: RESTInterface canNotUseCartAfter30MinutesErrorMessage.
	].
	
	
	! !


!RESTInterfaceTest methodsFor: 'tests - cart listing' stamp: 'TC 11/11/2021 15:16:33'!
test05listingEmptyCartReturnsEmptyCollection
	
	self withTestContext: [:interface :cartId :creditCard |
		self createFirstCart: interface.
		self assert: (interface listCart: 0) isEmpty.
	].! !

!RESTInterfaceTest methodsFor: 'tests - cart listing' stamp: 'TC 11/11/2021 14:44:05'!
test06listingInvalidCartThrowsAnError
	
	self withTestContext: [:interface :cartId :creditCard |
		self
			assertRunning: [ interface listCart: (cartId + 1) ]
			producesError: RESTInterface invalidCartIdErrorMessage.
	].! !

!RESTInterfaceTest methodsFor: 'tests - cart listing' stamp: 'TC 11/11/2021 15:01:05'!
test12listingNonEmptyCartReturnsCollectionWithItsContent
	
	| expectedList |
	
	self withTestContext: [:interface :cartId :creditCard |
		
		self createFirstCart: interface.
		interface addToCart: cartId book: 'validBook' times: 3.
		interface addToCart: cartId book: 'validBook2' times: 2.
		interface addToCart: cartId book: 'validBook3' times: 1.
		interface addToCart: cartId book: 'validBook' times: 1.
		
		expectedList := Bag new.
		expectedList add: 'validBook' withOccurrences: 4.
		expectedList add: 'validBook2' withOccurrences: 2.
		expectedList add: 'validBook3'.
		
		self assert: expectedList equals: (interface listCart: cartId).
	].! !


!RESTInterfaceTest methodsFor: 'tests - list purchases' stamp: 'TC 11/11/2021 14:44:05'!
test23listingPurchasesOfInvalidUserThrowsAnError
	
	self
		assertRunning: [ self sampleInterface listPurchasesFor: 'andrew' withPassword: 'pass123' ]
		producesError: RESTInterface invalidCredentialsErrorMessage.! !

!RESTInterfaceTest methodsFor: 'tests - list purchases' stamp: 'TC 11/11/2021 14:44:05'!
test24listingPurchasesOfUserWithIncorrectPasswordThrowsAnError
	
	self
		assertRunning: [ self sampleInterface listPurchasesFor: 'john' withPassword: 'pass123' ]
		producesError: RESTInterface invalidCredentialsErrorMessage.! !

!RESTInterfaceTest methodsFor: 'tests - list purchases' stamp: 'TC 11/11/2021 14:42:55'!
test25listingPurchasesForNewUserReturnsEmptyCollection
	
	self assert: (self sampleInterface listPurchasesFor: 'john' withPassword: 'hunter2') isEmpty.! !

!RESTInterfaceTest methodsFor: 'tests - list purchases' stamp: 'TC 11/11/2021 15:19:08'!
test26listingPurchasesRegistersSinglePurchase
	
	| expectedItems expectedReport |
	
	self withTestContext: [:interface :cartId :creditCard |
		interface addToCart: cartId book: 'validBook' times: 2.
		interface addToCart: cartId book: 'validBook2' times: 3.
		interface checkOutCart: cartId withCard: creditCard.
	
		expectedItems := Bag new.
		expectedItems add: 'validBook' withOccurrences: 2.
		expectedItems add: 'validBook2' withOccurrences: 3.
		expectedReport := UserPurchasesReport withTotal: (10*2) + (20*3) andItems: expectedItems.
		
		self assert: expectedReport = (interface listPurchasesFor: 'john' withPassword: 'hunter2').
	].! !

!RESTInterfaceTest methodsFor: 'tests - list purchases' stamp: 'TC 11/11/2021 15:23:12'!
test27listingPurchasesRegistersMultiplePurchases
	
	| cartId2 expectedItems expectedReport |

	self withTestContext: [:interface :cartId :creditCard |
		interface addToCart: cartId book: 'validBook' times: 2.
		interface checkOutCart: cartId withCard: creditCard.
		
		cartId2 := interface createCartFor: 'john' withPassword: 'hunter2'.
		interface addToCart: cartId2 book: 'validBook' times: 1.
		interface addToCart: cartId2 book: 'validBook2' times: 4.
		interface checkOutCart: cartId2 withCard: creditCard.
		
		expectedItems := Bag new.
		expectedItems add: 'validBook' withOccurrences: 3.
		expectedItems add: 'validBook2' withOccurrences: 4.
		expectedReport := UserPurchasesReport withTotal: (10*3) + (20*4) andItems: expectedItems.
		
		self assert: expectedReport equals: (interface listPurchasesFor: 'john' withPassword: 'hunter2').
	].! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'error messages' stamp: 'ds 11/6/2021 17:41:17'!
invalidItemErrorMessage
	
	^ self class invalidItemErrorMessage.! !

!Cart methodsFor: 'error messages' stamp: 'ds 11/6/2021 17:40:52'!
invalidQuantityErrorMessage
	
	^ self class invalidQuantityErrorMessage.! !


!Cart methodsFor: 'initialization' stamp: 'TC 11/11/2021 15:36:08'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'queries' stamp: 'TC 11/11/2021 15:35:09'!
list

	^ items copy.! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'errors' stamp: 'ds 11/6/2021 17:41:12'!
invalidItemErrorMessage
	
	^ 'Item is not in catalog'.! !

!Cart class methodsFor: 'errors' stamp: 'ds 11/6/2021 17:40:39'!
invalidQuantityErrorMessage
	
	^ 'Invalid number of items'.! !


!Cart class methodsFor: 'instance creation' stamp: 'ds 11/6/2021 17:40:15'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'ds 11/9/2021 19:00:05'!
createSale

	^ Sale of: total withItems: (cart list asBag).
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !


!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #MerchantProcessor category: 'TusLibros'!
Object subclass: #MerchantProcessor
	instanceVariableNames: 'debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'debit' stamp: 'ds 11/6/2021 17:31:54'!
debit: anAmount from: aCreditCard 

	nil.! !


!MerchantProcessor methodsFor: 'initialization' stamp: 'ds 11/6/2021 17:27:20'!
initializeWith: aDebitBehavior
	
	debitBehavior := aDebitBehavior.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessor class' category: 'TusLibros'!
MerchantProcessor class
	instanceVariableNames: ''!

!MerchantProcessor class methodsFor: 'instance creation' stamp: 'ds 11/10/2021 21:00:50'!
withDebitBehavior: aDebitBehavior
	
	^ self new initializeWith: aDebitBehavior.! !


!classDefinition: #RESTCart category: 'TusLibros'!
Object subclass: #RESTCart
	instanceVariableNames: 'id cart lastTimeAccessed user'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RESTCart methodsFor: 'accessing' stamp: 'ds 11/9/2021 18:05:54'!
id
	
	^ id.! !

!RESTCart methodsFor: 'accessing' stamp: 'ds 11/9/2021 19:17:46'!
user

	^ user.! !


!RESTCart methodsFor: 'asserts' stamp: 'TC 11/11/2021 14:44:05'!
assertIsNotExpiredWithCurrentTime: aCurrentTime
	
	aCurrentTime - lastTimeAccessed > (self thirtyMinutes) ifTrue: [
		self error: RESTInterface canNotUseCartAfter30MinutesErrorMessage
	].! !

!RESTCart methodsFor: 'asserts' stamp: 'ds 11/9/2021 18:17:50'!
thirtyMinutes

	^ 1800000.! !


!RESTCart methodsFor: 'cart access' stamp: 'ds 11/9/2021 19:24:01'!
cartAtTime: timeOfAccess
	self assertIsNotExpiredWithCurrentTime: timeOfAccess.
	
	lastTimeAccessed := timeOfAccess.
	^ cart.! !

!RESTCart methodsFor: 'cart access' stamp: 'ds 11/9/2021 19:24:14'!
restCartAtTime: timeOfAccess
	self assertIsNotExpiredWithCurrentTime: timeOfAccess.
	
	lastTimeAccessed := timeOfAccess.
	^ self.! !


!RESTCart methodsFor: 'initialization' stamp: 'ds 11/9/2021 19:15:06'!
initializeFor: aCart withId: anId atTime: theCurrentTime fromUser: anUser
	
	id := anId.
	cart := aCart.
	lastTimeAccessed := theCurrentTime.
	user := anUser.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RESTCart class' category: 'TusLibros'!
RESTCart class
	instanceVariableNames: ''!

!RESTCart class methodsFor: 'instance creation' stamp: 'ds 11/9/2021 19:16:36'!
forCart: aCart withId: anId atTime: theCurrentTime fromUser: anUser
	  
	^ self new initializeFor: aCart withId: anId atTime: theCurrentTime fromUser: anUser.
	! !


!classDefinition: #RESTInterface category: 'TusLibros'!
Object subclass: #RESTInterface
	instanceVariableNames: 'usersAndPasswords carts catalog merchantProcessor timeProvider usersSalesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RESTInterface methodsFor: 'authentication' stamp: 'TC 11/11/2021 15:54:44'!
assertThatProvidedPassword: attemptedPassword matches: actualPassword.

	actualPassword = attemptedPassword ifFalse: [self error: RESTInterface invalidCredentialsErrorMessage].
	^ true.

	! !

!RESTInterface methodsFor: 'authentication' stamp: 'TC 11/11/2021 15:54:02'!
authenticateUser: enteredUser withPassword: enteredPassword
	
	^ self 
		assertThatProvidedPassword: enteredPassword 
		matches: (self passwordFor: enteredUser).
	! !

!RESTInterface methodsFor: 'authentication' stamp: 'TC 11/11/2021 15:48:00'!
passwordFor: aUser
	
	^ usersAndPasswords at: aUser ifAbsent: [self error: RESTInterface invalidCredentialsErrorMessage].
! !


!RESTInterface methodsFor: 'cart managament' stamp: 'TC 11/11/2021 15:44:17'!
addNewCartFromUser: aUser

	|restCart addedCartId|
	
	addedCartId := self nextCartId.
	
	restCart := RESTCart
					forCart: (Cart acceptingItemsOf: catalog)
					withId: addedCartId
					atTime: timeProvider currentTime
					fromUser: aUser.
	
	carts add: addedCartId->restCart.
	^ addedCartId.! !

!RESTInterface methodsFor: 'cart managament' stamp: 'TC 11/11/2021 15:29:58'!
cartWithId: aCartId

	| restCart |
	
	restCart := carts at: aCartId ifAbsent: [^ self error: RESTInterface invalidCartIdErrorMessage].
	^ restCart cartAtTime: timeProvider currentTime.
	! !

!RESTInterface methodsFor: 'cart managament' stamp: 'ds 11/9/2021 18:32:32'!
nextCartId
	
	^ carts size.! !

!RESTInterface methodsFor: 'cart managament' stamp: 'TC 11/11/2021 15:30:12'!
restCartWithId: aCartId

	| restCart |
	
	restCart := carts at: aCartId ifAbsent: [^ self error: RESTInterface invalidCartIdErrorMessage].
	^ restCart restCartAtTime: timeProvider currentTime.
	! !


!RESTInterface methodsFor: 'initialization' stamp: 'ds 11/10/2021 20:59:31'!
initializeWith: aDictOfUserPasswords andCatalog: aCatalog andTimeProvider: aTimeProvider andMerchantProcessor: aMerchantProcessor
	
	usersAndPasswords := aDictOfUserPasswords.
	carts := Dictionary new.
	catalog := aCatalog.
	merchantProcessor := aMerchantProcessor.
	timeProvider := aTimeProvider.
	usersSalesBook := Dictionary new.! !


!RESTInterface methodsFor: 'other' stamp: 'TC 11/11/2021 14:48:47'!
checkOutCart: aCart withCard: aCreditCard registeringOn: aSalesBook

	| cashier |
	cashier := Cashier toCheckout: aCart charging: aCreditCard
		throught: merchantProcessor on: (timeProvider today) registeringOn: aSalesBook.

	cashier checkOut.
	
	^ aSalesBook size - 1.! !

!RESTInterface methodsFor: 'other' stamp: 'TC 11/11/2021 15:44:37'!
createEmptySalesBookFor: aUser

	^ usersSalesBook at: aUser put: (OrderedCollection new).! !

!RESTInterface methodsFor: 'other' stamp: 'TC 11/11/2021 15:40:15'!
salesBookForUserOwningCart: aCartId

	| cartUser |
	
	cartUser := (self restCartWithId: aCartId) user.
	^ usersSalesBook at: cartUser ifAbsent: [self createEmptySalesBookFor: cartUser].
! !

!RESTInterface methodsFor: 'other' stamp: 'TC 11/11/2021 15:46:24'!
salesReportForUser: aUser

	| userSales |
	
	userSales := usersSalesBook at: aUser ifAbsent: [^ UserPurchasesReport empty].
	^ UserPurchasesReport forSales: userSales.
! !


!RESTInterface methodsFor: 'resources interface' stamp: 'TC 11/11/2021 15:29:58'!
addToCart: aCartId book: aBookISBN times: anAmount

	(self cartWithId: aCartId) add: anAmount of: aBookISBN.	
	^ true.! !

!RESTInterface methodsFor: 'resources interface' stamp: 'TC 11/11/2021 15:40:15'!
checkOutCart: aCartId withCard: aCreditCard

	|cart salesBook|
	
	cart := self cartWithId: aCartId.
	salesBook := self salesBookForUserOwningCart: aCartId.

	^ self checkOutCart: cart withCard: aCreditCard registeringOn: salesBook.! !

!RESTInterface methodsFor: 'resources interface' stamp: 'ds 11/9/2021 19:15:46'!
createCartFor: anUser withPassword: aPassword
	
	| addedCartId |
	
	self authenticateUser: anUser withPassword: aPassword.
	addedCartId := self addNewCartFromUser: anUser.
	^ addedCartId.! !

!RESTInterface methodsFor: 'resources interface' stamp: 'TC 11/11/2021 15:36:21'!
listCart: aCartId
	
	^ (self cartWithId: aCartId) list.! !

!RESTInterface methodsFor: 'resources interface' stamp: 'TC 11/11/2021 15:46:57'!
listPurchasesFor: aUser withPassword: aPassword
	
	self authenticateUser: aUser withPassword: aPassword.
	^ self salesReportForUser: aUser.
	
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RESTInterface class' category: 'TusLibros'!
RESTInterface class
	instanceVariableNames: ''!

!RESTInterface class methodsFor: 'error messages' stamp: 'ds 11/8/2021 19:36:50'!
canNotUseCartAfter30MinutesErrorMessage
	
	^ 'can not use cart after 30 minutes !!!!!!'.! !

!RESTInterface class methodsFor: 'error messages' stamp: 'ds 11/6/2021 17:21:54'!
checkingOutEmptyCartErrorMessage
	
	^ 'can not check out empty cart !!!!!!'.! !

!RESTInterface class methodsFor: 'error messages' stamp: 'ds 11/4/2021 20:25:32'!
invalidCartIdErrorMessage
	
	^ 'invalid cart id !!!!!!'.! !

!RESTInterface class methodsFor: 'error messages' stamp: 'ds 11/8/2021 20:12:21'!
invalidCredentialsErrorMessage
	
	^ 'invalid credentials !!!!!!'.! !


!RESTInterface class methodsFor: 'instance creation' stamp: 'ds 11/10/2021 20:59:56'!
withUsers: aDictOfUserPassword withCatalog: aCatalog withTimeProvider: aTimeProvider withMerchantProcessor: aMerchantProcessor
	
	^ self new initializeWith: aDictOfUserPassword andCatalog: aCatalog
		andTimeProvider: aTimeProvider andMerchantProcessor: aMerchantProcessor.! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total items user'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'initialization' stamp: 'ds 11/9/2021 18:58:34'!
initializeTotal: aTotal withItems: aBagOfPurchasedItems

	total := aTotal.
	items := aBagOfPurchasedItems.! !


!Sale methodsFor: 'total' stamp: 'ds 11/9/2021 19:31:42'!
items
	
	^ items.! !

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'ds 11/9/2021 18:58:06'!
of: aTotal withItems: aBagOfPurchasedItems

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal withItems: aBagOfPurchasedItems.! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'ds 11/6/2021 17:04:57'!
defaultCatalog

	^ Dictionary new
		at: 'validBook' put: 10;
		at: 'validBook2' put: 20;
		at: 'validBook3' put: 30;
		yourself.! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'ds 11/6/2021 17:32:17'!
merchantProcessor
	
	^ MerchantProcessor new.! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!classDefinition: #TimeProvider category: 'TusLibros'!
Object subclass: #TimeProvider
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TimeProvider methodsFor: 'date' stamp: 'ds 11/9/2021 18:30:34'!
today
	
	^ self subclassResponsibility.! !


!TimeProvider methodsFor: 'time' stamp: 'ds 11/9/2021 17:40:53'!
currentTime
	
	^ self subclassResponsibility.! !


!classDefinition: #CurrentTimeProvider category: 'TusLibros'!
TimeProvider subclass: #CurrentTimeProvider
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CurrentTimeProvider methodsFor: 'date' stamp: 'ds 11/9/2021 18:29:48'!
today
	
	^ Date today.! !


!CurrentTimeProvider methodsFor: 'time' stamp: 'ds 11/9/2021 17:49:45'!
currentTime
	
	^ Time localMillisecondClock.! !


!classDefinition: #TestTimeProvider category: 'TusLibros'!
TimeProvider subclass: #TestTimeProvider
	instanceVariableNames: 'time'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestTimeProvider methodsFor: 'control' stamp: 'ds 11/9/2021 17:42:54'!
advanceTimeByMinutes: aQuantityOfMinutes
	
	time := time + (aQuantityOfMinutes * 60000)! !


!TestTimeProvider methodsFor: 'date' stamp: 'ds 11/9/2021 18:30:21'!
today
	
	^ Date today.! !


!TestTimeProvider methodsFor: 'initialization' stamp: 'ds 11/9/2021 17:41:23'!
initialize
	
	time := Time localMillisecondClock.! !


!TestTimeProvider methodsFor: 'time' stamp: 'ds 11/9/2021 17:41:33'!
currentTime
	
	^ time.! !


!classDefinition: #UserPurchasesReport category: 'TusLibros'!
Object subclass: #UserPurchasesReport
	instanceVariableNames: 'total items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!UserPurchasesReport methodsFor: 'accessing' stamp: 'ds 11/9/2021 19:51:50'!
items
	
	^ items.! !

!UserPurchasesReport methodsFor: 'accessing' stamp: 'ds 11/9/2021 19:51:45'!
total
	
	^ total.! !


!UserPurchasesReport methodsFor: 'initialization' stamp: 'ds 11/10/2021 21:21:55'!
initializeWith: aListOfSales
	
	|totalPurchases|
	totalPurchases := Bag new.
	aListOfSales do: [:sale | totalPurchases addAll: sale items].
	
	total :=  (aListOfSales sum: [:sale | sale total]).
	items := totalPurchases.! !

!UserPurchasesReport methodsFor: 'initialization' stamp: 'ds 11/9/2021 19:42:52'!
initializeWithTotal: aTotalAmount andItems: aBagOfItems
	
	total := aTotalAmount.
	items := aBagOfItems.! !


!UserPurchasesReport methodsFor: 'testing' stamp: 'ds 11/9/2021 19:52:54'!
= anotherUserPurchasesReport
	
	self == anotherUserPurchasesReport ifTrue: [^ true].
	total = anotherUserPurchasesReport total ifFalse: [^ false].
	items = anotherUserPurchasesReport items ifFalse: [^ false].
	
	^ true.! !

!UserPurchasesReport methodsFor: 'testing' stamp: 'ds 11/9/2021 19:56:53'!
isEmpty
	
	^ total = 0 and: items isEmpty.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'UserPurchasesReport class' category: 'TusLibros'!
UserPurchasesReport class
	instanceVariableNames: ''!

!UserPurchasesReport class methodsFor: 'instance creation' stamp: 'ds 11/9/2021 19:56:14'!
empty
	
	^ self new initializeWithTotal: 0 andItems: (Bag new).! !

!UserPurchasesReport class methodsFor: 'instance creation' stamp: 'ds 11/10/2021 21:21:23'!
forSales: aListOfSales
	
	^ self new initializeWith: aListOfSales.
	! !

!UserPurchasesReport class methodsFor: 'instance creation' stamp: 'ds 11/9/2021 19:43:31'!
withTotal: aTotalAmount andItems: aBagOfItems
	
	^ self new initializeWithTotal: aTotalAmount andItems: aBagOfItems.! !

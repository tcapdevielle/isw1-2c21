!classDefinition: #CartTest category: #'TusLibros-Tests'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

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


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #'TusLibros-Tests'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:00'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |

	salesBook := OrderedCollection new.
	self
		should: [ Cashier
			toCheckout: testObjectsFactory createCart
			ownedBy: testObjectsFactory customer
			charging: testObjectsFactory notExpiredCreditCard
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:22'!
test02CalculatedTotalIsCorrect

	| cart cashier |

	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.

	cashier :=  Cashier
		toCheckout: cart
		ownedBy: testObjectsFactory customer
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: OrderedCollection new.

	self assert: cashier checkOut total = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:01'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.

	self
		should: [ Cashier
				toCheckout: cart
				ownedBy: testObjectsFactory customer
				charging: testObjectsFactory expiredCreditCard
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:23'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.

	cashier:= Cashier
		toCheckout: cart
		ownedBy: testObjectsFactory customer
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.

	total := cashier checkOut total.

	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:22'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.

	cashier:= Cashier
		toCheckout: cart
		ownedBy: testObjectsFactory customer
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.

	debitBehavior := [ :anAmount :aCreditCard |
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut total.

	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:02'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].

	cashier:= Cashier
		toCheckout: cart
		ownedBy: testObjectsFactory customer
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


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #TusLibrosRestClientTest category: #'TusLibros-Tests'!
TestCase subclass: #TusLibrosRestClientTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!TusLibrosRestClientTest methodsFor: 'auxiliar' stamp: 'ds 11/28/2021 15:41:11'!
createCartUsing: aClient
	
	|  response |
	
	response := aClient sendCreateCartAs: 'john' withPassword: 'hunter2'.
	^ response at: 'cartId'.! !

!TusLibrosRestClientTest methodsFor: 'auxiliar' stamp: 'ds 11/28/2021 15:38:01'!
createServer
	
	self destroyAllRunningServers.
	^ TusLibrosRestServer listeningOn: 8080.! !

!TusLibrosRestClientTest methodsFor: 'auxiliar' stamp: 'ds 11/28/2021 15:37:31'!
destroyAllRunningServers
	
	TusLibrosRestServer allInstances do: [:instance | instance destroy].! !


!TusLibrosRestClientTest methodsFor: 'test - check out cart' stamp: 'ds 11/28/2021 16:45:19'!
test15_checkOutCart
	
	| server client response cartId|
	server := self createServer.
	client := TusLibrosRestClient new.
	cartId := self createCartUsing: client.
	
	client sendAddToCartFor: cartId withBook: 'validBook10Pesos' withQuantity: 3.
	client sendAddToCartFor: cartId withBook: 'validBook50Pesos' withQuantity: 1.
	
	response := client sendCheckoutRequestFor: cartId.
	self assert: (10+10+10+50) equals: (response at: 'total').
	
	server destroy.! !


!TusLibrosRestClientTest methodsFor: 'test - create cart' stamp: 'ds 11/28/2021 15:38:12'!
test01_createCartWrongPassword
	
	| server client response |
	server := self createServer.
	client := TusLibrosRestClient new.
	
	response := client sendCreateCartAs: 'john' withPassword: 'hunter3'.
	
	self assert: TusLibrosSystemFacade invalidUserAndOrPasswordErrorDescription
		equals: (response at: 'message').
	server destroy.! !

!TusLibrosRestClientTest methodsFor: 'test - create cart' stamp: 'ds 11/28/2021 15:38:18'!
test02_createCartWrongUser
	
	| server client response |
	server := self createServer.
	client := TusLibrosRestClient new.
	
	response := client sendCreateCartAs: 'other' withPassword: 'hunter2'.
	
	self assert: TusLibrosSystemFacade invalidUserAndOrPasswordErrorDescription
		equals: (response at: 'message').
	server destroy.! !

!TusLibrosRestClientTest methodsFor: 'test - create cart' stamp: 'ds 11/28/2021 15:38:21'!
test03_createCartCorrectly
	
	| server client response |
	server := self createServer.
	client := TusLibrosRestClient new.
	
	response := client sendCreateCartAs: 'john' withPassword: 'hunter2'.
	
	self assert: 1 equals: (response at: 'cartId').
	server destroy.! !


!TusLibrosRestClientTest methodsFor: 'test - add to cart' stamp: 'ds 11/28/2021 15:45:34'!
test04_addToCartWrongCart
	
	| server client cartId response |
	server := self createServer.
	client := TusLibrosRestClient new.
	cartId := self createCartUsing: client.
	
	response := client sendAddToCartFor: (cartId+5) withBook: 'validBook' withQuantity: 3.
	self assert: 'Invalid cart id' equals: (response at: 'message').
	
	server destroy.! !

!TusLibrosRestClientTest methodsFor: 'test - add to cart' stamp: 'ds 11/28/2021 15:46:15'!
test05_addToCartWrongBook
	
	| server client cartId response |
	server := self createServer.
	client := TusLibrosRestClient new.
	cartId := self createCartUsing: client.
	
	response := client sendAddToCartFor: cartId withBook: 'invalidBook' withQuantity: 3.
	self assert: 'Item is not in catalog' equals: (response at: 'message').
	
	server destroy.! !

!TusLibrosRestClientTest methodsFor: 'test - add to cart' stamp: 'ds 11/28/2021 15:46:41'!
test06_addToCartWrongAmount
	
	| server client cartId response |
	server := self createServer.
	client := TusLibrosRestClient new.
	cartId := self createCartUsing: client.
	
	response := client sendAddToCartFor: cartId withBook: 'validBook' withQuantity: -4.
	self assert: 'Invalid number of items' equals: (response at: 'message').
	
	server destroy.! !

!TusLibrosRestClientTest methodsFor: 'test - add to cart' stamp: 'ds 11/28/2021 15:59:27'!
test07_addToCartCorrectly
	
	| server client cartId response |
	server := self createServer.
	client := TusLibrosRestClient new.
	cartId := self createCartUsing: client.
	
	response := client sendAddToCartFor: cartId withBook: 'validBook1' withQuantity: 3.
	self assert: 0 equals: response.
	
	response := client sendListCartRequestFor: cartId.
	self assert: 3 equals: response size.
	self assert: 3 equals: ((response asBag) occurrencesOf: 'validBook1').
	
	server destroy.! !


!TusLibrosRestClientTest methodsFor: 'test - catalog' stamp: 'ds 11/28/2021 16:09:37'!
test08_listCatalog
	
	| server client response |
	server := self createServer.
	client := TusLibrosRestClient new.
	
	response := client sendCatalogRequest.
	self assert: (StoreTestObjectsFactory sampleServerCatalog) equals: response.
	
	server destroy.! !


!TusLibrosRestClientTest methodsFor: 'test - list cart' stamp: 'ds 11/28/2021 15:56:12'!
test09_listCartEmpty
	
	| server client cartId response |
	server := self createServer.
	client := TusLibrosRestClient new.
	cartId := self createCartUsing: client.
	
	response := client sendListCartRequestFor: cartId.
	self assert: response isEmpty.
		
	server destroy.! !

!TusLibrosRestClientTest methodsFor: 'test - list cart' stamp: 'ds 11/28/2021 15:58:13'!
test10_listCartNotEmpty
	
	| server client cartId response cartContents |
	server := self createServer.
	client := TusLibrosRestClient new.
	cartId := self createCartUsing: client.
	
	response := client sendAddToCartFor: cartId withBook: 'validBook1' withQuantity: 3.
	response := client sendAddToCartFor: cartId withBook: 'validBook2' withQuantity: 1.
	
	response := client sendListCartRequestFor: cartId.
	cartContents := response asBag.
	
	self assert: 4 equals: cartContents size.
	self assert: 3 equals: (cartContents occurrencesOf: 'validBook1').
	self assert: 1 equals: (cartContents occurrencesOf: 'validBook2').
		
	server destroy.! !


!TusLibrosRestClientTest methodsFor: 'test - remove from cart' stamp: 'ds 11/28/2021 16:11:32'!
test11_removeFromCartInvalidCart
	
	| server client cartId response |
	server := self createServer.
	client := TusLibrosRestClient new.
	cartId := self createCartUsing: client.
	
	response := client sendRemoveFromCartRequestFor: (cartId+5) withBook: 'validBook1'.
	self assert: 'Invalid cart id' equals: (response at: 'message').
		
	server destroy.! !

!TusLibrosRestClientTest methodsFor: 'test - remove from cart' stamp: 'ds 11/28/2021 16:14:12'!
test12_removeFromCart
	
	| server client cartId response |
	server := self createServer.
	client := TusLibrosRestClient new.
	cartId := self createCartUsing: client.
	
	response := client sendRemoveFromCartRequestFor: cartId withBook: 'invalidBook'.
	self assert: 0 equals: response.
		
	server destroy.! !


!TusLibrosRestClientTest methodsFor: 'test - list purchases' stamp: 'ds 11/28/2021 16:16:24'!
test13_listPurchasesWrongPassword
	
	| server client response |
	server := self createServer.
	client := TusLibrosRestClient new.
	
	response := client sendListPurchasesRequest: 'john' withPassword: 'hunter3'.
	self assert: TusLibrosSystemFacade invalidUserAndOrPasswordErrorDescription
		equals: (response at: 'message').
		
	server destroy.! !

!TusLibrosRestClientTest methodsFor: 'test - list purchases' stamp: 'ds 11/28/2021 16:17:31'!
test14_listPurchasesNewUser
	
	| server client response |
	server := self createServer.
	client := TusLibrosRestClient new.
	
	response := client sendListPurchasesRequest: 'john' withPassword: 'hunter2'.
	self assert: (response at: 'items') isEmpty.
		
	server destroy.! !


!TusLibrosRestClientTest methodsFor: 'test - clean cart' stamp: 'ds 11/28/2021 16:45:03'!
test17_cleanCart
	
	| server client cartId|
	server := self createServer.
	client := TusLibrosRestClient new.
	cartId := self createCartUsing: client.
	
	client sendAddToCartFor: cartId withBook: 'validBook10Pesos' withQuantity: 3.
	client sendAddToCartFor: cartId withBook: 'validBook50Pesos' withQuantity: 1.
	self deny: (client sendListCartRequestFor: cartId) isEmpty.
	
	client sendCleanCartRequestFor: cartId.
	self assert: (client sendListCartRequestFor: cartId) isEmpty.	
	
	server destroy.! !


!classDefinition: #TusLibrosSystemFacadeTest category: #'TusLibros-Tests'!
TestCase subclass: #TusLibrosSystemFacadeTest
	instanceVariableNames: 'testObjectsFactory clock systemFacade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!TusLibrosSystemFacadeTest methodsFor: 'tests - add to cart' stamp: 'HAW 6/19/2018 11:41:46'!
test04CanAddItemsToACreatedCart

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.

	systemFacade add: 1 of: self validBook toCartIdentifiedAs: cartId.
	self assert: ((systemFacade listCartIdentifiedAs: cartId) occurrencesOf: self validBook) equals: 1
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - add to cart' stamp: 'HAW 11/26/2018 18:03:02'!
test05CanNotAddItemToNotCreatedCart

	self
		should: [systemFacade add: 1 of: self validBook toCartIdentifiedAs: self invalidCartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidCartIdErrorDescription ]
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - add to cart' stamp: 'HAW 11/26/2018 18:03:17'!
test06CanNotAddItemNotSellByTheStore

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self
		should: [systemFacade add: 1 of: self invalidBook toCartIdentifiedAs: cartId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidItemErrorMessage.
			self assert: (systemFacade listCartIdentifiedAs: cartId) isEmpty ]
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - add to cart' stamp: 'HAW 11/26/2018 18:03:58'!
test17CanNotAddToCartWhenSessionIsExpired

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self advanceTime: (systemFacade sessionDuration + 1 minutes) .
	self
		should: [systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade sessionHasExpiredErrorDescription.
			self revertTime: systemFacade sessionDuration.
			self assert: (systemFacade listCartIdentifiedAs: cartId) isEmpty ]
! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - list purchases' stamp: 'ds 11/27/2021 20:02:39'!
test14ListPurchasesIncludesBoughtItems

	| cartId purchases expectedTotal listPurchasesItems|

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId.
	systemFacade add: 1 of: self anotherValidBook toCartIdentifiedAs: cartId.
	systemFacade
		checkOutCartIdentifiedAs: cartId
		withCreditCardNumbered: '1111222233334444'
		ownedBy: 'Juan Perez'
		expiringOn: testObjectsFactory notExpiredMonthOfYear.

	purchases := systemFacade listPurchasesOf: self validUser authenticatingWith: self validUserPassword.
	
	expectedTotal := (testObjectsFactory itemSellByTheStorePrice * 2) + testObjectsFactory anotherItemSellByTheStorePrice.
	self assert: expectedTotal equals: (purchases at: 'total').

	listPurchasesItems := purchases at: 'items'.
	self assert: (listPurchasesItems at: self validBook) equals: (Dictionary newFromPairs: {'price'. testObjectsFactory itemSellByTheStorePrice * 2. 'quantity'. 2}).
	self assert: (listPurchasesItems at: self anotherValidBook) equals: (Dictionary newFromPairs: {'price'. testObjectsFactory anotherItemSellByTheStorePrice. 'quantity'. 1}).! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list purchases' stamp: 'HAW 11/26/2018 18:10:29'!
test15CanNotListPurchasesOfInvalidCustomer

	self
		should: [systemFacade listPurchasesOf: self invalidUser authenticatingWith: self validUserPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidUserAndOrPasswordErrorDescription ]! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list purchases' stamp: 'HAW 11/26/2018 18:10:45'!
test16CanNotListPurchasesOfValidCustomerWithInvalidPassword

	self
		should: [systemFacade listPurchasesOf: self validUser authenticatingWith: self invalidPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidUserAndOrPasswordErrorDescription ]! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - create cart' stamp: 'HAW 6/19/2018 11:40:51'!
test01CanCreateCartWithValidUserAndPassword

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self assert: (systemFacade listCartIdentifiedAs: cartId) isEmpty
	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - create cart' stamp: 'HAW 11/26/2018 18:02:23'!
test02CanNotCreateCartWithInvalidUser

	self
		should: [ systemFacade createCartFor: self invalidUser authenticatedWith: self validUserPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidUserAndOrPasswordErrorDescription ]! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - create cart' stamp: 'HAW 11/26/2018 18:02:33'!
test03CanNotCreateCartWithInvalidPassword

	self
		should: [ systemFacade createCartFor: self validUser authenticatedWith: self invalidPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidUserAndOrPasswordErrorDescription ]! !


!TusLibrosSystemFacadeTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/22/2013 11:48'!
debit: anAmount from: aCreditCard
! !


!TusLibrosSystemFacadeTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/22/2013 11:42'!
createSalesBook

	^OrderedCollection new! !

!TusLibrosSystemFacadeTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/22/2013 11:47'!
merchantProcessor

	^self! !

!TusLibrosSystemFacadeTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2015 20:53'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.
	clock := ManualClock now: testObjectsFactory today.
	systemFacade := TusLibrosSystemFacade
		authenticatingWith: self validUsersAndPasswords
		acceptingItemsOf: testObjectsFactory defaultCatalog
		registeringOn: self createSalesBook
		debitingThrought: self merchantProcessor
		measuringTimeWith: clock
! !


!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/22/2013 00:15'!
anotherValidBook

	^testObjectsFactory anotherItemSellByTheStore ! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 23:49'!
invalidBook

	^testObjectsFactory itemNotSellByTheStore ! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 23:25'!
invalidCartId

	"Devuelvo nil porque seguro que siempre sera un id invalido, no importa que sea el id - Hernan"
	^nil! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 23:06'!
invalidPassword

	^'invalidPassword'! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 22:30'!
invalidUser

	^'invalidUser'! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 23:50'!
validBook

	^testObjectsFactory itemSellByTheStore ! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 22:27'!
validUser

	^'validUser'! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 22:28'!
validUserPassword

	^'validUserPassword'! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 22:43'!
validUsersAndPasswords

	^Dictionary new
		at: self validUser put: self validUserPassword;
		yourself! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'ds 11/27/2021 19:55:55'!
test10CanCheckoutACart

	| cartId listPurchasesDict bookItemInDict|

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 1 of: self validBook toCartIdentifiedAs: cartId.
	systemFacade
		checkOutCartIdentifiedAs: cartId
		withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
		ownedBy: testObjectsFactory notExpiredCreditCardOwner
		expiringOn: testObjectsFactory notExpiredMonthOfYear.

	listPurchasesDict := systemFacade listPurchasesOf: self validUser authenticatingWith: self validUserPassword.
	self assert: testObjectsFactory itemSellByTheStorePrice equals: (listPurchasesDict at: 'total').
	
	bookItemInDict := (listPurchasesDict at: 'items') at: self validBook.
	self assert: testObjectsFactory itemSellByTheStorePrice equals: (bookItemInDict at: 'price').
	self assert: 1 equals: (bookItemInDict at: 'quantity').
! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'HAW 11/26/2018 18:05:20'!
test11CanNotCheckoutANotCreatedCart

	self
		should: [systemFacade
			checkOutCartIdentifiedAs: self invalidCartId
			withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
			ownedBy: testObjectsFactory notExpiredCreditCardOwner
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidCartIdErrorDescription ]

		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'ds 11/27/2021 19:59:21'!
test12CanNotCheckoutAnEmptyCart

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self
		should: [systemFacade
			checkOutCartIdentifiedAs: cartId
			withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
			ownedBy: testObjectsFactory notExpiredCreditCardOwner
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | | listPurchasesDict |
			self assert: anError messageText equals: systemFacade cartCanNotBeEmptyErrorMessage.
			
			
			listPurchasesDict := systemFacade listPurchasesOf: self validUser authenticatingWith: self validUserPassword.
			self assertListPurchasesResponseIsEmpty: listPurchasesDict.
		].

		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'ds 11/27/2021 19:59:52'!
test13CanNotCheckoutWithAnExpiredCreditCard

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 1 of: self validBook toCartIdentifiedAs: cartId.
	self
		should: [systemFacade
			checkOutCartIdentifiedAs: cartId
			withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
			ownedBy: testObjectsFactory notExpiredCreditCardOwner
			expiringOn: testObjectsFactory expiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | |listPurchasesDict|
			self assert: anError messageText equals: systemFacade canNotChargeAnExpiredCreditCardErrorMessage.
			
			listPurchasesDict := systemFacade listPurchasesOf: self validUser authenticatingWith: self validUserPassword.
			self assertListPurchasesResponseIsEmpty: listPurchasesDict.
		].

		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'ds 11/27/2021 20:00:06'!
test19CanNotCheckOutCartWhenSessionIsExpired

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId.
	self advanceTime: (systemFacade sessionDuration + 1 minutes) .
	self should: [
		systemFacade
			checkOutCartIdentifiedAs: cartId
			withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
			ownedBy: testObjectsFactory notExpiredCreditCardOwner
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | |listPurchasesDict|
			self assert: anError messageText equals: systemFacade sessionHasExpiredErrorDescription.
			
			listPurchasesDict := systemFacade listPurchasesOf: self validUser authenticatingWith: self validUserPassword.
			self assertListPurchasesResponseIsEmpty: listPurchasesDict.
		].


	! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - list cart' stamp: 'HernanWilkinson 6/17/2015 20:53'!
test07ListCartOfAnEmptyCartReturnsAnEmptyBag

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self assert: (systemFacade listCartIdentifiedAs: cartId) isEmpty
	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list cart' stamp: 'HAW 11/26/2018 18:04:15'!
test08CanNotListCartOfInvalidCartId

	self
		should: [systemFacade listCartIdentifiedAs: self invalidCartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidCartIdErrorDescription ]
	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list cart' stamp: 'HAW 11/26/2018 18:04:32'!
test09ListCartReturnsTheRightNumberOfItems

	| cartId cartContent |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 1 of: self validBook toCartIdentifiedAs: cartId.
	systemFacade add: 2 of: self anotherValidBook toCartIdentifiedAs: cartId.
	cartContent := systemFacade listCartIdentifiedAs: cartId.

	self assert: (cartContent occurrencesOf: self validBook) equals: 1.
	self assert: (cartContent occurrencesOf: self anotherValidBook) equals: 2
! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list cart' stamp: 'HAW 11/26/2018 18:04:42'!
test18CanNotListCartWhenSessionIsExpired

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self advanceTime: (systemFacade sessionDuration + 1 minutes) .
	self
		should: [systemFacade listCartIdentifiedAs: cartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade sessionHasExpiredErrorDescription ].

! !


!TusLibrosSystemFacadeTest methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:53'!
advanceTime: aDuration

	clock advanceTime: aDuration ! !

!TusLibrosSystemFacadeTest methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 13:07'!
revertTime: aDuration

	clock revertTime: aDuration ! !


!TusLibrosSystemFacadeTest methodsFor: 'asserts' stamp: 'ds 11/27/2021 19:58:32'!
assertListPurchasesResponseIsEmpty: aListPurchasesResponse

	self assert: 0 equals: (aListPurchasesResponse at: 'total').
	self assert: ((aListPurchasesResponse at: 'items') isEmpty).! !


!classDefinition: #ManualClock category: #'TusLibros-Tests'!
Clock subclass: #ManualClock
	instanceVariableNames: 'now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!ManualClock methodsFor: 'time change' stamp: 'HernanWilkinson 6/22/2013 12:54'!
advanceTime: aDuration

	now := now + aDuration ! !

!ManualClock methodsFor: 'time change' stamp: 'HernanWilkinson 6/22/2013 13:08'!
revertTime: aDuration

	now := now + aDuration negated ! !


!ManualClock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:56'!
now

	^ now! !

!ManualClock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:53'!
today

	^now date! !


!ManualClock methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:52'!
initializeNow: aTime

	now := aTime ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ManualClock class' category: #'TusLibros-Tests'!
ManualClock class
	instanceVariableNames: ''!

!ManualClock class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:52'!
now: aTime

	^self new initializeNow: aTime ! !


!classDefinition: #StoreTestObjectsFactory category: #'TusLibros-Tests'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/22/2013 00:16'!
anotherItemSellByTheStore

	^'anotherValidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/22/2013 00:16'!
anotherItemSellByTheStorePrice

	^15! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore

	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore

	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice

	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart

	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'ds 11/27/2021 18:51:17'!
defaultCatalog

	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self anotherItemSellByTheStore put: self anotherItemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:24'!
expiredCreditCard

	^CreditCard expiringOn: self expiredMonthOfYear ! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:24'!
expiredMonthOfYear

	^ Month month: today monthIndex year: today yearNumber - 1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:06'!
notExpiredCreditCard

	^CreditCard expiringOn: self notExpiredMonthOfYear! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HAW 6/19/2018 11:45:30'!
notExpiredCreditCardNumber

	^ '1111222233334444' ! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HAW 6/19/2018 11:45:48'!
notExpiredCreditCardOwner

	^'Juan Perez'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:06'!
notExpiredMonthOfYear

	^ Month month: today monthIndex year: today yearNumber + 1! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today

	^ today! !


!StoreTestObjectsFactory methodsFor: 'customer' stamp: 'HernanWilkinson 6/22/2013 12:02'!
customer

	^'aCustomer'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StoreTestObjectsFactory class' category: #'TusLibros-Tests'!
StoreTestObjectsFactory class
	instanceVariableNames: ''!

!StoreTestObjectsFactory class methodsFor: 'as yet unclassified' stamp: 'ds 11/28/2021 16:08:00'!
sampleServerCatalog
	| sampleCatalog |
	sampleCatalog := Dictionary new.
	sampleCatalog add: 'validBook1'->19.
	sampleCatalog add: 'validBook2'->5.
	sampleCatalog add: 'validBook3Pesos'->3.
	sampleCatalog add: 'validBook10Pesos'->10.
	sampleCatalog add: 'validBook25Pesos'->25.
	sampleCatalog add: 'validBook50Pesos'->50.
	sampleCatalog add: 'validBook100Pesos'->100.
	^ sampleCatalog.! !

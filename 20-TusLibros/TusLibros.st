!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'asserts' stamp: 'ds 10/30/2021 15:42:57'!
assertAddingBook: aISBN withAmount: anAmount toCart: aCart producesError: anError
	
	self 
		should: [ aCart addBook: aISBN amount: anAmount. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :err |
			self assert: anError equals: err messageText.
			self deny: (aCart contains: aISBN).
		].! !

!CartTest methodsFor: 'asserts' stamp: 'ds 10/30/2021 15:22:07'!
assertCart: aCart listEquals: aList
	
	self assert: aList asSet equals: (aCart list collect: [:tuple | tuple asArray]) asSet.! !


!CartTest methodsFor: 'instance creation' stamp: 'ds 10/30/2021 15:34:21'!
cartWithTestCatalog
	
	^ Cart withCatalog: #('123456' '999' '42' '777').! !


!CartTest methodsFor: 'test - cart' stamp: 'ds 10/28/2021 21:04:27'!
test01newCartIsEmpty

	| cart |
	
	cart := Cart new. 
	
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'test - cart' stamp: 'ds 10/30/2021 15:34:35'!
test02cartWithBookAddedIsNotEmpty

	| cart |
	
	cart := self cartWithTestCatalog.
	
	cart addBook: '123456' amount: 1.
	
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'test - cart' stamp: 'ds 10/30/2021 15:34:49'!
test03canCheckIfBookIsInCart

	| cart |
	
	cart := self cartWithTestCatalog .
	
	cart addBook: '123456' amount: 1.
	
	self assert: (cart contains: '123456').! !

!CartTest methodsFor: 'test - cart' stamp: 'ds 10/30/2021 15:35:02'!
test04canCheckAmountOfACertainBookInCart

	| cart |
	
	cart := self cartWithTestCatalog.
	
	cart addBook: '123456' amount: 4.
	
	self assert: 4 equals: (cart amountOf: '123456').! !

!CartTest methodsFor: 'test - cart' stamp: 'ds 10/30/2021 15:35:17'!
test07addingAgainAnExistingBookToTheCartAddsUpTheAmounts

	| cart |
	
	cart := self cartWithTestCatalog.
	
	cart addBook: '123456' amount: 3.
	cart addBook: '123456' amount: 4.
	
	self assert: 7 equals: (cart amountOf: '123456').
	! !

!CartTest methodsFor: 'test - cart' stamp: 'ds 10/30/2021 15:35:22'!
test08addingANewBookDoesNotModifyThePreviousBooks

	| cart |
	
	cart := self cartWithTestCatalog.
	
	cart addBook: '123456' amount: 3.
	cart addBook: '999' amount: 4.
	
	self assert: 3 equals: (cart amountOf: '123456').
	! !


!CartTest methodsFor: 'test - errors' stamp: 'ds 10/30/2021 15:43:40'!
test05amountOfAddedBookMustNotBeNegative

	| cart |
	
	cart := self cartWithTestCatalog.
	
	self assertAddingBook: '123456'
	withAmount: -4
	toCart: cart
	producesError: Cart amountMustBePositiveErrorMessage.! !

!CartTest methodsFor: 'test - errors' stamp: 'ds 10/30/2021 15:43:32'!
test06amountOfAddedBookMustNotBeZero

	| cart |
	
	cart := self cartWithTestCatalog.
	
	self assertAddingBook: '123456'
	withAmount: 0
	toCart: cart
	producesError: Cart amountMustBePositiveErrorMessage.! !

!CartTest methodsFor: 'test - errors' stamp: 'ds 10/30/2021 15:44:04'!
test12bookAddedMustBeInCatalog
	
	| cart |
	
	cart := self cartWithTestCatalog.
	
	self assertAddingBook: '13'
	withAmount: 4
	toCart: cart
	producesError: Cart bookMustBeInCatalogErrorMessage.
	! !


!CartTest methodsFor: 'test - listing' stamp: 'ds 10/30/2021 15:35:28'!
test09listingAnEmptyCartIsEmpty

	| cart |
	
	cart := self cartWithTestCatalog.
	
	self assert: (cart list isEmpty).
	! !

!CartTest methodsFor: 'test - listing' stamp: 'ds 10/30/2021 15:35:33'!
test10listingACartWithOneBook

	| cart |
	
	cart := self cartWithTestCatalog.
	
	cart addBook: '123456' amount: 3.
	
	self assertCart: cart listEquals: #(#('123456' 3)).
	! !

!CartTest methodsFor: 'test - listing' stamp: 'ds 10/30/2021 15:35:38'!
test11listingACartWithManyBooks

	| cart |
	
	cart := self cartWithTestCatalog.
	
	cart addBook: '123456' amount: 3.
	cart addBook: '999' amount: 80.
	cart addBook: '42' amount: 30.
	cart addBook: '777' amount: 5.
	cart addBook: '42' amount: 70.
	
	self assertCart: cart listEquals: #(#('123456' 3) #('999' 80) #('42' 100) #('777' 5)).
	! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'books catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'ds 10/30/2021 15:28:29'!
initialize
	
	books := Trie new.
	catalog := OrderedCollection new.! !

!Cart methodsFor: 'initialization' stamp: 'ds 10/30/2021 15:28:38'!
initializeWithCatalog: aCatalog
	
	books := Trie new.
	catalog := aCatalog.! !


!Cart methodsFor: 'accessing' stamp: 'ds 10/28/2021 21:16:14'!
amountOf: aISBN
	
	^ books at: aISBN ifAbsent: [^ 0].! !

!Cart methodsFor: 'accessing' stamp: 'ds 10/28/2021 21:16:41'!
contains: aISBN 
	
	^ (self amountOf: aISBN) > 0.! !

!Cart methodsFor: 'accessing' stamp: 'ds 10/28/2021 21:12:03'!
isEmpty
	
	^ books isEmpty.! !

!Cart methodsFor: 'accessing' stamp: 'ds 10/30/2021 16:00:36'!
list
	
	| list |
	
	list :=  OrderedCollection new.
	books keysAndValuesDo: [:book :amount| list addLast: {book. amount}].
	^ list.! !


!Cart methodsFor: 'asserts' stamp: 'ds 10/30/2021 15:52:57'!
assertAmountIsPositive: anAmount 
	
	anAmount < 1 ifTrue: [^ self error: Cart amountMustBePositiveErrorMessage ].! !

!Cart methodsFor: 'asserts' stamp: 'ds 10/30/2021 15:53:16'!
assertBookIsInCatalog: aISBN
	
	(catalog includes: aISBN) ifFalse: [^ self error: Cart bookMustBeInCatalogErrorMessage].! !


!Cart methodsFor: 'adding' stamp: 'ds 10/30/2021 15:57:09'!
addBook: aISBN amount: anAmount
	
	self assertAmountIsPositive: anAmount.
	self assertBookIsInCatalog: aISBN.

	books at: aISBN put: ((self amountOf: aISBN) + anAmount).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'initialization' stamp: 'ds 10/30/2021 15:28:52'!
withCatalog: aCatalog
	
	^ self new initializeWithCatalog: aCatalog.! !


!Cart class methodsFor: 'errors' stamp: 'ds 10/30/2021 15:32:57'!
amountMustBePositiveErrorMessage
	
	^ 'amount must be bigger than 0!!!!!!'.! !

!Cart class methodsFor: 'errors' stamp: 'ds 10/30/2021 15:33:01'!
bookMustBeInCatalogErrorMessage
	
	^ 'book ISBN must be in catalog!!!!!!'.! !

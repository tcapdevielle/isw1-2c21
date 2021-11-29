!classDefinition: #TusLibrosCatalogWindow category: 'TusLibros-Client'!
Panel subclass: #TusLibrosCatalogWindow
	instanceVariableNames: 'bookLabelMorphs bookCatalogListMorph quantityTextBoxMorph cartListMorph'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!TusLibrosCatalogWindow methodsFor: 'initialization' stamp: 'ds 11/28/2021 16:55:06'!
initializeWith: aTitle for: aCartId andUser: anUser withPassword: aPassword

	bookLabelMorphs := Dictionary new.
	
	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (CatalogWindowModel for: aCartId andUser: anUser withPassword: aPassword).
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
			
	self model when: #booksArrived send: #refreshListOfBooks to: self.
	self model when: #addedToCart send: #refreshCart to: self.
	self model when: #checkoutCorrect send: #cleanCart to: self.
	
	self model sendCatalogRequest.! !


!TusLibrosCatalogWindow methodsFor: 'accessing' stamp: 'ds 11/27/2021 18:56:46'!
defaultExtent

	^ 1000@600.
	! !


!TusLibrosCatalogWindow methodsFor: 'GUI building' stamp: 'TC 11/28/2021 22:05:37'!
buildCartListColumn
	
	| firstColumnLayoutMorphOfSecondRow |
	
	cartListMorph := PluggableListMorph 
		model: self model 
		listGetter: #cart 
		indexGetter: #cartListIndex 
		indexSetter: #cartListIndex:.
		
	cartListMorph  
		borderColor: Color skyBlue; 
		borderWidth: 1; 
		morphWidth:250; 
		morphHeight: 300.
		
	firstColumnLayoutMorphOfSecondRow := LayoutMorph newColumn.
	firstColumnLayoutMorphOfSecondRow separation: 5; 
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'Cart Contents');
	addMorph: cartListMorph.
		
	^ firstColumnLayoutMorphOfSecondRow.! !

!TusLibrosCatalogWindow methodsFor: 'GUI building' stamp: 'TC 11/28/2021 22:16:16'!
buildLeftColumn

	| listPurchasesButtonMorph addToCartButtonMorph columnMorph |
	
	listPurchasesButtonMorph := self createButtonForAction: #sendListPurchasesRequest withLabel: 'List Purchases'.	 
	
	quantityTextBoxMorph := TextModelMorph 
		textProvider: self model 
		textGetter: #quantity 
		textSetter: #quantity:. 
		
	quantityTextBoxMorph innerTextMorph 
		setProperty: #keyStroke: 
		toValue: [ :key | quantityTextBoxMorph innerTextMorph acceptContents ].
		
	quantityTextBoxMorph 
		borderWidth: 1; 
		borderColor: Color skyBlue; 
		morphWidth: 100; 
		morphHeight: 20. 
	
	addToCartButtonMorph := 	self createButtonForAction: #sendAddToCartRequest withLabel: 'Add To Cart'.	 
 
	columnMorph := LayoutMorph newColumn.
	columnMorph separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: listPurchasesButtonMorph;
	addMorph: self buildListColumn;
	addMorph: quantityTextBoxMorph;
	addMorph: addToCartButtonMorph.
	
	^ columnMorph.! !

!TusLibrosCatalogWindow methodsFor: 'GUI building' stamp: 'TC 11/28/2021 22:07:47'!
buildListColumn
	
	| firstColumnLayoutMorphOfSecondRow |
	
	bookCatalogListMorph := PluggableListMorph 
		model: self model 
		listGetter: #books 
		indexGetter: #booksListIndex 
		indexSetter: #booksListIndex:.
		
	bookCatalogListMorph 
		borderColor: Color skyBlue; 
		borderWidth: 1; 
		morphWidth: 250; 
		morphHeight: 300.
		
	firstColumnLayoutMorphOfSecondRow := LayoutMorph newColumn.
	firstColumnLayoutMorphOfSecondRow separation: 5; 
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'Available Books');
	addMorph: bookCatalogListMorph.
		
	^ firstColumnLayoutMorphOfSecondRow.! !

!TusLibrosCatalogWindow methodsFor: 'GUI building' stamp: 'ds 11/28/2021 17:12:48'!
buildMorphicWindow
		
	self layoutMorph beRow;
	separation: 15;
	axisEdgeWeight: 0;
	addMorph: self buildLeftColumn;
	addMorph: self buildRightColumn.
	! !

!TusLibrosCatalogWindow methodsFor: 'GUI building' stamp: 'TC 11/28/2021 22:16:31'!
buildRightColumn

	| cleanCartButtonMorph removeButtonMorph checkOutButtonMorph columnMorph |
	
	cleanCartButtonMorph := self createButtonForAction: #cleanCart withLabel: 'Clean Cart'.	
	removeButtonMorph := self createButtonForAction: #sendRemoveFromCartRequest  withLabel: 'Remove from cart'.
	checkOutButtonMorph := self createButtonForAction: #sendCheckoutRequest  withLabel: 'Check Out'.
	
	columnMorph := LayoutMorph newColumn.
	columnMorph separation: 25;
	axisEdgeWeight: 0.5;	
	addMorph: cleanCartButtonMorph;
	addMorph: self buildCartListColumn;
	addMorph: removeButtonMorph;
	addMorph: checkOutButtonMorph.
	
	^ columnMorph.! !

!TusLibrosCatalogWindow methodsFor: 'GUI building' stamp: 'TC 11/28/2021 22:11:45'!
createButtonForAction: anAction withLabel: aButtonLabel

	^ PluggableButtonMorph 
		model: self model 
		stateGetter: nil  
		action: anAction 
		label: aButtonLabel.	! !


!TusLibrosCatalogWindow methodsFor: 'events' stamp: 'ds 11/28/2021 16:35:14'!
cleanCart

	cartListMorph updateList.
	cartListMorph setSelectionIndex: 0.! !

!TusLibrosCatalogWindow methodsFor: 'events' stamp: 'ds 11/22/2021 14:12:26'!
refreshCart
		
	cartListMorph updateList.
	cartListMorph setSelectionIndex: 0.
	! !

!TusLibrosCatalogWindow methodsFor: 'events' stamp: 'ds 11/22/2021 12:50:04'!
refreshListOfBooks
		
	bookCatalogListMorph updateList.
	bookCatalogListMorph setSelectionIndex: 0.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosCatalogWindow class' category: 'TusLibros-Client'!
TusLibrosCatalogWindow class
	instanceVariableNames: ''!

!TusLibrosCatalogWindow class methodsFor: 'instance creation' stamp: 'ds 11/27/2021 19:38:20'!
openFor: aCartId andUser: anUser withPassword: aPassword
	
	^self new initializeWith: 'TusLibros Client - Catalog' for: aCartId andUser: anUser withPassword: aPassword.! !


!classDefinition: #TusLibrosListPurchasesWindow category: 'TusLibros-Client'!
Panel subclass: #TusLibrosListPurchasesWindow
	instanceVariableNames: 'purchasesList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!TusLibrosListPurchasesWindow methodsFor: 'accessing' stamp: 'ds 11/27/2021 19:28:56'!
defaultExtent

	^ 400@600.! !


!TusLibrosListPurchasesWindow methodsFor: 'GUI building' stamp: 'TC 11/28/2021 21:30:43'!
addItemDetail: anItemDetail named: anItemName toPurchaseList: aPurchaseListMorph

	| itemQuantity itemPrice |
	
	itemQuantity := (anItemDetail at: 'quantity') asString.
	itemPrice := (anItemDetail at: 'price') asString.

	aPurchaseListMorph addMorph: 
		(LabelMorph contents: (anItemName, ' x', itemQuantity, '    $', itemPrice)).	
	! !

!TusLibrosListPurchasesWindow methodsFor: 'GUI building' stamp: 'TC 11/28/2021 21:31:54'!
buildListOfPurchases

	| purchaseListMorph totalSpent |
	
	purchaseListMorph := LayoutMorph newColumn.
	purchaseListMorph separation: 5.
	purchaseListMorph axisEdgeWeight: 0.5.
	
	purchaseListMorph addMorph: (LabelMorph contents: 'Items:').
	purchaseListMorph addMorph: (LabelMorph contents: '=====================').
	
	(purchasesList at: 'items') keysAndValuesDo: [:bookName :bookDetail | 
		self addItemDetail: bookDetail named: bookName  toPurchaseList: purchaseListMorph
	]. 
	purchaseListMorph addMorph: (LabelMorph contents: '=====================').
	
	purchaseListMorph addMorph: (LabelMorph contents: 'Total:').
	totalSpent := (purchasesList at: 'total' ifAbsent: [0]) asString.
	purchaseListMorph addMorph: (LabelMorph contents: ('$',totalSpent)).	
	
	^ purchaseListMorph.
	! !

!TusLibrosListPurchasesWindow methodsFor: 'GUI building' stamp: 'TC 11/28/2021 21:30:55'!
buildMorphicWindow
		
	self 
		layoutMorph beColumn;
		separation: 5;
		axisEdgeWeight: 0;
		addMorph: self buildListOfPurchases.
	! !


!TusLibrosListPurchasesWindow methodsFor: 'initialization' stamp: 'ds 11/27/2021 19:29:17'!
initializeWith: aTitle for: aListOfPurchases
	
	purchasesList := aListOfPurchases.
	
	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosListPurchasesWindow class' category: 'TusLibros-Client'!
TusLibrosListPurchasesWindow class
	instanceVariableNames: ''!

!TusLibrosListPurchasesWindow class methodsFor: 'instance creation' stamp: 'ds 11/27/2021 19:33:15'!
openFor: aListOfPurchases
	
	^self new initializeWith: 'TusLibros Client - Purchase List' for: aListOfPurchases.! !


!classDefinition: #TusLibrosLoginWindow category: 'TusLibros-Client'!
Panel subclass: #TusLibrosLoginWindow
	instanceVariableNames: 'userTextBoxMorph passwordTextBoxMorph wordsListMorph'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!TusLibrosLoginWindow methodsFor: 'initialization' stamp: 'ds 11/28/2021 17:00:21'!
initializeWith: aTitle

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (LoginWindowModel new).
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.! !


!TusLibrosLoginWindow methodsFor: 'accessing' stamp: 'ds 11/27/2021 18:47:07'!
defaultExtent

	^ 500@500
	! !


!TusLibrosLoginWindow methodsFor: 'GUI building' stamp: 'TC 11/28/2021 21:22:31'!
build1stRow
	| firstRowLayoutMorph |	
	
	userTextBoxMorph := TextModelMorph 
		textProvider: self model 
		textGetter: #user 
		textSetter: #user:. 
		
	userTextBoxMorph innerTextMorph 
		setProperty: #keyStroke: 
		toValue: [ :key | userTextBoxMorph innerTextMorph acceptContents ].
		
	userTextBoxMorph  
		borderWidth: 1; 
		borderColor: Color skyBlue; 
		morphWidth: 150; 
		morphHeight: 20. 
		
	firstRowLayoutMorph := LayoutMorph newRow.
	firstRowLayoutMorph separation: 20;
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'User:');
	addMorph: userTextBoxMorph.
	
	^ firstRowLayoutMorph.! !

!TusLibrosLoginWindow methodsFor: 'GUI building' stamp: 'TC 11/28/2021 21:23:37'!
build2ndRow

	| secondRowLayoutMorph |	
	
	passwordTextBoxMorph := TextModelMorph 
		textProvider: self model 
		textGetter: #password 
		textSetter: #password:. 
		
	passwordTextBoxMorph innerTextMorph 
		setProperty: #keyStroke: 
		toValue: [ :key | passwordTextBoxMorph innerTextMorph acceptContents ].
		
	passwordTextBoxMorph  
		borderWidth: 1; 
		borderColor: Color skyBlue; 
		morphWidth: 150; 
		morphHeight: 20. 
		
	secondRowLayoutMorph := LayoutMorph newRow.
	secondRowLayoutMorph separation: 5;
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'Password:');
	addMorph: passwordTextBoxMorph.
	
	^ secondRowLayoutMorph.
	! !

!TusLibrosLoginWindow methodsFor: 'GUI building' stamp: 'TC 11/28/2021 21:24:22'!
build3rdRow

	| loginButtonMorph thirdRowLayoutMorph |	
	
	loginButtonMorph := PluggableButtonMorph 
		model: self model 
		stateGetter: nil  
		action: #sendLoginRequest 
		label: 'Log In'.	
		
	thirdRowLayoutMorph := LayoutMorph newRow.
	thirdRowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: loginButtonMorph.
	
	^ thirdRowLayoutMorph.
	! !

!TusLibrosLoginWindow methodsFor: 'GUI building' stamp: 'TC 11/28/2021 21:24:57'!
buildMorphicWindow
		
	self 
		layoutMorph beColumn;
		separation: 15;
		axisEdgeWeight: 0;
		addMorph: self build1stRow;
		addMorph: self build2ndRow;
		addMorph: self build3rdRow.
	! !


!TusLibrosLoginWindow methodsFor: 'events' stamp: 'ds 11/15/2021 21:40:12'!
refreshListOfWords
	
	wordsListMorph updateList.
	wordsListMorph setSelectionIndex: 0.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosLoginWindow class' category: 'TusLibros-Client'!
TusLibrosLoginWindow class
	instanceVariableNames: ''!

!TusLibrosLoginWindow class methodsFor: 'instance creation' stamp: 'ds 11/15/2021 21:42:19'!
open
	
	^self new initializeWith: 'TusLibros Client - Login'.! !


!classDefinition: #TusLibrosTicketWindow category: 'TusLibros-Client'!
Panel subclass: #TusLibrosTicketWindow
	instanceVariableNames: 'ticket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!TusLibrosTicketWindow methodsFor: 'initialization' stamp: 'ds 11/27/2021 18:32:20'!
initializeWith: aTitle for: aTicket
	
	ticket := aTicket.
	
	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.! !


!TusLibrosTicketWindow methodsFor: 'GUI building' stamp: 'TC 11/28/2021 21:27:52'!
addTicketLine: aTicketLine toTicket: aTicketMorph

	| item price lineToPrint |
	
	item := aTicketLine at: 'item'.
	price := (aTicketLine at: 'total') asString.
	lineToPrint := item, ': ', '$', price.
	aTicketMorph addMorph: (LabelMorph contents: lineToPrint).	! !

!TusLibrosTicketWindow methodsFor: 'GUI building' stamp: 'TC 11/28/2021 21:31:04'!
buildMorphicWindow
		
	self 
		layoutMorph beColumn;
		separation: 5;
		axisEdgeWeight: 0;
		addMorph: self buildTicketMorph.
	! !

!TusLibrosTicketWindow methodsFor: 'GUI building' stamp: 'TC 11/28/2021 21:29:20'!
buildTicketMorph

	| ticketMorph saleTotal |
	ticketMorph := LayoutMorph newColumn.
	ticketMorph separation: 5.
	ticketMorph axisEdgeWeight: 0.5.
	
	ticketMorph addMorph: (LabelMorph contents: 'Items:').
	ticketMorph addMorph: (LabelMorph contents: '=====================').
	
	(ticket at: 'items' ifAbsent: [#()]) do: [:ticketLine | self addTicketLine: ticketLine toTicket: ticketMorph].
	ticketMorph addMorph: (LabelMorph contents: '=====================').
	
	ticketMorph addMorph: (LabelMorph contents: 'Total:').
	saleTotal := (ticket at: 'total' ifAbsent: [0]) asString.
	ticketMorph addMorph: (LabelMorph contents: '$',saleTotal).
	
	^ ticketMorph.
	! !

!TusLibrosTicketWindow methodsFor: 'GUI building' stamp: 'ds 11/27/2021 18:45:48'!
defaultExtent

	^ 400@600.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosTicketWindow class' category: 'TusLibros-Client'!
TusLibrosTicketWindow class
	instanceVariableNames: ''!

!TusLibrosTicketWindow class methodsFor: 'instance creation' stamp: 'ds 11/27/2021 18:23:38'!
openFor: aTicket
	
	^self new initializeWith: 'TusLibros Client - Ticket' for: aTicket.! !


!classDefinition: #CatalogWindowModel category: 'TusLibros-Client'!
Object subclass: #CatalogWindowModel
	instanceVariableNames: 'restInterface books user selectedBookIndex cart quantity cartId selectedCartItemIndex password'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!CatalogWindowModel methodsFor: 'initialization' stamp: 'TC 11/28/2021 21:33:00'!
initializeFor: aCartId andUser: aUser withPassword: aPassword
	
	books := OrderedCollection new.
	user := aUser.
	password := aPassword.
	cartId := aCartId.
	selectedBookIndex := 0.
	quantity := ''.
	cart := Bag new.
	restInterface := TusLibrosRestClient new.
	self cleanCart.
	! !


!CatalogWindowModel methodsFor: 'accessing' stamp: 'ds 11/22/2021 12:38:37'!
books
	
	^ books.
	! !

!CatalogWindowModel methodsFor: 'accessing' stamp: 'ds 11/22/2021 12:38:56'!
booksListIndex
	
	^ selectedBookIndex.! !

!CatalogWindowModel methodsFor: 'accessing' stamp: 'ds 11/22/2021 12:39:35'!
booksListIndex: anIndex
	
	selectedBookIndex := anIndex.! !

!CatalogWindowModel methodsFor: 'accessing' stamp: 'ds 11/22/2021 14:07:10'!
cart
	
	^ cart.
	! !

!CatalogWindowModel methodsFor: 'accessing' stamp: 'ds 11/22/2021 14:07:20'!
cartListIndex
	
	^ selectedCartItemIndex.! !

!CatalogWindowModel methodsFor: 'accessing' stamp: 'ds 11/22/2021 14:07:37'!
cartListIndex: anIndex
	
	selectedCartItemIndex := anIndex.! !

!CatalogWindowModel methodsFor: 'accessing' stamp: 'ds 11/22/2021 12:58:42'!
quantity
	
	^ quantity.! !

!CatalogWindowModel methodsFor: 'accessing' stamp: 'ds 11/22/2021 12:58:50'!
quantity: aQuantity
	
	quantity := aQuantity.! !


!CatalogWindowModel methodsFor: 'events - requests' stamp: 'TC 11/28/2021 21:35:09'!
sendAddToCartRequest

	| book sentQuantity |
	
	selectedBookIndex < 1 ifTrue: [^nil].
	
	book := books at: selectedBookIndex.	
	sentQuantity := quantity ifEmpty: [1]  ifNotEmpty: [quantity].
	
	restInterface 
		sendAddToCartFor: cartId 
		withBook: book 
		withQuantity: sentQuantity.
	
	self sendListCartRequest.
	self triggerEvent: #addedToCart.
	! !

!CatalogWindowModel methodsFor: 'events - requests' stamp: 'TC 11/28/2021 21:35:37'!
sendCatalogRequest

	| bookDict |	
	
	bookDict := restInterface sendCatalogRequest.
	books addAll: bookDict keys.
	
	self triggerEvent: #booksArrived.
	! !

!CatalogWindowModel methodsFor: 'events - requests' stamp: 'TC 11/28/2021 21:35:49'!
sendCheckoutRequest
	
	| ticket |
	
	ticket := restInterface sendCheckoutRequestFor: cartId.
	TusLibrosTicketWindow openFor: ticket.
	self cleanCart.! !

!CatalogWindowModel methodsFor: 'events - requests' stamp: 'ds 11/28/2021 16:46:19'!
sendCleanCartRequest

	restInterface sendCleanCartRequestFor: cartId.
	! !

!CatalogWindowModel methodsFor: 'events - requests' stamp: 'ds 11/28/2021 16:31:34'!
sendListCartRequest
	
	cart := restInterface sendListCartRequestFor: cartId.
	! !

!CatalogWindowModel methodsFor: 'events - requests' stamp: 'TC 11/28/2021 21:36:08'!
sendListPurchasesRequest

	| purchasesDict |	

	purchasesDict := restInterface sendListPurchasesRequest: user withPassword: password.
	TusLibrosListPurchasesWindow openFor: purchasesDict.
	! !

!CatalogWindowModel methodsFor: 'events - requests' stamp: 'ds 11/28/2021 16:51:53'!
sendRemoveFromCartRequest

	selectedCartItemIndex < 1 ifTrue: [^nil].
	
	restInterface
		sendRemoveFromCartRequestFor: cartId
		withBook: (cart at: selectedCartItemIndex).
	
	self sendListCartRequest.
	self triggerEvent: #addedToCart.
	! !


!CatalogWindowModel methodsFor: 'events' stamp: 'ds 11/28/2021 17:02:41'!
cleanCart

	self sendCleanCartRequest.
	self sendListCartRequest.
	selectedCartItemIndex := 0.
	self triggerEvent: #checkoutCorrect.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CatalogWindowModel class' category: 'TusLibros-Client'!
CatalogWindowModel class
	instanceVariableNames: ''!

!CatalogWindowModel class methodsFor: 'instance creation' stamp: 'TC 11/28/2021 21:32:16'!
for: aCartId andUser: aUser withPassword: aPassword

	^ self new initializeFor: aCartId andUser: aUser withPassword: aPassword.! !


!classDefinition: #LoginWindowModel category: 'TusLibros-Client'!
Object subclass: #LoginWindowModel
	instanceVariableNames: 'restInterface user password'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!LoginWindowModel methodsFor: 'accessing' stamp: 'TC 11/28/2021 21:07:50'!
password
	
	^ password.! !

!LoginWindowModel methodsFor: 'accessing' stamp: 'ds 11/18/2021 18:02:08'!
password: aPassword
	
	password := aPassword.! !

!LoginWindowModel methodsFor: 'accessing' stamp: 'TC 11/28/2021 21:08:00'!
user
	
	^ user.! !

!LoginWindowModel methodsFor: 'accessing' stamp: 'TC 11/28/2021 21:32:35'!
user: aUser
	
	user := aUser.! !


!LoginWindowModel methodsFor: 'initialization' stamp: 'ds 11/18/2021 17:57:52'!
initialize

	user := ''.
	password := ''.
	restInterface := TusLibrosRestClient new.! !


!LoginWindowModel methodsFor: 'events - requests' stamp: 'TC 11/28/2021 21:32:46'!
sendLoginRequest

	| response cartId |	

	response := restInterface sendCreateCartAs: user withPassword: password.
	cartId := response at: 'cartId' ifAbsent: [
		PopUpMenu inform: (response at: 'message').
		^ self.
	].

	TusLibrosCatalogWindow openFor: cartId andUser: user withPassword: password.
	! !


!classDefinition: #TusLibrosRestClient category: 'TusLibros-Client'!
Object subclass: #TusLibrosRestClient
	instanceVariableNames: 'port'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!TusLibrosRestClient methodsFor: 'sending requests' stamp: 'ds 11/28/2021 15:50:05'!
sendAddToCartFor: aCart withBook: aBook withQuantity: aQuantity
	
	^ self
		request: '/addToCart'
		with: (Dictionary newFromPairs: {'cartId'. aCart. 'bookIsbn'. aBook. 'bookQuantity'. aQuantity}).! !

!TusLibrosRestClient methodsFor: 'sending requests' stamp: 'ds 11/28/2021 16:10:06'!
sendCatalogRequest

	^ self
		request: '/catalog'
		with: (Dictionary new).! !

!TusLibrosRestClient methodsFor: 'sending requests' stamp: 'ds 11/28/2021 16:29:52'!
sendCheckoutRequestFor: aCartId
	
	^ self
		request: '/checkOutCart'
		with: (Dictionary newFromPairs: {
			'cartId'. aCartId. 
			'ccn'. '456345345'. 
			'cced'. '022026'. 
			'cco'. (self encodeSpacesFor: 'John Doe')
		}).! !

!TusLibrosRestClient methodsFor: 'sending requests' stamp: 'ds 11/28/2021 16:42:26'!
sendCleanCartRequestFor: aCart
	
	^ self
		request: '/cleanCart'
		with: (	Dictionary newFromPairs: {'cartId'. aCart}).! !

!TusLibrosRestClient methodsFor: 'sending requests' stamp: 'ds 11/28/2021 16:22:47'!
sendCreateCartAs: anUser withPassword: aPassword

	^ self sendAuthenticatedRequestTo: '/createCart' for: anUser  with: aPassword.! !

!TusLibrosRestClient methodsFor: 'sending requests' stamp: 'ds 11/28/2021 16:00:31'!
sendListCartRequestFor: aCart
	
	^ self
		request: '/listCart'
		with: (	Dictionary newFromPairs: {'cartId'. aCart}).! !

!TusLibrosRestClient methodsFor: 'sending requests' stamp: 'ds 11/28/2021 16:22:34'!
sendListPurchasesRequest: anUser withPassword: aPassword
	
	^ self sendAuthenticatedRequestTo: '/listPurchases' for: anUser  with: aPassword.! !

!TusLibrosRestClient methodsFor: 'sending requests' stamp: 'ds 11/28/2021 16:12:39'!
sendRemoveFromCartRequestFor: aCart withBook: aBook
	
	^ self
		request: '/removeFromCart'
		with: (Dictionary newFromPairs: {'cartId'. aCart. 'bookIsbn'. aBook. }).! !


!TusLibrosRestClient methodsFor: 'auxiliar' stamp: 'ds 11/28/2021 15:39:07'!
encodeSpacesFor: aParameter
	
	^ aParameter copyReplaceAll: ' ' with: '%20'. ! !

!TusLibrosRestClient methodsFor: 'auxiliar' stamp: 'ds 11/18/2021 17:52:19'!
port
	
	^port ifNil: [port:=8080].! !

!TusLibrosRestClient methodsFor: 'auxiliar' stamp: 'ds 11/28/2021 15:22:22'!
request: anEndpoint with: aDictOfFields

	| response content |
		
	response := WebClient htmlSubmit: (self url,anEndpoint) fields: aDictOfFields.
	content := WebUtils jsonDecode: (response content readStream).
	
	response isSuccess 
		ifTrue:[^ content .] 
		ifFalse:[^self error: content].! !

!TusLibrosRestClient methodsFor: 'auxiliar' stamp: 'ds 11/28/2021 16:22:16'!
sendAuthenticatedRequestTo: anEndpoint for: anUser with: aPassword
		
	^ self
		request: anEndpoint
		with: (Dictionary newFromPairs: {
			'clientId'. (self encodeSpacesFor: anUser).
			'password'. (self encodeSpacesFor: aPassword).
		}).! !

!TusLibrosRestClient methodsFor: 'auxiliar' stamp: 'ds 11/18/2021 17:52:19'!
url
	
	^'http://localhost:', self port asString! !

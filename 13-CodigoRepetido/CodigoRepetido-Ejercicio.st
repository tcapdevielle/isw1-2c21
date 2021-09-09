!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'ds 9/6/2021 18:41:58'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self runClosureAndAssertThatTimeElapsedIsLessThan: [customerBook addCustomerNamed: 'John Lennon'] time: 50 * millisecond.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ds 9/6/2021 18:42:54'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	
	self runClosureAndAssertThatTimeElapsedIsLessThan: [customerBook removeCustomerNamed: paulMcCartney] time: 100 * millisecond.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ds 9/8/2021 15:54:12'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self runClosureAndOnErrorExecute: [customerBook addCustomerNamed: ''.] errorType: Error onFailClosure: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ds 9/8/2021 15:32:40'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := self createCustomerBookWithCustomer: johnLennon.
	
	self runClosureAndOnErrorExecute: [customerBook removeCustomerNamed: 'Paul McCartney'.] errorType: NotFound onFailClosure: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ].
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ds 9/8/2021 15:32:27'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self createCustomerBookWithCustomer: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
		
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 1 equals: customerBook numberOfSuspendedCustomers.
	self assert: 1 equals: customerBook numberOfCustomers.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ds 9/8/2021 15:35:51'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self createCustomerBookWithCustomer: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assert: customerBook isEmpty.
	self assert: 0 equals: customerBook numberOfCustomers.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ds 9/8/2021 15:57:00'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := self createCustomerBookWithCustomer: johnLennon.
		
	self expectErrorWhenSuspendingCustomer: 'George Harrison' customerBook: customerBook.
	self assert: customerBook numberOfCustomers = 1.
	self assert: (customerBook includesCustomerNamed: johnLennon).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ds 9/8/2021 15:54:59'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := self createCustomerBookWithCustomer: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
		
	self expectErrorWhenSuspendingCustomer: johnLennon customerBook: customerBook.
	self assert: customerBook numberOfCustomers = 1.
	self assert: (customerBook includesCustomerNamed: johnLennon).! !


!CustomerBookTest methodsFor: 'auxiliar' stamp: 'ds 9/8/2021 15:27:38'!
createCustomerBookWithCustomer: aCustomerName
	^ CustomerBook new addCustomerNamed: aCustomerName.! !

!CustomerBookTest methodsFor: 'auxiliar' stamp: 'ds 9/8/2021 15:46:13'!
expectErrorWhenSuspendingCustomer: aCustomer customerBook: aCustomerBook

	self runClosureAndOnErrorExecute: [aCustomerBook suspendCustomerNamed: aCustomer.] errorType: CantSuspend onFailClosure: [:v | nil].! !

!CustomerBookTest methodsFor: 'auxiliar' stamp: 'TC 9/8/2021 15:30:31'!
runClosureAndAssertThatTimeElapsedIsLessThan: aClosure time: aTime

	| elapsedTime startTime endTime |
	
	startTime := Time millisecondClockValue * millisecond.
	aClosure value.
	endTime := Time millisecondClockValue * millisecond.
	
	elapsedTime := endTime - startTime.
	
	self assert: elapsedTime < aTime! !

!CustomerBookTest methodsFor: 'auxiliar' stamp: 'TC 9/8/2021 14:56:26'!
runClosureAndOnErrorExecute: testClosure errorType: anErrorType onFailClosure: failClosure
	
	[testClosure value.
	self fail ]
		on: anErrorType 
		do: [ :anError | failClosure valueWithArguments: (Array with: anError )]! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'ds 9/8/2021 15:34:10'!
removeCustomer: aCustomerName fromGroup: aGroupOfCustomers

	aGroupOfCustomers remove: aCustomerName ifAbsent: [^false].
	^true.! !

!CustomerBook methodsFor: 'customer management' stamp: 'ds 9/8/2021 15:34:17'!
removeCustomerNamed: aName

	(self removeCustomer: aName fromGroup: active) ifTrue: [^aName].
	(self removeCustomer: aName fromGroup: suspended) ifTrue: [^aName].
	^ NotFound signal.
	
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/12/2021 16:39:13'!
customerAlreadyExistsErrorMessage

	^'customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/12/2021 16:39:09'!
customerCanNotBeEmptyErrorMessage

	^'customer name cannot be empty!!!!!!'! !

!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'ds 9/19/2021 12:41:07'!
test01FindOnEmptyStackReturnsNoResults

	| stack results |
	
	stack := OOStack new.
	results := SentenceFinderByPrefix new find: 'Wint' inStack: stack.
	
	self assertResultsAreEmpty: results.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'ds 9/19/2021 14:14:52'!
test02FindWithEmptyQueryReturnsError

	| stack |
	
	stack := OOStack new.
	
	self assertThatSearchWithPrefix: '' inStack: stack producesError: SentenceFinderByPrefix sentenceFinderEmptyQueryErrorDescription.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'ds 9/19/2021 14:15:04'!
test03FindWithNilQueryReturnsError

	| stack |
	
	stack := OOStack new.
	
	self assertThatSearchWithPrefix: nil inStack: stack producesError: SentenceFinderByPrefix sentenceFinderNilQueryErrorDescription.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'ds 9/19/2021 14:12:34'!
test04FindWithQueryWhichHasPostfixSpacesReturnsError

	| stack |
	
	stack := OOStack new.
	
	self assertThatSearchWithPrefix: 'Wint ' inStack: stack  producesError: SentenceFinderByPrefix sentenceFinderQueryHasSpacesErrorDescription.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'ds 9/19/2021 14:13:57'!
test05FindWithQueryWhichHasInnerSpacesReturnsError

	| stack |
	
	stack := OOStack new.
	
	self assertThatSearchWithPrefix: 'Summ er' inStack: stack  producesError: SentenceFinderByPrefix sentenceFinderQueryHasSpacesErrorDescription.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'ds 9/19/2021 14:14:30'!
test06FindWithQueryWhichHasPrefixSpacesReturnsError

	| stack |
	
	stack := OOStack new.
	self assertThatSearchWithPrefix: ' Fall' inStack: stack  producesError: SentenceFinderByPrefix sentenceFinderQueryHasSpacesErrorDescription.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'ds 9/19/2021 13:26:20'!
test07FindWithMatchingQueryReturnsAResult

	| stack results |
	
	stack := self createStackWithElements: #('Summer is leaving' 'Winter is coming' 'Fall is my favourite').
	 
	results := SentenceFinderByPrefix new find: 'Sum' inStack: stack.
	
	self assertResults: results areEqualTo: #('Summer is leaving').! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'ds 9/19/2021 13:23:00'!
test08FindWithMatchingQuerySeveralResults

	| stack results |
	
	stack := self createStackWithElements: #('Summer is leaving' 'Winter is coming' 'Fall is my favourite'
		'Not this Winter' 'Winter is a cold season' 'Spring is nice'
	).
	 
	results := SentenceFinderByPrefix new find: 'Wint' inStack: stack.
	
	self assertResults: results areEqualTo: #('Winter is a cold season' 'Winter is coming').! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'ds 9/19/2021 13:36:13'!
test09FindWithoutMatchingQueryReturnsNoResults

	| stack results |
	
	stack := self createStackWithElements: #('Summer is leaving' 'Fall is my favourite').
	 
	results := SentenceFinderByPrefix new find: 'Wint' inStack: stack.
	
	self assertResultsAreEmpty: results.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'ds 9/19/2021 13:36:23'!
test10FindDoesNotModifyTheOriginalStack

	| stack results |
	
	stack := self createStackWithElements: #('Summer is leaving' 'Winter is coming' 'Fall is my favourite' 'Winter is cold').
	 
	results := SentenceFinderByPrefix new find: 'Wint' inStack: stack.
	
	self assertResults: results areEqualTo: #('Winter is cold' 'Winter is coming').
	self assertStack: stack hasTheseElements: #('Winter is cold' 'Fall is my favourite' 'Winter is coming' 'Summer is leaving').
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'ds 9/19/2021 13:36:42'!
test11FindDoesNotModifyAnEmptyStack

	| stack |
	
	stack := OOStack new.
	SentenceFinderByPrefix new find: 'Wint' inStack: stack.
	
	self assertStack: stack hasTheseElements: #().
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'ds 9/19/2021 13:36:53'!
test12FindIsCaseSensitive

	| stack results |
	
	stack := self createStackWithElements: #('Summer is leaving' 'Winter is coming' 'Winter is cold' 'falling to the ground').
	 
	results := SentenceFinderByPrefix new find: 'fall' inStack: stack.
	
	self assertResults: results areEqualTo: #('falling to the ground').
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'ds 9/19/2021 13:37:03'!
test13FindWholeWords

	| stack results |
	
	stack := self createStackWithElements: #('Summer is leaving' 'Summer' 'Winter' 'Spring is nice' 'Fall' 'Winter').
	 
	results := SentenceFinderByPrefix new find: 'Winter' inStack: stack.
	
	self assertResults: results areEqualTo: #('Winter' 'Winter').
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'ds 9/19/2021 13:37:10'!
test14FindWithSingleLetterAsPrefix

	| stack results |
	
	stack := self createStackWithElements: #('tokyo' 'montreal' 'toronto' 'budapest' 'tel aviv' 'buenos aires' 'paris').
	
	results := SentenceFinderByPrefix new find: 't' inStack: stack.
	
	self assertResults: results areEqualTo: #('tel aviv' 'toronto' 'tokyo').
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'ds 9/19/2021 13:41:13'!
test15FindMatchesAllElementsInTheStack

	| stack results |
	
	stack := self createStackWithElements: #('bathing is nice' 'bananas are my favourite fruit' 'batman is a superhero' 'bali').
	 
	results := SentenceFinderByPrefix new find: 'ba' inStack: stack.
	
	self assertResults: results areEqualTo: #('bali' 'batman is a superhero' 'bananas are my favourite fruit' 'bathing is nice').! !


!SentenceFinderByPrefixTest methodsFor: 'auxiliar' stamp: 'ds 9/19/2021 12:40:37'!
assertResults: aListOfResults areEqualTo: anArrayOfExpectedResults
	
	self assert: aListOfResults asArray = anArrayOfExpectedResults	.
	! !

!SentenceFinderByPrefixTest methodsFor: 'auxiliar' stamp: 'ds 9/19/2021 12:35:46'!
assertResultsAreEmpty: aListOfResults
	
	self assert: aListOfResults size equals: 0.! !

!SentenceFinderByPrefixTest methodsFor: 'auxiliar' stamp: 'ds 9/19/2021 12:50:17'!
assertStack: aStack hasTheseElements: expectedElements
	
	|expectedElementsIndex|
	
	self assert: aStack size equals: expectedElements size.
	
	expectedElementsIndex := 1.
	aStack size timesRepeat: [
		self assert: (aStack pop) equals: (expectedElements	 at: expectedElementsIndex).
		expectedElementsIndex := expectedElementsIndex + 1.
	].
	! !

!SentenceFinderByPrefixTest methodsFor: 'auxiliar' stamp: 'ds 9/19/2021 14:15:47'!
assertThatSearchWithPrefix: aPrefix inStack: aStack producesError: expectedError
	
	self
		should: [ SentenceFinderByPrefix new find: aPrefix inStack: aStack. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: anError messageText = expectedError ]! !

!SentenceFinderByPrefixTest methodsFor: 'auxiliar' stamp: 'ds 9/19/2021 13:21:05'!
createStackWithElements: aListOfElements
	| stack |
	
	stack := OOStack new.
	aListOfElements do: [:elem | stack push: elem].
	^ stack.! !

!SentenceFinderByPrefixTest methodsFor: 'auxiliar' stamp: 'ds 9/19/2021 12:45:12'!
popStack: aStack andAssertEqualsTo: aString
	
	self assert: aStack pop equals: aString.! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topElement size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'interface' stamp: 'ds 9/18/2021 15:22:49'!
initialize
	
	topElement := BaseStackElement new.
	size := 0.! !

!OOStack methodsFor: 'interface' stamp: 'ds 9/18/2021 15:29:08'!
isEmpty

	^ size isZero.! !

!OOStack methodsFor: 'interface' stamp: 'ds 9/19/2021 14:05:15'!
pop
	| previousElementAndTopValue |
	previousElementAndTopValue := topElement getPreviousElementAndActualValue .
	topElement := previousElementAndTopValue at: 1.
	size := size - 1.
	^ previousElementAndTopValue at: 2.! !

!OOStack methodsFor: 'interface' stamp: 'ds 9/18/2021 15:36:01'!
push: anElement

	topElement := topElement addNext: anElement.	
	size := size + 1.! !

!OOStack methodsFor: 'interface' stamp: 'ds 9/18/2021 15:23:08'!
size
	
	^ size.! !

!OOStack methodsFor: 'interface' stamp: 'ds 9/18/2021 15:04:05'!
top

	^ topElement getValue.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: 'base'!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !

!OOStack class methodsFor: 'error descriptions' stamp: 'ds 9/19/2021 13:52:22'!
stackOutOfBoundsErrorDescription
	
	^ 'accessing out of bounds!!!!!!'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'interface' stamp: 'ds 9/19/2021 13:11:15'!
find: aPrefix inStack: aStack

	|results preservedItems |
	
	self ensurePrefixIsValid: aPrefix.
	
	results := OrderedCollection new.
	preservedItems := OOStack new.
	
	aStack size timesRepeat: [
		| elem |
		elem := aStack pop.
		results addLast: elem.
		preservedItems push: elem.	
	].

	results := self selectOnlyResults: results whichMatchThisPrefix: aPrefix.

	self moveAllElementsFromStack: preservedItems toStack: aStack.
	
	^ results.! !


!SentenceFinderByPrefix methodsFor: 'prefix verification (private)' stamp: 'ds 9/19/2021 13:18:37'!
ensurePrefixHasNoSpaces: aPrefix

	(aPrefix includes: $ ) ifTrue: [self error: SentenceFinderByPrefix sentenceFinderQueryHasSpacesErrorDescription].! !

!SentenceFinderByPrefix methodsFor: 'prefix verification (private)' stamp: 'ds 9/19/2021 13:10:28'!
ensurePrefixIsNotEmpty: aPrefix

	aPrefix isEmpty ifTrue: [self error: SentenceFinderByPrefix sentenceFinderEmptyQueryErrorDescription ].! !

!SentenceFinderByPrefix methodsFor: 'prefix verification (private)' stamp: 'ds 9/19/2021 13:10:36'!
ensurePrefixIsNotNil: aPrefix

	aPrefix isNil ifTrue: [self error: SentenceFinderByPrefix sentenceFinderNilQueryErrorDescription].! !

!SentenceFinderByPrefix methodsFor: 'prefix verification (private)' stamp: 'ds 9/19/2021 13:12:06'!
ensurePrefixIsValid: aPrefix

	self ensurePrefixIsNotNil: aPrefix.
	self ensurePrefixIsNotEmpty: aPrefix.
	self ensurePrefixHasNoSpaces: aPrefix.! !


!SentenceFinderByPrefix methodsFor: 'auxiliar (private)' stamp: 'ds 9/19/2021 13:07:29'!
moveAllElementsFromStack: aSourceStack toStack: aDestinationStack

	^ aSourceStack size timesRepeat: [ aDestinationStack push: aSourceStack pop.].! !

!SentenceFinderByPrefix methodsFor: 'auxiliar (private)' stamp: 'ds 9/19/2021 13:04:42'!
selectOnlyResults: aListOfResults whichMatchThisPrefix: aPrefix

	^  aListOfResults select: [:aResult | aResult beginsWith: aPrefix].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'ds 9/18/2021 16:16:20'!
sentenceFinderEmptyQueryErrorDescription
	
	^ 'search query is empty!!!!!!'! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'ds 9/18/2021 16:16:28'!
sentenceFinderNilQueryErrorDescription
	
	^ 'search query is nil!!!!!!'! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'ds 9/18/2021 16:22:50'!
sentenceFinderQueryHasSpacesErrorDescription
	
	^ 'search query has spaces!!!!!!'! !


!classDefinition: #StackElement category: 'Stack-Exercise'!
Object subclass: #StackElement
	instanceVariableNames: 'prev next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackElement methodsFor: 'interface' stamp: 'ds 9/19/2021 14:02:52'!
addNext: anElement
	
	self subclassResponsibility.! !

!StackElement methodsFor: 'interface' stamp: 'ds 9/19/2021 13:57:19'!
getPreviousElementAndActualValue
	
	self subclassResponsibility.! !

!StackElement methodsFor: 'interface' stamp: 'ds 9/19/2021 13:50:38'!
getValue

	self subclassResponsibility.! !

!StackElement methodsFor: 'interface' stamp: 'ds 9/19/2021 13:59:30'!
setPrev: anElement
	
	self subclassResponsibility.! !


!classDefinition: #BaseStackElement category: 'Stack-Exercise'!
StackElement subclass: #BaseStackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!BaseStackElement methodsFor: 'interface' stamp: 'ds 9/19/2021 14:02:41'!
addNext: anElement
	
	next := RealStackElement new initializeWith: anElement previous: self.
	^ next.! !

!BaseStackElement methodsFor: 'interface' stamp: 'ds 9/19/2021 13:57:23'!
getPreviousElementAndActualValue
	
	self error: OOStack stackEmptyErrorDescription.! !

!BaseStackElement methodsFor: 'interface' stamp: 'ds 9/18/2021 15:25:20'!
getValue
	
	self error: OOStack stackEmptyErrorDescription.! !

!BaseStackElement methodsFor: 'interface' stamp: 'ds 9/19/2021 14:01:30'!
setPrev: anElement
	
	self error: OOStack stackEmptyErrorDescription.! !


!BaseStackElement methodsFor: 'initialization' stamp: 'ds 9/18/2021 15:49:31'!
initialize
	
	next := OutOfBoundsStackElement new.
	prev := OutOfBoundsStackElement new.! !


!classDefinition: #OutOfBoundsStackElement category: 'Stack-Exercise'!
StackElement subclass: #OutOfBoundsStackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OutOfBoundsStackElement methodsFor: 'interface' stamp: 'ds 9/19/2021 14:03:31'!
addNext: anElement
	
	self error: OOStack stackOutOfBoundsErrorDescription.! !

!OutOfBoundsStackElement methodsFor: 'interface' stamp: 'ds 9/19/2021 13:58:30'!
getPreviousElementAndActualValue

	self error: OOStack stackOutOfBoundsErrorDescription.! !

!OutOfBoundsStackElement methodsFor: 'interface' stamp: 'ds 9/19/2021 14:02:16'!
getValue
	
	self error: OOStack stackOutOfBoundsErrorDescription.! !

!OutOfBoundsStackElement methodsFor: 'interface' stamp: 'ds 9/19/2021 13:59:59'!
setPrev: anElement
	
	self error: OOStack stackOutOfBoundsErrorDescription.! !


!classDefinition: #RealStackElement category: 'Stack-Exercise'!
StackElement subclass: #RealStackElement
	instanceVariableNames: 'elementValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!RealStackElement methodsFor: 'initialization' stamp: 'ds 9/18/2021 15:57:10'!
initializeWith: aValue previous: anElement
	
	elementValue := aValue.
	prev := anElement.
	next := OutOfBoundsStackElement value.! !


!RealStackElement methodsFor: 'interface' stamp: 'ds 9/19/2021 14:02:41'!
addNext: anElement
	
	next := RealStackElement new initializeWith: anElement previous: self.
	^ next.! !

!RealStackElement methodsFor: 'interface' stamp: 'ds 9/19/2021 13:57:43'!
getPreviousElementAndActualValue

	^ Array with: prev with: elementValue.
	! !

!RealStackElement methodsFor: 'interface' stamp: 'ds 9/18/2021 15:56:12'!
getValue
	
	^ elementValue.! !

!RealStackElement methodsFor: 'interface' stamp: 'ds 9/19/2021 13:59:07'!
setPrev: anElement
	
	prev := anElement.! !

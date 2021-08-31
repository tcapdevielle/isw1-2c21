!classDefinition: #I category: 'Numeros Naturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Numeros Naturales'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'TC 8/31/2021 15:40:28'!
* aNaturalNumber

	^ aNaturalNumber.! !

!I class methodsFor: 'as yet unclassified' stamp: 'TC 8/26/2021 21:13:59'!
+ aNaturalNumber

	^ aNaturalNumber next.! !

!I class methodsFor: 'as yet unclassified' stamp: 'TC 8/31/2021 19:04:06'!
- aNaturalNumber

	self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.! !

!I class methodsFor: 'as yet unclassified' stamp: 'TC 8/31/2021 19:02:12'!
/ aNaturalNumber

	aNaturalNumber = I ifTrue: [^self].
	self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.! !

!I class methodsFor: 'as yet unclassified' stamp: 'TC 8/31/2021 19:02:47'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^ 'El divisor no puede ser mayor que el dividendo'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'TC 8/31/2021 19:04:55'!
descripcionDeErrorDeNumerosNegativosNoSoportados

	^ 'El sustraendo debe ser menor que el minuendo'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'TC 8/31/2021 19:08:35'!
isGreaterOrEqualThan: aNaturalNumber
    
	aNaturalNumber = 1 ifTrue: [^ true].
   	^ false.! !

!I class methodsFor: 'as yet unclassified' stamp: 'TC 8/31/2021 15:40:47'!
next

	^ II.! !


!classDefinition: #II category: 'Numeros Naturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Numeros Naturales'!
II class
	instanceVariableNames: '_next _previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'TC 8/31/2021 16:01:09'!
* aNaturalNumber

	aNaturalNumber = I ifTrue: [^self].
	^ self + self * aNaturalNumber previous.! !

!II class methodsFor: 'as yet unclassified' stamp: 'TC 8/26/2021 21:20:42'!
+ aNaturalNumber

	^ self previous + aNaturalNumber next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'TC 8/26/2021 21:52:53'!
- aNaturalNumber 
	
	aNaturalNumber  = I ifTrue: [^self previous].
	^ self previous - aNaturalNumber previous.! !

!II class methodsFor: 'as yet unclassified' stamp: 'TC 8/31/2021 19:03:01'!
/ aNaturalNumber

	aNaturalNumber = I ifTrue: [^ self].
       self = aNaturalNumber ifTrue: [^ I].
	(aNaturalNumber isGreaterOrEqualThan: self) ifTrue: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
       ^ I + ((self - aNaturalNumber) / aNaturalNumber).! !

!II class methodsFor: 'as yet unclassified' stamp: 'TC 8/31/2021 19:03:30'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^ 'El divisor no puede ser mayor que el dividendo'.! !

!II class methodsFor: 'as yet unclassified' stamp: 'TC 8/31/2021 19:12:32'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	_next := III.
	_previous := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'TC 8/31/2021 19:09:25'!
isGreaterOrEqualThan: aNaturalNumber
    
	self = aNaturalNumber ifTrue: [^ true].
	^ (self previous) isGreaterOrEqualThan: aNaturalNumber.! !

!II class methodsFor: 'as yet unclassified' stamp: 'TC 8/31/2021 15:54:11'!
next

	_next ifNotNil: [^_next].
	_next _ II createChildNamed: self name, 'I'.
	_next previous: self.
	^ _next.
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'TC 8/31/2021 15:54:17'!
previous
	
	^ _previous.! !

!II class methodsFor: 'as yet unclassified' stamp: 'TC 8/31/2021 15:54:17'!
previous: aNaturalNumber
	
	_previous _ aNaturalNumber! !


!classDefinition: #III category: 'Numeros Naturales'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Numeros Naturales'!
III class
	instanceVariableNames: ''!

!III class methodsFor: 'as yet unclassified' stamp: 'TC 8/31/2021 19:12:32'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	_next := IIII.
	_previous := II.! !


!classDefinition: #IIII category: 'Numeros Naturales'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Numeros Naturales'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: 'as yet unclassified' stamp: 'TC 8/31/2021 19:12:32'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	_next := IIIII.
	_previous := III.! !


!classDefinition: #IIIII category: 'Numeros Naturales'!
II subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: 'Numeros Naturales'!
IIIII class
	instanceVariableNames: ''!

!IIIII class methodsFor: 'as yet unclassified' stamp: 'TC 8/31/2021 19:12:32'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	_next := IIIIII.
	_previous := IIII.! !


!classDefinition: #IIIIII category: 'Numeros Naturales'!
II subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: 'Numeros Naturales'!
IIIIII class
	instanceVariableNames: ''!

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'TC 8/31/2021 19:12:32'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	_next := IIIIIII.
	_previous := IIIII.! !


!classDefinition: #IIIIIII category: 'Numeros Naturales'!
II subclass: #IIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIII class' category: 'Numeros Naturales'!
IIIIIII class
	instanceVariableNames: ''!

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'TC 8/31/2021 19:12:32'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	_next := nil.
	_previous := IIIIII.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!
IIIIIII initializeAfterFileIn!
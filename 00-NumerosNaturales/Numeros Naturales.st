!classDefinition: #I category: 'Numeros Naturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Numeros Naturales'!
I class
	instanceVariableNames: 'descripcionDeErrorDeNumerosNegativosNoSoportados'!

!I class methodsFor: 'Comparaciones' stamp: 'TC 9/1/2021 12:29:35'!
< aNaturalNumber

	^ (self = aNaturalNumber) not.! !

!I class methodsFor: 'Comparaciones' stamp: 'TC 9/1/2021 12:29:40'!
<= aNaturalNumber

	^ true.! !


!I class methodsFor: 'Errores' stamp: 'TC 9/1/2021 12:29:50'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^ 'No se puede didividir por un numero mayor'.! !

!I class methodsFor: 'Errores' stamp: 'TC 9/1/2021 12:29:55'!
descripcionDeErrorDeNumerosNegativosNoSoportados

	^ 'Numeros negativos no soportados'.! !


!I class methodsFor: 'Operaciones' stamp: 'TC 9/1/2021 12:34:34'!
* aMultiplicand

	^ aMultiplicand.! !

!I class methodsFor: 'Operaciones' stamp: 'TC 9/1/2021 12:33:48'!
+ anAddend

	^ anAddend next.! !

!I class methodsFor: 'Operaciones' stamp: 'TC 9/1/2021 12:35:18'!
- aSubtrahend

	^ self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.! !

!I class methodsFor: 'Operaciones' stamp: 'TC 9/1/2021 12:36:19'!
/ aDivisor

	aDivisor <= I ifTrue: [^ I].
	^ self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.! !


!I class methodsFor: 'Relaciones internas' stamp: 'TC 9/1/2021 12:29:19'!
next

	^ II.! !


!I class methodsFor: 'as yet unclassified' stamp: 'TC 9/1/2021 13:33:50'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	descripcionDeErrorDeNumerosNegativosNoSoportados := nil.! !


!classDefinition: #II category: 'Numeros Naturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Numeros Naturales'!
II class
	instanceVariableNames: 'previous next descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor'!

!II class methodsFor: 'Comparaciones' stamp: 'TC 9/1/2021 12:30:49'!
< aNaturalNumber

	^ self next <= aNaturalNumber.! !

!II class methodsFor: 'Comparaciones' stamp: 'TC 9/1/2021 12:30:58'!
<= aNaturalNumber

	[(self - aNaturalNumber)] on: Error do: [^ true].
	^ false.! !


!II class methodsFor: 'Errores' stamp: 'TC 9/1/2021 12:31:06'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^ 'No se puede dividir por un numero mayor'.! !


!II class methodsFor: 'Operaciones' stamp: 'TC 9/1/2021 12:37:15'!
* aMultiplicand

	^ self previous * aMultiplicand + aMultiplicand.! !

!II class methodsFor: 'Operaciones' stamp: 'TC 9/1/2021 12:37:39'!
+ anAddend

	^ self previous + anAddend next.! !

!II class methodsFor: 'Operaciones' stamp: 'TC 9/1/2021 13:33:38'!
- aSubtrahend

	aSubtrahend = I ifTrue: [^ self previous].
	^ self previous - aSubtrahend previous.! !

!II class methodsFor: 'Operaciones' stamp: 'TC 9/1/2021 12:38:11'!
/ aDivisor	

	| resta |
	self = aDivisor ifTrue: [^ I].
	(self < aDivisor) ifTrue: [^ self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	resta _ self - aDivisor.
	resta < aDivisor ifTrue: [^ I].
	^ (resta / aDivisor) next.! !


!II class methodsFor: 'Relaciones internas' stamp: 'TC 9/1/2021 12:32:25'!
next

	next ifNotNil: [^ next].
	next := II createChildNamed: self name, 'I'.
	next previous: self.
	^next.! !

!II class methodsFor: 'Relaciones internas' stamp: 'TC 9/1/2021 12:32:31'!
previous

	^ previous.! !

!II class methodsFor: 'Relaciones internas' stamp: 'TC 9/1/2021 12:38:42'!
previous: aNaturalNumber.

	previous _ aNaturalNumber.! !


!II class methodsFor: 'as yet unclassified' stamp: 'TC 9/1/2021 13:33:50'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := I.
	next := III.
	descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor := nil.! !


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

!III class methodsFor: 'as yet unclassified' stamp: 'TC 9/1/2021 13:33:50'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := II.
	next := IIII.
	descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor := nil.! !


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

!IIII class methodsFor: 'as yet unclassified' stamp: 'TC 9/1/2021 13:33:50'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := III.
	next := IIIII.
	descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor := nil.! !


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

!IIIII class methodsFor: 'as yet unclassified' stamp: 'TC 9/1/2021 13:33:50'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIII.
	next := IIIIII.
	descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor := nil.! !


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

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'TC 9/1/2021 13:33:50'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIII.
	next := IIIIIII.
	descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor := nil.! !


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

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'TC 9/1/2021 13:33:50'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIII.
	next := IIIIIIII.
	descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor := nil.! !


!classDefinition: #IIIIIIII category: 'Numeros Naturales'!
II subclass: #IIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIII class' category: 'Numeros Naturales'!
IIIIIIII class
	instanceVariableNames: ''!

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'TC 9/1/2021 13:33:50'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIII.
	next := IIIIIIIII.
	descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor := nil.! !


!classDefinition: #IIIIIIIII category: 'Numeros Naturales'!
II subclass: #IIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'TC 9/1/2021 13:33:50'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIII.
	next := IIIIIIIIII.
	descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor := nil.! !


!classDefinition: #IIIIIIIIII category: 'Numeros Naturales'!
II subclass: #IIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'TC 9/1/2021 13:33:50'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIII.
	next := IIIIIIIIIII.
	descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor := nil.! !


!classDefinition: #IIIIIIIIIII category: 'Numeros Naturales'!
II subclass: #IIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'TC 9/1/2021 13:33:50'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIII.
	next := IIIIIIIIIIII.
	descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor := nil.! !


!classDefinition: #IIIIIIIIIIII category: 'Numeros Naturales'!
II subclass: #IIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'TC 9/1/2021 13:33:50'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIII.
	next := IIIIIIIIIIIII.
	descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor := nil.! !


!classDefinition: #IIIIIIIIIIIII category: 'Numeros Naturales'!
II subclass: #IIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'TC 9/1/2021 13:33:50'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIII.
	next := IIIIIIIIIIIIII.
	descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor := nil.! !


!classDefinition: #IIIIIIIIIIIIII category: 'Numeros Naturales'!
II subclass: #IIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'TC 9/1/2021 13:33:50'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIII.
	next := IIIIIIIIIIIIIII.
	descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor := nil.! !


!classDefinition: #IIIIIIIIIIIIIII category: 'Numeros Naturales'!
II subclass: #IIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'TC 9/1/2021 13:33:50'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIII.
	descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor := nil.! !


!classDefinition: #IIIIIIIIIIIIIIII category: 'Numeros Naturales'!
II subclass: #IIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'TC 9/1/2021 13:33:50'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIII.
	next := nil.
	descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor := nil.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!
IIIIIII initializeAfterFileIn!
IIIIIIII initializeAfterFileIn!
IIIIIIIII initializeAfterFileIn!
IIIIIIIIII initializeAfterFileIn!
IIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIII initializeAfterFileIn!
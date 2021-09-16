!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 4/15/2021 16:45:35'!
test27EnteroSubstractsEnteroCorrectly

	self assert: four - one equals: three! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:02'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:09'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de número inválido!!!!!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'TC 9/14/2021 12:29:05'!
* aMultiplier

	^ aMultiplier multiplyWithEntero: self.
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'TC 9/14/2021 12:28:58'!
+ anAdder

	^ anAdder addWithEntero: self.
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'TC 9/14/2021 11:41:48'!
- aSubtrahend

	^ aSubtrahend substractFromEntero: self.
	
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'ds 9/12/2021 10:31:37'!
/ aDivisor
	
	^ aDivisor divideFromEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'ds 9/15/2021 14:48:50'!
// aDivisor 
	
	^ Entero with: value // aDivisor integerValue.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'ds 9/12/2021 18:04:18'!
fibonacci

	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
	
	^ (self - one) fibonacci + (self - two) fibonacci
		! !

!Entero methodsFor: 'arithmetic operations' stamp: 'ds 9/15/2021 14:46:20'!
greatestCommonDivisorWith: anEntero 
	
	^ Entero with: (value gcd: anEntero integerValue).! !


!Entero methodsFor: 'arithmetic operations (internal)' stamp: 'TC 9/14/2021 12:43:49'!
addWithEntero: anEnteroAdder

	^ Entero with: (value + anEnteroAdder integerValue).! !

!Entero methodsFor: 'arithmetic operations (internal)' stamp: 'ds 9/12/2021 10:00:40'!
addWithFraccion: aFraccion

	^ self + aFraccion.! !

!Entero methodsFor: 'arithmetic operations (internal)' stamp: 'ds 9/12/2021 10:31:48'!
divideFromEntero: anEntero

	^ Fraccion with: anEntero over: self.! !

!Entero methodsFor: 'arithmetic operations (internal)' stamp: 'TC 9/14/2021 12:27:32'!
divideFromFraccion: aFraccion

	^ Fraccion with: (aFraccion numerator) over: (aFraccion denominator * self).! !

!Entero methodsFor: 'arithmetic operations (internal)' stamp: 'TC 9/14/2021 12:44:22'!
multiplyWithEntero: anEnteroMultiplier

	^ Entero with: value * (anEnteroMultiplier integerValue).! !

!Entero methodsFor: 'arithmetic operations (internal)' stamp: 'TC 9/14/2021 12:24:02'!
multiplyWithFraccion: aFraccionMultiplier

	^ Fraccion with: (self * aFraccionMultiplier numerator) over: aFraccionMultiplier denominator.! !

!Entero methodsFor: 'arithmetic operations (internal)' stamp: 'TC 9/14/2021 12:14:01'!
substractFromEntero: anEntero
	
	^ Entero with: (anEntero integerValue - value).! !

!Entero methodsFor: 'arithmetic operations (internal)' stamp: 'TC 9/14/2021 12:23:40'!
substractFromFraccion: aFraccion
	
	^ Fraccion with: (aFraccion numerator - (self * aFraccion denominator)) over: aFraccion denominator.! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'fraccion creation' stamp: 'TC 9/16/2021 14:29:25'!
createFraccionWithDenominator: aDenominator
	
	| greatestCommonDivisor numerator denominator |
	
	greatestCommonDivisor := self greatestCommonDivisorWith: aDenominator. 
	numerator := self // greatestCommonDivisor.
	denominator := aDenominator // greatestCommonDivisor.
	
	^ denominator initializeFraccionWithNumerator: numerator.! !

!Entero methodsFor: 'fraccion creation' stamp: 'TC 9/16/2021 14:29:14'!
createFraccionWithNumerator: aDividend

	^ aDividend createFraccionWithDenominator: self.! !

!Entero methodsFor: 'fraccion creation' stamp: 'TC 9/16/2021 14:29:25'!
initializeFraccionWithNumerator: aNumerator

	^ Fraccion new initializeWith: aNumerator over: self.
! !


!Entero methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 20:09'!
initalizeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'NR 9/23/2018 22:17:55'!
isNegative
	
	^value < 0! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:14'!
isOne
	
	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:12'!
isZero
	
	^value = 0! !


!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/15/2021 16:42:24'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos!!!!!!'! !

!Entero class methodsFor: 'instance creation' stamp: 'ds 9/15/2021 14:58:12'!
with: aValue 
	
	| subclass |
	
	subclass := self subclasses detect: [:anEnteroClass | anEnteroClass isFor: aValue] ifNone: [self error: 'aValue debe ser anInteger'].
	
	^ subclass new initializeWith: aValue.! !


!classDefinition: #Cero category: 'Numero-Exercise'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'arithmetic operations' stamp: 'ds 9/12/2021 18:01:18'!
fibonacci
	
	^ Entero with: 1.! !


!Cero methodsFor: 'fraccion creation' stamp: 'TC 9/16/2021 14:29:01'!
createFraccionWithDenominator: aDenominator
	
	^ self.! !

!Cero methodsFor: 'fraccion creation' stamp: 'TC 9/16/2021 14:29:14'!
createFraccionWithNumerator: aNumerator
	
	^ self error: Numero canNotDivideByZeroErrorDescription.! !

!Cero methodsFor: 'fraccion creation' stamp: 'TC 9/16/2021 14:29:25'!
initializeFraccionWithNumerator: aNumerator

	^ self error: 'Can not initialize fraction with denominator 0'.! !


!Cero methodsFor: 'initialization' stamp: 'ds 9/12/2021 17:20:25'!
initialize
	
	value := 0.! !

!Cero methodsFor: 'initialization' stamp: 'ds 9/13/2021 18:06:39'!
initializeWith: aValue
	
	self initialize.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cero class' category: 'Numero-Exercise'!
Cero class
	instanceVariableNames: ''!

!Cero class methodsFor: 'as yet unclassified' stamp: 'ds 9/13/2021 18:05:14'!
isFor: aValue
	
	^ aValue = 0.! !


!classDefinition: #EnteroMayorAUno category: 'Numero-Exercise'!
Entero subclass: #EnteroMayorAUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroMayorAUno methodsFor: 'initialization' stamp: 'ds 9/15/2021 14:41:34'!
initializeWith: aValue
	
	value := aValue.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroMayorAUno class' category: 'Numero-Exercise'!
EnteroMayorAUno class
	instanceVariableNames: ''!

!EnteroMayorAUno class methodsFor: 'as yet unclassified' stamp: 'ds 9/15/2021 14:39:24'!
isFor: aValue
	
	^ aValue > 1.! !


!classDefinition: #EnteroNegativo category: 'Numero-Exercise'!
Entero subclass: #EnteroNegativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroNegativo methodsFor: 'arithmetic operations' stamp: 'ds 9/12/2021 18:02:01'!
fibonacci
	
	^ self error: Entero negativeFibonacciErrorDescription.! !


!EnteroNegativo methodsFor: 'initialization' stamp: 'ds 9/15/2021 15:03:54'!
initializeWith: aValue
	
	value := aValue.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroNegativo class' category: 'Numero-Exercise'!
EnteroNegativo class
	instanceVariableNames: ''!

!EnteroNegativo class methodsFor: 'as yet unclassified' stamp: 'ds 9/13/2021 18:05:30'!
isFor: aValue
	
	^ aValue < 0.! !


!classDefinition: #Uno category: 'Numero-Exercise'!
Entero subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'arithmetic operations' stamp: 'ds 9/12/2021 18:01:34'!
fibonacci
	
	^ Entero with: 1.! !


!Uno methodsFor: 'fraccion creation' stamp: 'TC 9/16/2021 14:29:25'!
initializeFraccionWithNumerator: aNumerator
	
	^ aNumerator.! !


!Uno methodsFor: 'initialization' stamp: 'ds 9/12/2021 17:20:14'!
initialize
	
	value := 1.! !

!Uno methodsFor: 'initialization' stamp: 'ds 9/13/2021 18:06:57'!
initializeWith: aValue
	
	self initialize.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Uno class' category: 'Numero-Exercise'!
Uno class
	instanceVariableNames: ''!

!Uno class methodsFor: 'as yet unclassified' stamp: 'ds 9/13/2021 18:05:23'!
isFor: aValue
	
	^ aValue = 1.! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'accessing' stamp: 'ds 9/12/2021 17:40:16'!
denominator

	^ Entero with: denominator integerValue.! !

!Fraccion methodsFor: 'accessing' stamp: 'ds 9/12/2021 17:40:25'!
numerator

	^ Entero with: numerator integerValue.! !


!Fraccion methodsFor: 'arithmetic operations' stamp: 'TC 9/14/2021 12:05:38'!
* aMultiplier

	^ aMultiplier multiplyWithFraccion: self.
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'TC 9/14/2021 12:05:42'!
+ anAdder

	^ anAdder addWithFraccion: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'ds 9/12/2021 10:32:37'!
- aSubtrahend 

	^ aSubtrahend substractFromFraccion: self.
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'ds 9/12/2021 10:32:44'!
/ aDivisor

	^ aDivisor divideFromFraccion: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'TC 9/14/2021 11:54:38'!
negated

	^ (Entero with: -1) * self.! !


!Fraccion methodsFor: 'arithmetic operations (internal)' stamp: 'TC 9/14/2021 12:31:41'!
addWithEntero: anEntero

	^ self class with: (anEntero * denominator + numerator) over: denominator.! !

!Fraccion methodsFor: 'arithmetic operations (internal)' stamp: 'TC 9/14/2021 12:38:31'!
addWithFraccion: aFraccion

	| newNumerator newDenominator |
	
	newNumerator := (numerator * aFraccion denominator) + (denominator * aFraccion numerator).
	newDenominator := denominator * aFraccion denominator.
	
	^ self class with: newNumerator over: newDenominator.
	! !

!Fraccion methodsFor: 'arithmetic operations (internal)' stamp: 'TC 9/14/2021 12:35:04'!
divideFromEntero: anEntero
			
	^ self class with: (denominator * anEntero ) over: numerator.! !

!Fraccion methodsFor: 'arithmetic operations (internal)' stamp: 'TC 9/14/2021 12:35:31'!
divideFromFraccion: aFraccion
		
	^ self class with: (denominator * aFraccion numerator) over: (numerator * aFraccion denominator).! !

!Fraccion methodsFor: 'arithmetic operations (internal)' stamp: 'TC 9/14/2021 12:37:18'!
multiplyWithEntero: anEnteroMultiplier

	^ self class with: (numerator * anEnteroMultiplier) over: denominator.! !

!Fraccion methodsFor: 'arithmetic operations (internal)' stamp: 'TC 9/14/2021 12:37:37'!
multiplyWithFraccion: aFraccionMultiplier

	^ self class with: (numerator * aFraccionMultiplier numerator) over: (denominator * aFraccionMultiplier denominator)! !

!Fraccion methodsFor: 'arithmetic operations (internal)' stamp: 'TC 9/14/2021 12:37:57'!
substractFromEntero: anEntero
	
	^ self class with: (anEntero * denominator - numerator) over: denominator.! !

!Fraccion methodsFor: 'arithmetic operations (internal)' stamp: 'TC 9/14/2021 12:38:40'!
substractFromFraccion: aFraccion
	
	| newNumerator newDenominator |
	
	newNumerator := (aFraccion numerator * denominator) - (numerator * aFraccion denominator).
	newDenominator := denominator * aFraccion denominator.
	
	^ self class with: newNumerator over: newDenominator.! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'initialization' stamp: 'ds 9/12/2021 17:55:47'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := Entero with: aNumerator integerValue.
	denominator := Entero with: aDenominator integerValue. ! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'TC 9/16/2021 14:29:14'!
with: aDividend over: aDivisor

	^ aDivisor createFraccionWithNumerator: aDividend.! !

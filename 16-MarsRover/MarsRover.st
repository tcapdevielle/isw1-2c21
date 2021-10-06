!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'tests - movement' stamp: 'ds 10/6/2021 19:02:23'!
test02GoForward
	
	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 1@3 heading: North).! !

!MarsRoverTest methodsFor: 'tests - movement' stamp: 'ds 10/6/2021 19:04:47'!
test03GoBackwards
	
	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 1@1 heading: North).! !

!MarsRoverTest methodsFor: 'tests - movement' stamp: 'ds 10/6/2021 19:04:57'!
test06GoForwardMoreTimes
	
	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North.
	
	marsRover process: 'fffff'.
	
	self assert: (marsRover isAt: 1@7 heading: North).! !

!MarsRoverTest methodsFor: 'tests - movement' stamp: 'ds 10/6/2021 19:05:00'!
test07GoBackwardsMoreTimes
	
	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North.
	
	marsRover process: 'bbbbb'.
	
	self assert: (marsRover isAt: 1@-3 heading: North).! !

!MarsRoverTest methodsFor: 'tests - movement' stamp: 'ds 10/6/2021 19:05:03'!
test10MixForwardAndBackwards
	
	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North.
	
	marsRover process: 'ffbfffbbf'.
	
	self assert: (marsRover isAt: 1@5 heading: North).! !


!MarsRoverTest methodsFor: 'auxiliar' stamp: 'ds 10/6/2021 18:33:25'!
assertThatCommandsAreInvalid: aSeriesOfCommands withRover: aMarsRover
	
	self
		should: [ aMarsRover process: aSeriesOfCommands. ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText = 'command not understood!!!!!!'. ]! !


!MarsRoverTest methodsFor: 'test - rotations' stamp: 'ds 10/6/2021 19:05:07'!
test04TurnLeft
	
	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: West).! !

!MarsRoverTest methodsFor: 'test - rotations' stamp: 'ds 10/6/2021 19:05:10'!
test05TurnRight
	
	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: East).! !

!MarsRoverTest methodsFor: 'test - rotations' stamp: 'ds 10/6/2021 19:05:13'!
test08TurnLeftMoreTimes
	
	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North.
	
	marsRover process: 'lllllll'.
	
	self assert: (marsRover isAt: 1@2 heading: East).! !

!MarsRoverTest methodsFor: 'test - rotations' stamp: 'ds 10/6/2021 19:05:16'!
test09TurnRightMoreTimes
	
	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North.
	
	marsRover process: 'rrr'.
	
	self assert: (marsRover isAt: 1@2 heading: West).! !


!MarsRoverTest methodsFor: 'tests - mixed' stamp: 'ds 10/6/2021 19:05:19'!
test01NoCommandsGiven
	
	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North.
	
	marsRover process: ''.
	
	self assert: (marsRover isAt: 1@2 heading: North).! !

!MarsRoverTest methodsFor: 'tests - mixed' stamp: 'ds 10/6/2021 19:05:21'!
test11ForwardAndTurn
	
	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North.
	
	marsRover process: 'flfrf'.
	
	self assert: (marsRover isAt: 0@4 heading: North).! !

!MarsRoverTest methodsFor: 'tests - mixed' stamp: 'ds 10/6/2021 19:05:23'!
test12TurnRightAndForward
	
	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North.
	
	marsRover process: 'rf'.
	
	self assert: (marsRover isAt: 2@2 heading: East).! !

!MarsRoverTest methodsFor: 'tests - mixed' stamp: 'ds 10/6/2021 19:05:26'!
test13TurnRightAndBackwards
	
	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North.
	
	marsRover process: 'rrrb'.
	
	self assert: (marsRover isAt: 2@2 heading: West).! !

!MarsRoverTest methodsFor: 'tests - mixed' stamp: 'ds 10/6/2021 19:05:31'!
test14TurnLeftAndForward
	
	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North.
	
	marsRover process: 'llf'.
	
	self assert: (marsRover isAt: 1@1 heading: South).! !

!MarsRoverTest methodsFor: 'tests - mixed' stamp: 'ds 10/6/2021 19:05:35'!
test15TurnLeftAndBackwards
	
	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North.
	
	marsRover process: 'llb'.
	
	self assert: (marsRover isAt: 1@3 heading: South).! !

!MarsRoverTest methodsFor: 'tests - mixed' stamp: 'ds 10/6/2021 19:05:38'!
test16ManyCommands1
	
	| marsRover |
	
	marsRover := MarsRover at: 0@0 heading: West.
	
	marsRover process: 'lfrfflfbfflfffb'.
	
	self assert: (marsRover isAt: 0@-3 heading: East).! !

!MarsRoverTest methodsFor: 'tests - mixed' stamp: 'ds 10/6/2021 19:05:41'!
test17ManyCommands2
	
	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: North.
	
	marsRover process: 'ffbbrflfrblb'.
	
	self assert: (marsRover isAt: 1@1 heading: North).! !

!MarsRoverTest methodsFor: 'tests - mixed' stamp: 'ds 10/6/2021 19:05:43'!
test18ManyCommands3
	
	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: North.
	
	marsRover process: 'llllrrrrffrflffbr'.
	
	self assert: (marsRover isAt: 2@4 heading: East).! !


!MarsRoverTest methodsFor: 'tests - invalid' stamp: 'ds 10/6/2021 19:05:47'!
test19InvalidCommandFails
	
	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: North.
	
	self assertThatCommandsAreInvalid: 'x' withRover: marsRover.	
	
	self assert: (marsRover isAt: 1@1 heading: North).! !

!MarsRoverTest methodsFor: 'tests - invalid' stamp: 'ds 10/6/2021 19:05:51'!
test20InvalidCommandAtBeginningFailsAndCutsExecution
	
	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: North.
	
	self assertThatCommandsAreInvalid: '4ffbl' withRover: marsRover. 
	
	self assert: (marsRover isAt: 1@1 heading: North).! !

!MarsRoverTest methodsFor: 'tests - invalid' stamp: 'ds 10/6/2021 19:05:56'!
test21InvalidCommandAtTheEndFailsButRunsPreviousCommands
	
	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: North.
	
	self assertThatCommandsAreInvalid: 'ffrfllq' withRover: marsRover.
	
	self assert: (marsRover isAt: 2@3 heading: West).! !

!MarsRoverTest methodsFor: 'tests - invalid' stamp: 'ds 10/6/2021 19:06:00'!
test22InvalidCommandInTheMiddleCutsExecutionAndFails
	
	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: North.
	
	self assertThatCommandsAreInvalid: 'fzf' withRover: marsRover.
	
	self assert: (marsRover isAt: 1@2 heading: North).! !

!MarsRoverTest methodsFor: 'tests - invalid' stamp: 'ds 10/6/2021 19:06:03'!
test23InstructionsWithInvalidCommandsFailAtFirstError
	
	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: North.
	
	self assertThatCommandsAreInvalid: 'bblffqrffbzllr' withRover: marsRover.
	
	self assert: (marsRover isAt: -1@-1 heading: West).! !


!classDefinition: #Direction category: 'MarsRover'!
Object subclass: #Direction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Direction methodsFor: 'turns' stamp: 'ds 10/6/2021 17:34:46'!
turnLeft
	
	self subclassResponsibility.! !

!Direction methodsFor: 'turns' stamp: 'ds 10/6/2021 17:34:50'!
turnRight
	
	self subclassResponsibility.! !


!Direction methodsFor: 'robot' stamp: 'ds 10/6/2021 17:58:24'!
moveRobotBackwards: aRobot

	self subclassResponsibility.! !

!Direction methodsFor: 'robot' stamp: 'ds 10/6/2021 17:58:43'!
moveRobotForward: aRobot

	self subclassResponsibility.! !


!classDefinition: #East category: 'MarsRover'!
Direction subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'turns' stamp: 'ds 10/6/2021 17:35:25'!
turnLeft
	
	^ North new.! !

!East methodsFor: 'turns' stamp: 'ds 10/6/2021 17:35:34'!
turnRight
	
	^ South new.! !


!East methodsFor: 'robot' stamp: 'ds 10/6/2021 17:59:16'!
moveRobotBackwards: aRobot

	aRobot moveLeft.! !

!East methodsFor: 'robot' stamp: 'ds 10/6/2021 17:59:22'!
moveRobotForward: aRobot

	aRobot moveRight.! !


!classDefinition: #North category: 'MarsRover'!
Direction subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'turns' stamp: 'ds 10/6/2021 17:35:52'!
turnLeft

	^ West new.! !

!North methodsFor: 'turns' stamp: 'ds 10/6/2021 17:36:01'!
turnRight

	^ East new.! !


!North methodsFor: 'robot' stamp: 'ds 10/6/2021 18:00:02'!
moveRobotBackwards: aRobot

	aRobot moveDown.! !

!North methodsFor: 'robot' stamp: 'ds 10/6/2021 17:59:52'!
moveRobotForward: aRobot

	aRobot moveUp.! !


!classDefinition: #South category: 'MarsRover'!
Direction subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'turns' stamp: 'ds 10/6/2021 17:36:15'!
turnLeft
	
	^ East new.! !

!South methodsFor: 'turns' stamp: 'ds 10/6/2021 17:36:21'!
turnRight
	
	^ West new.! !


!South methodsFor: 'robot' stamp: 'ds 10/6/2021 18:00:23'!
moveRobotBackwards: aRobot

	aRobot moveUp.! !

!South methodsFor: 'robot' stamp: 'ds 10/6/2021 18:00:16'!
moveRobotForward: aRobot

	aRobot moveDown.! !


!classDefinition: #West category: 'MarsRover'!
Direction subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'turns' stamp: 'ds 10/6/2021 17:36:38'!
turnLeft
	
	^ South new.! !

!West methodsFor: 'turns' stamp: 'ds 10/6/2021 17:36:46'!
turnRight
	
	^ North new.! !


!West methodsFor: 'robot' stamp: 'ds 10/6/2021 17:59:41'!
moveRobotBackwards: aRobot

	aRobot moveRight.! !

!West methodsFor: 'robot' stamp: 'ds 10/6/2021 17:59:33'!
moveRobotForward: aRobot

	aRobot moveLeft.! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'ds 10/6/2021 16:29:29'!
initializeAt: aPosition heading: aDirection

	position := aPosition.
	heading := aDirection.! !


!MarsRover methodsFor: 'interface' stamp: 'ds 10/6/2021 19:03:48'!
isAt: aPosition heading: aDirectionClass

	^ position = aPosition and: [heading class = aDirectionClass].
! !

!MarsRover methodsFor: 'interface' stamp: 'ds 10/6/2021 18:49:52'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand].! !


!MarsRover methodsFor: 'processing (private)' stamp: 'ds 10/6/2021 18:50:16'!
processCommand: aCommand

	aCommand = $f ifTrue: [^self moveForward ].
	aCommand = $b ifTrue: [^self moveBackwards ].
	aCommand = $l ifTrue: [^self turnLeft].
	aCommand = $r ifTrue: [^self turnRight].
	
	^ self error: MarsRover commandNotUnderstoodError.
	
	! !


!MarsRover methodsFor: 'movement (private)' stamp: 'ds 10/6/2021 18:01:03'!
moveBackwards
	
	heading moveRobotBackwards: self.
	! !

!MarsRover methodsFor: 'movement (private)' stamp: 'ds 10/6/2021 18:01:25'!
moveForward
	
	heading moveRobotForward: self.
	
	! !

!MarsRover methodsFor: 'movement (private)' stamp: 'ds 10/6/2021 18:03:02'!
turnLeft
	
	heading := heading turnLeft.
	
	! !

!MarsRover methodsFor: 'movement (private)' stamp: 'ds 10/6/2021 18:03:14'!
turnRight
	
	heading := heading turnRight.
	
	! !


!MarsRover methodsFor: 'movement - grid (private)' stamp: 'ds 10/6/2021 17:53:28'!
moveDown
	
	position := position x @ (position y - 1).
	
	! !

!MarsRover methodsFor: 'movement - grid (private)' stamp: 'ds 10/6/2021 17:53:19'!
moveLeft
	
	position := (position x - 1) @ position y.
	
	! !

!MarsRover methodsFor: 'movement - grid (private)' stamp: 'ds 10/6/2021 17:53:16'!
moveRight
	
	position := (position x + 1) @ position y.
	
	! !

!MarsRover methodsFor: 'movement - grid (private)' stamp: 'ds 10/6/2021 17:53:11'!
moveUp
	
	position := position x @ (position y + 1).
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'ds 10/6/2021 19:01:13'!
at: aPosition heading: aDirectionClass
	
	^ self new initializeAt: aPosition heading: (aDirectionClass new).! !

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'ds 10/6/2021 18:07:57'!
commandNotUnderstoodError
	
	^ 'command not understood!!!!!!'! !

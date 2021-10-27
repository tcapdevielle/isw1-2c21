!classDefinition: #MarsRoverDisplayTests category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverDisplayTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverDisplayTests methodsFor: 'test - position' stamp: 'ds 10/26/2021 21:29:58'!
test01noMovementsEmptyLog

	self assertRoverPositionLogsForCommands: '' isEqualsTo: #().! !

!MarsRoverDisplayTests methodsFor: 'test - position' stamp: 'ds 10/26/2021 20:58:06'!
test02trackPositionForward

	self assertRoverPositionLogsForCommands: 'f' isEqualsTo: #('1@2').! !

!MarsRoverDisplayTests methodsFor: 'test - position' stamp: 'ds 10/26/2021 20:58:22'!
test03trackPositionBackwards
	
	self assertRoverPositionLogsForCommands: 'b' isEqualsTo: #('1@0').! !

!MarsRoverDisplayTests methodsFor: 'test - position' stamp: 'ds 10/26/2021 20:58:39'!
test04multipleMoves
	
	self assertRoverPositionLogsForCommands: 'ffrf' isEqualsTo: #('1@2' '1@3' '2@3').! !

!MarsRoverDisplayTests methodsFor: 'test - position' stamp: 'ds 10/26/2021 21:34:04'!
test11trackPositionOnlyAfterAddingPlugin
	
	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	marsRover process: 'ffrf'. "ends in 2@3"
	log := marsRover addPositionDisplay: MarsRoverLogDisplay new.
	marsRover process: 'flb'.
	
	self assertLog: log hasEntries: #('3@3' '3@2').! !

!MarsRoverDisplayTests methodsFor: 'test - position' stamp: 'ds 10/26/2021 20:59:25'!
test13trackPositionLeft
	
	self assertRoverPositionLogsForCommands: 'lf' isEqualsTo: #('0@1').! !

!MarsRoverDisplayTests methodsFor: 'test - position' stamp: 'ds 10/26/2021 20:59:35'!
test14trackPositionRight
	
	self assertRoverPositionLogsForCommands: 'rf' isEqualsTo: #('2@1').! !

!MarsRoverDisplayTests methodsFor: 'test - position' stamp: 'ds 10/26/2021 21:29:16'!
test15noMovementsEmptyWindow

	self assertRoverPositionWindowForCommands: '' isEqualsTo: ''.! !


!MarsRoverDisplayTests methodsFor: 'test - heading' stamp: 'ds 10/26/2021 21:02:03'!
test06trackHeadingChangeDoesNotTrackMovement
	
	self assertRoverHeadingLogsForCommands: 'ffbb' isEqualsTo: #().! !

!MarsRoverDisplayTests methodsFor: 'test - heading' stamp: 'ds 10/26/2021 21:02:39'!
test07trackHeadingTracksHeadingChangesWithR

	self assertRoverHeadingLogsForCommands: 'rrrr' isEqualsTo: #('East' 'South' 'West' 'North').! !

!MarsRoverDisplayTests methodsFor: 'test - heading' stamp: 'ds 10/26/2021 21:02:56'!
test08trackHeadingTracksHeadingChangesWithL
	
	self assertRoverHeadingLogsForCommands: 'llll' isEqualsTo: #('West' 'South' 'East' 'North').! !

!MarsRoverDisplayTests methodsFor: 'test - heading' stamp: 'ds 10/26/2021 21:03:11'!
test09trackHeadingOnlyTracksHeadingChanges
	
	self assertRoverHeadingLogsForCommands: 'ffrbrfl' isEqualsTo: #('East' 'South' 'East').! !

!MarsRoverDisplayTests methodsFor: 'test - heading' stamp: 'ds 10/26/2021 21:34:04'!
test12trackHeadingOnlyAfterAddingPlugin
	
	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	marsRover process: 'frrbl'. "ends with heading East"
	log := marsRover addHeadingDisplay: MarsRoverLogDisplay new.
	marsRover process: 'frrl'.
	
	self assertLog: log hasEntries: #('South' 'West' 'South').! !


!MarsRoverDisplayTests methodsFor: 'test - position+heading' stamp: 'ds 10/26/2021 21:34:04'!
test10trackPositionAndHeadingChangesWithTwoTrackers
	
	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	log := MarsRoverLogDisplay new.
	log := marsRover addHeadingDisplay: log.
	log := marsRover addPositionDisplay: log.
	
	marsRover process: 'ffrbrfl'.
	
	self assertLog: log hasEntries: #('1@2' '1@3' 'East' '0@3' 'South' '0@2' 'East').
	! !


!MarsRoverDisplayTests methodsFor: 'test - window' stamp: 'ds 10/26/2021 21:18:56'!
test16trackPositionChangeInWindow
	
	self assertRoverPositionWindowForCommands: 'frf' isEqualsTo: '2@2'! !

!MarsRoverDisplayTests methodsFor: 'test - window' stamp: 'ds 10/26/2021 21:19:51'!
test17trackHeadingChangeInWindow
	
	self assertRoverHeadingWindowForCommands: 'frfrrbl' isEqualsTo: 'South'.! !

!MarsRoverDisplayTests methodsFor: 'test - window' stamp: 'ds 10/26/2021 21:21:30'!
test18trackHeadingAndPositionInWindow
	
	self assertRoverPositionAndHeadingWindowForCommands: 'frflbl' isEqualsTo: '2@1West'.! !

!MarsRoverDisplayTests methodsFor: 'test - window' stamp: 'ds 10/26/2021 21:34:15'!
test19trackHeadingAndPositionInLoggerAndWindow
	
	| marsRover window log |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	window := MarsRoverWindowDisplay new.
	marsRover addHeadingDisplay: window.
	marsRover addPositionDisplay: window.
	log := MarsRoverLogDisplay new.
	marsRover addHeadingDisplay: log.
	marsRover addPositionDisplay: log.
	
	marsRover process: 'frflbl'.
	
	self assert: '2@1West' equals: window display.
	
	self assert: 6 equals: log display size.
	self assert: '1@2' equals: (log display at: 1).
	self assert: 'East' equals: (log display at: 2).
	self assert: '2@2' equals: (log display at: 3).
	self assert: 'North' equals: (log display at: 4).
	self assert: '2@1' equals: (log display at: 5).
	self assert: 'West' equals: (log display at: 6).
	! !


!MarsRoverDisplayTests methodsFor: 'asserts' stamp: 'ds 10/26/2021 20:23:49'!
assertLog: aLog hasEntries: aListOfEntries

	self assert: aListOfEntries equals: (aLog display asArray).! !

!MarsRoverDisplayTests methodsFor: 'asserts' stamp: 'ds 10/26/2021 21:34:04'!
assertRoverHeadingLogsForCommands: aListOfCommands isEqualsTo: aListOfEntries
	
	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	log := marsRover addHeadingDisplay: MarsRoverLogDisplay new.
	
	marsRover process: aListOfCommands.
	
	self assertLog: log hasEntries: aListOfEntries.! !

!MarsRoverDisplayTests methodsFor: 'asserts' stamp: 'ds 10/26/2021 21:34:15'!
assertRoverHeadingWindowForCommands: aListOfCommands isEqualsTo: aHeading
	
	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	window := marsRover addHeadingDisplay: MarsRoverWindowDisplay new.
	
	marsRover process: aListOfCommands.
	
	self assert: aHeading equals: window display.! !

!MarsRoverDisplayTests methodsFor: 'asserts' stamp: 'ds 10/26/2021 21:34:15'!
assertRoverPositionAndHeadingWindowForCommands: aListOfCommands isEqualsTo: aPosition
	
	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	window := MarsRoverWindowDisplay new.
	marsRover addPositionDisplay: window.
	marsRover addHeadingDisplay: window.
	
	marsRover process: aListOfCommands.
	
	self assert: aPosition equals: window display.! !

!MarsRoverDisplayTests methodsFor: 'asserts' stamp: 'ds 10/26/2021 21:34:04'!
assertRoverPositionLogsForCommands: aListOfCommands isEqualsTo: aListOfEntries
	
	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	log := marsRover addPositionDisplay: MarsRoverLogDisplay new.
	
	marsRover process: aListOfCommands.
	
	self assertLog: log hasEntries: aListOfEntries.! !

!MarsRoverDisplayTests methodsFor: 'asserts' stamp: 'ds 10/26/2021 21:34:15'!
assertRoverPositionWindowForCommands: aListOfCommands isEqualsTo: aString
	
	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	window := marsRover addPositionDisplay: MarsRoverWindowDisplay new.
	
	marsRover process: aListOfCommands.
	
	self assert: aString equals: window display.! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head positionDisplays headingDisplays'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'ds 10/26/2021 20:47:20'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self.
	positionDisplays := OrderedCollection new.
	headingDisplays := OrderedCollection new.! !


!MarsRover methodsFor: 'heading' stamp: 'ds 10/26/2021 19:58:12'!
headEast
	
	self setNewHeading: MarsRoverHeadingEast.! !

!MarsRover methodsFor: 'heading' stamp: 'ds 10/26/2021 19:58:03'!
headNorth
	
	self setNewHeading: MarsRoverHeadingNorth.! !

!MarsRover methodsFor: 'heading' stamp: 'ds 10/26/2021 19:57:54'!
headSouth
	
	self setNewHeading: MarsRoverHeadingSouth.! !

!MarsRover methodsFor: 'heading' stamp: 'ds 10/26/2021 19:57:37'!
headWest
	
	self setNewHeading: MarsRoverHeadingWest.! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	head rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	head rotateRight! !

!MarsRover methodsFor: 'heading' stamp: 'ds 10/26/2021 20:47:41'!
setNewHeading: aHeadingClass
	
	head := aHeadingClass for: self.
	headingDisplays do: [:display | display updateHeading: head].! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	head moveBackward! !

!MarsRover methodsFor: 'moving' stamp: 'ds 10/26/2021 19:55:12'!
moveEast
	
	self moveWithOffset: 1@0.! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	head moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'ds 10/26/2021 19:55:00'!
moveNorth
	
	self moveWithOffset: 0@1.! !

!MarsRover methodsFor: 'moving' stamp: 'ds 10/26/2021 19:54:45'!
moveSouth
	
	self moveWithOffset: 0@-1.! !

!MarsRover methodsFor: 'moving' stamp: 'ds 10/26/2021 19:54:34'!
moveWest
	
	self moveWithOffset: -1@0.! !

!MarsRover methodsFor: 'moving' stamp: 'ds 10/26/2021 20:54:16'!
moveWithOffset: anOffset
	
	position := position + anOffset.
	positionDisplays do: [:display | display updatePosition: position].! !


!MarsRover methodsFor: 'command processing' stamp: 'ds 10/26/2021 19:58:56'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand].
! !

!MarsRover methodsFor: 'command processing' stamp: 'ds 10/25/2021 21:13:19'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].
	
	self signalInvalidCommand.! !


!MarsRover methodsFor: 'display' stamp: 'ds 10/26/2021 20:54:34'!
addHeadingDisplay: aDisplay
	
	headingDisplays addLast: aDisplay.
	^ aDisplay.! !

!MarsRover methodsFor: 'display' stamp: 'ds 10/26/2021 20:54:41'!
addPositionDisplay: aDisplay
	
	positionDisplays addLast: aDisplay.
	^ aDisplay.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverDisplay category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverDisplay
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverDisplay methodsFor: 'display' stamp: 'ds 10/26/2021 18:44:34'!
display
	
	self subclassResponsibility.! !


!MarsRoverDisplay methodsFor: 'update' stamp: 'ds 10/26/2021 20:09:41'!
updateHeading: aHeading
	
	self subclassResponsibility.! !

!MarsRoverDisplay methodsFor: 'update' stamp: 'ds 10/26/2021 20:09:47'!
updatePosition: aPosition
	
	self subclassResponsibility.! !


!classDefinition: #MarsRoverLogDisplay category: 'MarsRover-WithHeading'!
MarsRoverDisplay subclass: #MarsRoverLogDisplay
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogDisplay methodsFor: 'display' stamp: 'ds 10/26/2021 18:45:27'!
display
	
	^ log.! !


!MarsRoverLogDisplay methodsFor: 'initialization' stamp: 'ds 10/26/2021 20:51:18'!
initialize
	
	log := OrderedCollection new.! !


!MarsRoverLogDisplay methodsFor: 'update' stamp: 'ds 10/26/2021 20:08:02'!
updateHeading: aHeading
	
	log addLast: aHeading asString.! !

!MarsRoverLogDisplay methodsFor: 'update' stamp: 'ds 10/26/2021 20:08:09'!
updatePosition: aPosition
	
	log addLast: aPosition asString.! !


!classDefinition: #MarsRoverWindowDisplay category: 'MarsRover-WithHeading'!
MarsRoverDisplay subclass: #MarsRoverWindowDisplay
	instanceVariableNames: 'lastPosition lastHeading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindowDisplay methodsFor: 'display' stamp: 'ds 10/26/2021 19:32:35'!
display

	^ (lastPosition, lastHeading).! !


!MarsRoverWindowDisplay methodsFor: 'initialization' stamp: 'ds 10/26/2021 21:16:34'!
initialize
	
	lastPosition := ''.
	lastHeading := ''.! !


!MarsRoverWindowDisplay methodsFor: 'update' stamp: 'ds 10/26/2021 20:08:43'!
updateHeading: aHeading
	
	lastHeading := aHeading asString.! !

!MarsRoverWindowDisplay methodsFor: 'update' stamp: 'ds 10/26/2021 20:08:48'!
updatePosition: aPosition
	
	lastPosition := aPosition asString.! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'ds 10/26/2021 17:55:28'!
asString

	self subclassResponsibility! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'ds 10/26/2021 17:55:38'!
asString
	
	^ 'East'.! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'ds 10/26/2021 17:55:45'!
asString
	
	^ 'North'.! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'ds 10/26/2021 17:55:50'!
asString
	
	^ 'South'.! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'ds 10/26/2021 17:55:55'!
asString
	
	^ 'West'.! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !

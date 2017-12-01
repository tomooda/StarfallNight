"
StarfallNight is a so-called drop-game to align 3 of the same kind of jewels in a column, a row or diagonal .
"
Class {
	#name : #StarfallNightModel,
	#superclass : #Object,
	#instVars : [
		'columns',
		'currentJewels',
		'nextJewels',
		'column',
		'row',
		'numberOfJewels',
		'heart',
		'animation',
		'announcer'
	],
	#category : #StarfallNight
}

{ #category : #examples }
StarfallNightModel class >> example [
	<script: 'StarfallNightModel example'>
	| model element space |
	model := StarfallNightModel new.
	element := StarfallNightElement new.
	element starfallNight: model.
	^ element

]

{ #category : #accessing }
StarfallNightModel >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
StarfallNightModel >> at: aPoint [
	^ (columns at: aPoint y) at: aPoint x ifAbsent: [  ]
]

{ #category : #accessing }
StarfallNightModel >> at: aPoint put: anInteger [
	^ (columns at: aPoint y) at: aPoint x put: anInteger
]

{ #category : #accessing }
StarfallNightModel >> column [
	^ column
]

{ #category : #accessing }
StarfallNightModel >> column: anInteger [
	column := anInteger
]

{ #category : #accessing }
StarfallNightModel >> columns [
	^ columns
]

{ #category : #accessing }
StarfallNightModel >> columns: anArray6OfOrderedCollectionOfInteger [
	columns := anArray6OfOrderedCollectionOfInteger
]

{ #category : #accessing }
StarfallNightModel >> currentJewels [
	^ currentJewels
]

{ #category : #defaults }
StarfallNightModel >> defaultNumberOfJewels [
	^ 6
]

{ #category : #actions }
StarfallNightModel >> down [
	row := (columns at: column) size + 1.
	self notifyJewelsUpdated
]

{ #category : #actions }
StarfallNightModel >> fall [
	row := row - 1.
	(columns at: column) size < row
		ifFalse: [ (columns at: column) addAll: currentJewels.
			currentJewels := nil ].
	self notifyJewelsUpdated
]

{ #category : #actions }
StarfallNightModel >> gameOver [
	animation
		ifNotNil: [ animation
				stop;
				onFinishedDo: [  ].
			animation := nil ]
]

{ #category : #actions }
StarfallNightModel >> gameStart [
	self initialize.
	animation
		ifNil: [ animation := BlAnimation new
				duration: 300 milliSeconds;
				beInfinite;
				onFinishedDo: [ self onStep ] ].
	animation isRunning
		ifFalse: [ animation start ]
]

{ #category : #accessing }
StarfallNightModel >> generateJewel [
	^ (1 to: self numberOfJewels) atRandom
]

{ #category : #accessing }
StarfallNightModel >> generateTripleJewels [
	^ {self generateJewel.
	self generateJewel.
	self generateJewel}
]

{ #category : #constants }
StarfallNightModel >> heartCycle [
	^ 10
]

{ #category : #initialization }
StarfallNightModel >> initialize [
	super initialize.
	columns := (1 to: self numberOfColumns)
		collect: [ :c | OrderedCollection new: self numberOfRows ].
	row := self numberOfRows.
	column := (self numberOfColumns + 1) // 2.
	nextJewels ifNil: [ nextJewels := self generateTripleJewels ].
	heart := 0
]

{ #category : #testing }
StarfallNightModel >> isRunning [
	^ animation notNil and: [ animation isRunning ]
]

{ #category : #actions }
StarfallNightModel >> left [
	column <= 1
		ifTrue: [ ^ self ].
	(self at: row @ (column - 1)) ifNotNil: [ ^ self ].
	(self at: (row + 1) @ (column - 1)) ifNotNil: [ ^ self ].
	(self at: (row + 2) @ (column - 1)) ifNotNil: [ ^ self ].
	column := column - 1.
	self notifyJewelsUpdated
]

{ #category : #actions }
StarfallNightModel >> next [
	currentJewels := nextJewels.
	nextJewels := self generateTripleJewels.
	row := self numberOfRows.
	column := (self numberOfColumns + 1) // 2.
	(self at: row @ column) ifNotNil: [ self gameOver ].
	self notifyNextUpdated.
	self notifyJewelsUpdated
]

{ #category : #accessing }
StarfallNightModel >> nextJewels [
	^ nextJewels ifNil: [ nextJewels := self generateTripleJewels ]
]

{ #category : #announcement }
StarfallNightModel >> notifyBoardUpdated [
	self announcer announce: StarfallNightBoardUpdatedAnnouncement new
]

{ #category : #announcement }
StarfallNightModel >> notifyJewelsUpdated [
	self announcer announce: StarfallNightJewelsUpdatedAnnouncement new
]

{ #category : #announcement }
StarfallNightModel >> notifyNextUpdated [
	self announcer announce: StarfallNightNextUpdatedAnnouncement new
]

{ #category : #constants }
StarfallNightModel >> numberOfColumns [
	^ 6
]

{ #category : #accessing }
StarfallNightModel >> numberOfJewels [
	^ numberOfJewels ifNil: [ self defaultNumberOfJewels ]
]

{ #category : #constants }
StarfallNightModel >> numberOfRows [
	^ 13
]

{ #category : #actions }
StarfallNightModel >> onStep [
	currentJewels
		ifNil: [ self shrink.
			self vanishTriples
				ifFalse: [ self next ] ]
		ifNotNil: [ self fall ]
]

{ #category : #printing }
StarfallNightModel >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $).
	self numberOfRows to: 1 by: -1 do: [ :r | 
		aStream cr.
		1 to: self numberOfColumns do: [ :c | aStream nextPutAll: ((self at: r @ c) ifNil: [ '-' ]) asString ] ].
	aStream nextPut: $)
]

{ #category : #actions }
StarfallNightModel >> right [
	column >= self numberOfColumns
		ifTrue: [ ^ self ].
	(self at: row @ (column + 1)) ifNotNil: [ ^ self ].
	(self at: (row + 1) @ (column + 1)) ifNotNil: [ ^ self ].
	(self at: (row + 2) @ (column + 1)) ifNotNil: [ ^ self ].
	column := column + 1.
	self notifyJewelsUpdated
]

{ #category : #actions }
StarfallNightModel >> rotate [
	currentJewels
		ifNotNil: [ | j |
			j := currentJewels at: 1.
			currentJewels
				at: 1 put: (currentJewels at: 2);
				at: 2 put: (currentJewels at: 3);
				at: 3 put: j.
			self notifyJewelsUpdated ]
]

{ #category : #accessing }
StarfallNightModel >> row [
	^ row
]

{ #category : #accessing }
StarfallNightModel >> row: anInteger [
	row := anInteger
]

{ #category : #actions }
StarfallNightModel >> shrink [
	columns := columns collect: [ :theColumn | theColumn reject: #isNil ].
	self notifyBoardUpdated 
]

{ #category : #constants }
StarfallNightModel >> triplesDo: aBlock [
	1 to: self numberOfRows do:
		[ :r | 1 to: self numberOfColumns - 2 do: [ :c | aBlock value: r @ c value: r @ (c + 1) value: r @ (c + 2) ] ].
	1 to: self numberOfRows - 2 do:
		[ :r | 1 to: self numberOfColumns do: [ :c | aBlock value: r @ c value: (r + 1) @ c value: (r + 2) @ c ] ].
	1 to: self numberOfRows - 2 do: [ :r | 
		1 to: self numberOfColumns - 2 do: [ :c | 
			aBlock value: r @ c value: (r + 1) @ (c + 1) value: (r + 2) @ (c + 2).
			aBlock value: (r + 2) @ c value: (r + 1) @ (c + 1) value: r @ (c + 2) ] ]
]

{ #category : #actions }
StarfallNightModel >> vanishTriples [
	| points |
	points := Array new writeStream.
	self
		triplesDo: [ :p1 :p2 :p3 | 
			| j |
			((j := self at: p1) notNil
				and: [ j = (self at: p2) and: [ j = (self at: p3) ] ])
				ifTrue: [ points
						nextPut: p1;
						nextPut: p2;
						nextPut: p3 ] ].
	points := points contents.
	points do: [ :p | self at: p put: nil ].
	points ifNotEmpty: [ self notifyBoardUpdated ].
	^ points notEmpty
]

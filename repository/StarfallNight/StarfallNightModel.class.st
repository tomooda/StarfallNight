"
RetzBoard is a Morph that displays a game board of  the Retz game.
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
		'jewels',
		'heart',
		'announcer'
	],
	#category : #StarfallNight
}

{ #category : #accessing }
StarfallNightModel >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
StarfallNightModel >> at: aPoint [
	^ (columns at: aPoint y) at: aPoint x ifAbsent: [  ]
]

{ #category : #accessing }
StarfallNightModel >> at: aPoint put: aCharacter [
	^ (columns at: aPoint y) at: aPoint x put: aCharacter
]

{ #category : #accessing }
StarfallNightModel >> atColumn: c row: r put: aCharacter [
	^ (columns at: c) at: r put: aCharacter
]

{ #category : #constants }
StarfallNightModel >> colors [
	^ {Color red.
	Color magenta.
	Color cyan.
	Color orange.
	Color yellow.
	Color green}
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
StarfallNightModel >> columns: anArray6OfOrderedCollectionOfaCharacter [
	columns := anArray6OfOrderedCollectionOfaCharacter
]

{ #category : #accessing }
StarfallNightModel >> currentJewels [
	^ currentJewels
]

{ #category : #actions }
StarfallNightModel >> cycle [
	heart := heart + 1.
	heart >= self heartCycle
		ifTrue: [ jewels
				ifNil: [ self shrink.
					self vanishTriples
						ifFalse: [ self next ] ]
				ifNotNil: [ self down ].
			heart := 0 ]
]

{ #category : #defaults }
StarfallNightModel >> defaultJewels [
	^ #($A $B $C $D $E $F)
]

{ #category : #actions }
StarfallNightModel >> down [
	row := (columns at: column) + 1
]

{ #category : #actions }
StarfallNightModel >> fall [
	(columns at: column) size < row
		ifTrue: [ row := row - 1 ]
		ifFalse: [ (columns at: column) addAll: currentJewels.
			jewels := nil ]
]

{ #category : #accessing }
StarfallNightModel >> generateNextJewels [
	jewels := {jewels atRandom.
	jewels atRandom.
	jewels atRandom}
]

{ #category : #constants }
StarfallNightModel >> heartCycle [
	^ 10
]

{ #category : #initialization }
StarfallNightModel >> initialize [
	super initialize.
	jewels := self defaultJewels.
	columns := (1 to: self numberOfColumns)
		collect: [ :c | OrderedCollection new: self numberOfRows ].
	heart := 0
]

{ #category : #accessing }
StarfallNightModel >> jewels [
	^ jewels
]

{ #category : #accessing }
StarfallNightModel >> jewels: aCollectionOfCharacter [
	jewels := aCollectionOfCharacter
]

{ #category : #actions }
StarfallNightModel >> left [
	column := column - 1 max: 1
]

{ #category : #actions }
StarfallNightModel >> next [
	currentJewels := nextJewels.
	nextJewels := self generateNextJewels.
	row := self numberOfRows.
	column := self numberOfColumns + 1 // 2
]

{ #category : #accessing }
StarfallNightModel >> nextJewels [
	^ nextJewels ifNil: [ nextJewels := self generateNextJewels ]
]

{ #category : #constants }
StarfallNightModel >> numberOfColumns [
	^ 6
]

{ #category : #constants }
StarfallNightModel >> numberOfRows [
	^ 13
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
	column := column + 1 min: self numberOfColumns
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
	columns := columns collect: [ :theColumn | theColumn reject: #isNil ]
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
			((j := self at: p1) notNil and: [ j = (self at: p2) and: [ j = (self at: p3) ] ])
				ifTrue: [ points
						nextPut: p1;
						nextPut: p2;
						nextPut: p3 ] ].
	points := points contents.
	points do: [ :p | self at: p put: nil ].
	^ points notEmpty
]

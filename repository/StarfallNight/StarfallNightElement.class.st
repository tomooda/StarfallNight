"
this object gives a view of the starfall night game.
"
Class {
	#name : #StarfallNightElement,
	#superclass : #BlElement,
	#instVars : [
		'starfallNight',
		'colors'
	],
	#category : #StarfallNight
}

{ #category : #accessing }
StarfallNightElement >> backgroundPaint [
	^ Color gray
]

{ #category : #accessing }
StarfallNightElement >> colorAt: anInteger [
	^ self colors at: anInteger ifAbsent: [ Color black ]
]

{ #category : #accessing }
StarfallNightElement >> colors [
	^ colors ifNil: [ colors := self defaultColors ]
]

{ #category : #accessing }
StarfallNightElement >> colors: anArrayOfColor [
	colors := anArrayOfColor
]

{ #category : #defaults }
StarfallNightElement >> defaultColors [
	^ {Color red.
	Color magenta.
	Color cyan.
	Color orange.
	Color yellow.
	Color green}
]

{ #category : #drawing }
StarfallNightElement >> drawOnSpartaCanvas: aCanvas [
	aCanvas fill
		paint: self backgroundPaint;
		path: self boundsInLocal;
		draw.
	1 to: starfallNight numberOfRows do: [ :r | 
		1 to: starfallNight numberOfColumns do: [ :c | 
			| rect |
			rect := aCanvas shape
				roundedRectangle: (((c - 1) * 40) @ ((starfallNight numberOfRows - r) * 40) extent: 39 @ 39)
				radii: (BlCornerRadii radius: 10).
			aCanvas fill
				paint:
					((starfallNight at: r @ c)
						ifNotNil: [ :jewelIndex | self colorAt: jewelIndex ]
						ifNil: [ Color black ]);
				path: rect;
				draw ] ].
	starfallNight currentJewels
		ifNotNil: [ 1 to: 3 do: [ :index | 
				| r c |
				r := starfallNight row + index - 1.
				c := starfallNight column.
				(r between: 1 and: starfallNight numberOfRows)
					ifTrue: [ | rect |
						rect := aCanvas shape
							roundedRectangle: (((c - 1) * 40) @ ((starfallNight numberOfRows - r) * 40) extent: 39 @ 39)
							radii: (BlCornerRadii radius: 10).
						aCanvas fill
							paint: (self colorAt: (starfallNight currentJewels at: index));
							path: rect;
							draw ] ] ].
	starfallNight nextJewels
		ifNotNil: [ 1 to: 3 do: [ :index | 
				| rect |
				rect := aCanvas shape
					roundedRectangle: ((6 * 40 + 10) @ (160 - (index * 40)) extent: 39 @ 39)
					radii: (BlCornerRadii radius: 10).
				aCanvas fill
					paint: (self colorAt: (starfallNight nextJewels at: index));
					path: rect;
					draw ] ]
]

{ #category : #initialization }
StarfallNightElement >> initialize [
	super initialize.
	self size: 290 @ 520
]

{ #category : #actions }
StarfallNightElement >> onBoardChange [
	self invalidate
]

{ #category : #actions }
StarfallNightElement >> onJewelsChange [
	self invalidate
]

{ #category : #'event handling' }
StarfallNightElement >> onKeystroke: aBlKeystrokeEvent [
	starfallNight ifNil: [ ^ self ].
	starfallNight isRunning
		ifTrue: [ aBlKeystrokeEvent char = Character arrowLeft
				ifTrue: [ starfallNight left ].
			aBlKeystrokeEvent char = Character arrowRight
				ifTrue: [ starfallNight right ].
			aBlKeystrokeEvent char = Character arrowDown
				ifTrue: [ starfallNight down ].
			aBlKeystrokeEvent char = Character arrowUp
				ifTrue: [ starfallNight rotate ] ]
		ifFalse: [ starfallNight gameStart ]
]

{ #category : #actions }
StarfallNightElement >> onNextChange [
	self invalidate
]

{ #category : #accessing }
StarfallNightElement >> starfallNight [
	^ starfallNight 
]

{ #category : #accessing }
StarfallNightElement >> starfallNight: aStarfallNightModel [
	starfallNight := aStarfallNightModel.
	self
		addEventHandler:
			(BlEventHandler
				on: BlKeystrokeEvent
				do: [ :anEvent | self onKeystroke: anEvent ]).
	self requestFocus.
	starfallNight announcer
		when: StarfallNightBoardUpdatedAnnouncement
		send: #onBoardChange
		to: self.
	starfallNight announcer
		when: StarfallNightNextUpdatedAnnouncement
		send: #onNextChange
		to: self.
	starfallNight announcer
		when: StarfallNightJewelsUpdatedAnnouncement
		send: #onJewelsChange
		to: self
]

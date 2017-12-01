"
this object gives a view of the starfall night game.
"
Class {
	#name : #StarfallNightElement,
	#superclass : #BlElement,
	#instVars : [
		'starfallNight',
		'colors',
		'characters'
	],
	#category : #StarfallNight
}

{ #category : #accessing }
StarfallNightElement >> backgroundPaint [
	^ Color gray
]

{ #category : #accessing }
StarfallNightElement >> characterAt: anInteger [
	^ characters at: anInteger ifAbsent: [ Character space ]
]

{ #category : #accessing }
StarfallNightElement >> characters: anArrayOfCharacter [
	characters := anArrayOfCharacter
]

{ #category : #accessing }
StarfallNightElement >> charactersAt: anInteger [
	^ characters at: anInteger ifAbsent: [ Character space ]
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

{ #category : #defaults }
StarfallNightElement >> defaultJewels [
	^ #($A $B $C $D $E $F)
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
				paint: ((starfallNight at: r @ c) ifNotNil: [ :jewelIndex | self colorAt: jewelIndex ] ifNil: [ Color black ]);
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
							draw ] ] ]
]

{ #category : #initialization }
StarfallNightElement >> initialize [
	super initialize.
	self size: 290 @ 520
]

{ #category : #accessing }
StarfallNightElement >> starfallNight [
	^ starfallNight 
]

{ #category : #accessing }
StarfallNightElement >> starfallNight: aStarfallNightModel [
	starfallNight := aStarfallNightModel
]

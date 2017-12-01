actions
vanishTriples
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
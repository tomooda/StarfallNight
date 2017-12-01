printing
printOn: aStream
	super printOn: aStream.
	aStream nextPut: $).
	self numberOfRows to: 1 by: -1 do: [ :r | 
		aStream cr.
		1 to: self numberOfColumns do: [ :c | aStream nextPutAll: ((self at: r @ c) ifNil: [ '-' ]) asString ] ].
	aStream nextPut: $)
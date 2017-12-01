constants
triplesDo: aBlock
	1 to: self numberOfRows do:
		[ :r | 1 to: self numberOfColumns - 2 do: [ :c | aBlock value: r @ c value: r @ (c + 1) value: r @ (c + 2) ] ].
	1 to: self numberOfRows - 2 do:
		[ :r | 1 to: self numberOfColumns do: [ :c | aBlock value: r @ c value: (r + 1) @ c value: (r + 2) @ c ] ].
	1 to: self numberOfRows - 2 do: [ :r | 
		1 to: self numberOfColumns - 2 do: [ :c | 
			aBlock value: r @ c value: (r + 1) @ (c + 1) value: (r + 2) @ (c + 2).
			aBlock value: (r + 2) @ c value: (r + 1) @ (c + 1) value: r @ (c + 2) ] ]
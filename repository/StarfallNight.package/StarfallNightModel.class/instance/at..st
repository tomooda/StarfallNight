accessing
at: aPoint
	^ (columns at: aPoint y) at: aPoint x ifAbsent: [  ]
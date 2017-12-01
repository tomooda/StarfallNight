actions
fall
	(columns at: column) size < row
		ifTrue: [ row := row - 1 ]
		ifFalse: [ (columns at: column) addAll: currentJewels.
			jewels := nil ]
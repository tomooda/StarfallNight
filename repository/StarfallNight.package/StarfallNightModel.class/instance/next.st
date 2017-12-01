actions
next
	currentJewels := nextJewels.
	nextJewels := self generateNextJewels.
	row := self numberOfRows.
	column := self numberOfColumns + 1 // 2
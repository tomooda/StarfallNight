initialization
initialize
	super initialize.
	jewels := self defaultJewels.
	columns := (1 to: self numberOfColumns)
		collect: [ :c | OrderedCollection new: self numberOfRows ].
	heart := 0
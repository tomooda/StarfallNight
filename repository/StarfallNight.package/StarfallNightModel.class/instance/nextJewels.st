accessing
nextJewels
	^ nextJewels ifNil: [ nextJewels := self generateNextJewels ]
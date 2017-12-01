actions
cycle
	heart := heart + 1.
	heart >= self heartCycle
		ifTrue: [ jewels
				ifNil: [ self shrink.
					self vanishTriples
						ifFalse: [ self next ] ]
				ifNotNil: [ self down ].
			heart := 0 ]
"
baseline of the starfall night game package
"
Class {
	#name : #BaselineOfStarfallNight,
	#superclass : #BaselineOf,
	#category : #BaselineOfStarfallNight
}

{ #category : #baselines }
BaselineOfStarfallNight >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				package: #StarfallNight
				with: [ spec
						baseline: 'Bloc'
						with: [ spec repository: 'github://pharo-graphics/Bloc:pharo6.1/src' ] ].
			spec
				group: 'Core' with: #('StarfallNight');
				group: 'default' with: #('StarfallNight') ]
]

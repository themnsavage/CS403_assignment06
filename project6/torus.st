Shape subclass: Torus[
    | smallRadius bigRadius |

    init [
        smallRadius:= 0 asFloat.
        bigRadius:= 0 asFloat.
        ^ super init
    ]

    newTorus: name radiusOne: radiusOneValue radiusTwo: radiusTwoValue[
	radiusOneValue > radiusTwoValue
        ifTrue:[
            bigRadius:= radiusOneValue asFloat.
            smallRadius:= radiusTwoValue asFloat.
            ]
        ifFalse:[
            bigRadius:= radiusTwoValue asFloat.
            smallRadius:= radiusOneValue asFloat.
            ].
	super setName: name.
    ]

    getArea[
        ^((2 * Float pi * bigRadius) * (2 * Float pi * smallRadius)) roundTo: 0.01
    ]

    getVolume[
        ^((Float pi * (smallRadius raisedTo: 2)) * (2 * Float pi * bigRadius)) roundTo: 0.01
    ]

    getInfo[
	| topLine bottomLine |
	topLine:= 'Torus ', super getName, ',', '  Small Radius=', smallRadius asString, ',', ' Big Radius=', bigRadius asString.
	bottomLine:= 'Surface Area: ', self getArea asString, ', Volume: ', self getVolume asString.
	Transcript show: topLine.
	Transcript cr tab.
	Transcript show: bottomLine.
	Transcript cr.	
    ]
]

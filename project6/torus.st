Shape subclass: Torus[
    | smallRadius bigRadius type |

    init [
        smallRadius:= 0 asFloat.
        bigRadius:= 0 asFloat.
	type:= 'torus'.
        ^ super init
    ]

    newTorus: name radiusOne: radiusOneValue radiusTwo: radiusTwoValue[
	radiusOneValue > radiusTwoValue
        ifTrue:[
            bigRadius:= radiusOneValue asNumber asFloat.
            smallRadius:= radiusTwoValue asNumber asFloat.
            ]
        ifFalse:[
            bigRadius:= radiusTwoValue asNumber asFloat.
            smallRadius:= radiusOneValue asNumber asFloat.
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

    test: operator conditionOne: conditionOneValue conditionTwo: conditionTwoValue[
	    |leftValue rightValue|
    
	    conditionOneValue = 'area'
	    ifTrue:[
	    	leftValue:= self getArea.
	    	rightValue:= conditionTwoValue asNumber asFloat.
	    ].
	    conditionOneValue = 'volume'
	    ifTrue:[
	    	leftValue:= self getVolume.
	    	rightValue:= conditionTwoValue asNumber asFloat.
	    ].
	    conditionOneValue = 'type'
	    ifTrue:[
	    	leftValue:= type.
	    	rightValue:= conditionTwoValue.
	    ].
    
	    operator = '=='
	    ifTrue:[ ^leftValue = rightValue].
	    operator = '!='
	    ifTrue:[ ^leftValue ~= rightValue].
	    operator = '>'
	    ifTrue:[ ^leftValue  > rightValue].
	    operator = '<'
	    ifTrue:[ ^leftValue < rightValue].
	    operator = '>='
	    ifTrue:[ ^leftValue >= rightValue].
	    operator = '<='
	    ifTrue:[ ^leftValue <= rightValue].
	    ^false
    ]
]

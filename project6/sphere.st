Shape subclass: Sphere[
    | radius type |

    init [
        radius := 0 asFloat.
	type:= 'sphere'.
        ^ super init
    ]

    newSphere: name radius: radiusValue[
        self setRadius: radiusValue.
        super setName: name.
    ]

    setRadius: value[
        radius := value asNumber asFloat.
    ]

    getRadius[
        ^radius
    ]

    getArea[
        ^(Float pi * 4 * (radius raisedTo: 2)) roundTo:0.01
    ]

    getVolume[
	^((4/3 asFloat) * Float pi * (radius raisedTo: 3)) roundTo:0.01	
    ]

    getInfo[
	| topLine bottomLine |
	topLine:= 'Sphere: ', super getName, ',', '  Radius=', radius asString.
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

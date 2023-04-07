Shape subclass: Cylinder[
    | radius height type |

    init [
        radius:= 0 asFloat.
        height:= 0 asFloat.
	type:= 'cylinder'.
        ^ super init
    ]

    newCylinder: name radius: radiusValue height: heightValue[
        radius:= radiusValue asNumber asFloat.
        height:= heightValue asNumber asFloat.
        super setName: name.
    ]

    getArea[
        ^((2.0 * Float pi * radius * height) + (2.0 * Float pi * (radius raisedTo: 2))) roundTo:0.01
    ]

    getVolume[
        ^(Float pi * (radius raisedTo: 2) * height) roundTo: 0.01
    ]

    getInfo[
	|topLine bottomLine |
	topLine:= 'Cylinder: ', super getName, ',', '  Radius=', radius asString, ',', ' Height=', height asString.
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

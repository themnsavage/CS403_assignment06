Shape subclass: Box[
    | length width height  type |

    init [
        length:= 0 asFloat.
        width:= 0 asFloat.
        height:= 0 asFloat.
	type:= 'box'.
        ^ super init
    ]

    newBox: name length: lengthValue width: widthValue height: heightValue[
        length:= lengthValue asNumber asFloat.
        width:= widthValue asNumber asFloat.
        height:= heightValue asNumber asFloat.
        super setName: name.
    ]

    getArea[
        ^(2 * ((length * width) + (length * height) + (width * height))) roundTo:0.01
    ]

    getVolume[
        ^(length*width*height) roundTo: 0.01
    ]

    getInfo[
	| topLine bottomLine |
	topLine:= 'Box: ', super getName, ',', '  Length=', length asString, ', Width=', width asString, ', Height=', height asString.
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

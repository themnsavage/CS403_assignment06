Shape subclass: Box[
    | length width height |

    init [
        length:= 0 asFloat.
        width:= 0 asFloat.
        height:= 0 asFloat.
        ^ super init
    ]

    newBox: name length: lengthValue width: widthValue height: heightValue[
        length:= lengthValue asFloat.
        width:= widthValue asFloat.
        height:= heightValue asFloat.
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
]

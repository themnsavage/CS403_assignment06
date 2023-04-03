Shape subclass: Sphere[
    | radius |

    init [
        radius := 0 asFloat.
        ^ super init
    ]

    newSphere: name radius: radiusValue[
        self setRadius: radiusValue.
        super setName: name.
    ]

    setRadius: value[
        radius := value asFloat.
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
	|topLine bottomLine info|
	topLine:= 'Sphere: ', super getName, ',', '  Radius= ', radius asString.
	bottomLine:= 'Surface Area: ', self getArea asString, ', Volume: ', self getVolume asString.
	Transcript show: topLine.
	Transcript cr tab.
	Transcript show: bottomLine.
	Transcript cr.	
    ]
]

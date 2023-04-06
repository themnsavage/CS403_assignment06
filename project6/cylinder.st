Shape subclass: Cylinder[
    | radius height |

    init [
        radius:= 0 asFloat.
        height:= 0 asFloat.
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
]

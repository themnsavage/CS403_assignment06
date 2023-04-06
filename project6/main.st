Object subclass: Manager[
	| fileName arrayOfShapes shapeCount |
	
	Manager class >> new [
		| r |
		r:= super new.
		r init.
		^r
	]

	init[
		fileName:= Smalltalk getArgv:1.
		arrayOfShapes:= nil.
		shapeCount:= 0.
	]

	setShapeCount[
		| ios line |
		ios:= FileStream open: fileName mode:#read
	      	ifFail:[
				Transcript show: 'Error was not able to open file.'.
				Transcript cr.
				^false
		       ].
		
		shapeCount := 1.
		line:= ios nextLine.
		[ios atEnd] whileFalse:[
			line := ios nextLine.
			shapeCount :=  shapeCount + 1.
		].
		
		ios close.
		^true
	]

	createShape: type shapeName: name shapeParameters: a [
		type = 'sphere' 
		ifTrue:[
			|sphere radiusValue|
			radiusValue := a at: 1.
			sphere:= Sphere new.
			sphere newSphere: name radius: radiusValue.
			^sphere
		].

		type = 'box'
		ifTrue:[
			|box lengthValue widthValue heightValue|
			lengthValue:= a at: 1.
			widthValue:= a at: 2.
			heightValue:= a at: 3.
			box:= Box new.
			box newBox: name length: lengthValue width: widthValue height: heightValue.
			^box
		].

		type = 'cylinder'
		ifTrue:[
			|cylinder radiusValue heightValue|
			radiusValue:= a at: 1.
			heightValue:= a at: 2.
			cylinder:= Cylinder new.
			cylinder newCylinder: name radius: radiusValue height: heightValue.
			^cylinder

		].

		type = 'torus'
		ifTrue:[
			|torus radiusOneValue radiusTwoValue|
			radiusOneValue:= a at: 1.
			radiusTwoValue:= a at: 2.
			torus:= Torus new.
			torus newTorus: name radiusOne: radiusOneValue radiusTwo: radiusTwoValue.
			^torus 
		].

		^nil.
	]
	
	getParameters: anArray[
		|parameters param count|
		count:= 1.
		parameters:= Array new: 3.
		1 to: anArray size do:[:index|
			index > 2
			ifTrue:[
				param:= anArray at: index.
				parameters at: count put: param.
				count:= count+1.	
			].
		].
		
		^parameters
	]

	setArrayOfShapes[
		|ios newShape line a count type name parameters|
		arrayOfShapes:= Array new: shapeCount.
		count:= 1.

		ios:= FileStream open: fileName mode:#read
		ifFail:[
			Transcript show: 'Error was not able to open file.'.
			Transcript cr.
			^false
		].
		
		line:= ios nextLine.
		a:= line substrings: ' '.
		name:= a at: 1.
		type:= a at: 2.
		parameters:= self getParameters: a.
		newShape:= self createShape: type shapeName: name shapeParameters: parameters.		
		arrayOfShapes at: count put: newShape.		
		count:= count+1.	
	
		[ios atEnd] whileFalse:
		[
			line:= ios nextLine.
			a:= line substrings: ' '.
			name:= a at: 1.
			type:= a at: 2.
			parameters:= self getParameters: a.
			newShape:= self createShape: type shapeName: name shapeParameters: parameters.
			arrayOfShapes at: count put: newShape.
			count:= count+1.
		].
			
		ios close.
		^true
	]

	printAllShapes[
		arrayOfShapes do:[:eachShape| eachShape getInfo].
	]
].

manager:= Manager new.
manager setShapeCount.
manager setArrayOfShapes.
manager printAllShapes.
"
a:= Array new: 4.
a at: 1 put: cube.
a at: 2 put: globe.
a at: 3 put: cyl.
a at: 4 put: donut.
a do:[:eachObject | eachObject getInfo].
"


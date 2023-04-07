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

	printCommand: array[
		array do:[:eachShape| eachShape getInfo].
	]
	
	countCommand: array[
		|count|
		count:= array size.
		
		Transcript show: 'There are ', count asString, ' shapes.'.
		Transcript cr.
	]
	
	getAreaArray: array[
		|areaArray count index|
		count:= array size.
		areaArray:= Array new: count.
		
		index:= 1.
		array do:[:shape|
			areaArray at: index put: shape getArea.
			index:= index + 1.
		].
		
		^areaArray
	]

	getVolumeArray: array[
		|volumeArray count index|
		count:= array size.
		volumeArray:= Array new: count.
		
		index:= 1.
		array do:[:shape|
			volumeArray at: index put: shape getVolume.
			index:= index + 1.
		].

		^volumeArray
	]

	minCommand: array[
		|areaArray volumeArray minArea minVolume|
		
		areaArray:= self getAreaArray: array.
		volumeArray:= self getVolumeArray: array.
		
		minArea:= areaArray at: 1.
		minVolume:= volumeArray at: 1.
		
		areaArray do:[:area|
			minArea:= minArea min: area.
		].

		volumeArray do:[:volume|
			minVolume:= minVolume min: volume.
		].
		
		Transcript show: 'min(Surface Area)= ', minArea asString.
		Transcript cr.
		Transcript show: 'min(Volume)= ', minVolume asString.
		Transcript cr.
	]

	maxCommand: array[
		|areaArray volumeArray maxArea maxVolume|
		
		areaArray:= self getAreaArray: array.
		volumeArray:= self getVolumeArray: array.
		
		maxArea:= areaArray at: 1.
		maxVolume:= volumeArray at: 1.

		areaArray do:[:area|
			maxArea:= maxArea max: area.
		].
		
		volumeArray do:[:volume|
			maxVolume:= maxVolume max: volume.
		].

		Transcript show: 'max(Surface Area)= ', maxArea asString.
		Transcript cr.
		Transcript show: 'max(Volume)= ', maxVolume asString.
		Transcript cr.
	]
	
	totalCommand: array[
		|areaArray volumeArray totalArea totalVolume|
		areaArray:= self getAreaArray: array.
		volumeArray:= self getVolumeArray: array.
		
		totalArea:= 0.
		totalVolume:= 0.
		
		areaArray do:[:area|
			totalArea:= totalArea + area.
		].

		volumeArray do:[:volume|
			totalVolume:= totalVolume + volume.
		].

		Transcript show: 'total(Surface Area)= ', totalArea asString.
		Transcript cr.
		Transcript show: 'total(Volume)= ', totalVolume asString.
		Transcript cr. 
	]

	averageCommand: array[
		|areaArray volumeArray avgArea avgVolume count|
		count:= array size.
		areaArray:= self getAreaArray: array.
		volumeArray:= self getVolumeArray: array.
		
		avgArea:= 0.
		areaArray do:[:area|
			avgArea:= avgArea + area.
		].
		avgArea:= avgArea // count.

		avgVolume:= 0.
		volumeArray do:[:volume|
			avgVolume:= avgVolume + volume.
		].
		avgVolume:= avgVolume // count.

		Transcript show: 'avg(Surface Area)= ', avgArea asString.
		Transcript cr.
		Transcript show: 'avg(Volume)= ', avgVolume asString.
		Transcript cr.
	]

	stringIsNumber: string[
		|values isInValues output|
		values:= #($0 $1 $2 $3 $4 $5 $6 $7 $8 $9 $.).
		isInValues:= [:x| 
			output:= values includes: x.
			^output
		].
		string do:[:char|
			output:= isInValues value: char.
			output
			ifFalse:[^false].
		].
		^true
	]

	isValidCondition: condition[
		|array left operator right leftArray operatorArray include errormsg|
		array:= condition substrings: ' '.
			
		leftArray:= #('area' 'volume' 'type').
		operatorArray:= #('==' '!=' '<' '>' '<=' '>=').
		
		array size >= 1
		ifFalse:[
			errormsg:= ': invalid column.'.
			errormsg displayNl.
			^false
		].
			
		left:= array at: 1.
		include:= leftArray includes: left.
		include = true
		ifFalse:[
			errormsg:= left, ':  invalid column.'.
			errormsg displayNl.
			^false
		].
				
		array size >= 2
		ifFalse:[
			errormsg:= ': invalid operator.'.
			errormsg displayNl.
			^false.
		].

		operator:= array at: 2.
		include:= operatorArray includes: operator.
		include = true
		ifFalse:[
			errormsg:= operator, ': invalid operator.'.
			errormsg displayNl.
			^false
		].
		
		array size == 3
		ifFalse:[
			^false
		].	
	
		right:= array at: 3.	
		left = 'type'
		ifTrue:[^true].

		include:= self stringIsNumber: right.
		^include
	]
	
	getCommand[
		|command|
		'Enter a command: ' display.
		command:= stdin nextLine.
		^command
	]
	
	getTestCondition: count[
		|condition instruction valid|
		valid:= false.
		[valid] whileFalse:[
			instruction:= 'Enter test condition #', count asString, ': '.
			instruction display.

			condition:= stdin nextLine.
			valid:= self isValidCondition: condition.
		].
		
		^condition substrings: ' '
	]	

].

manager:= Manager new.
testCondition:= manager getTestCondition: 4.
testCondition printNl.
"
manager setShapeCount.
manager setArrayOfShapes.
manager printAllShapes.
"

"
sphere:= Sphere new.
sphere newSphere: 'globe' radius: '1.23'.
sphere getInfo.

value:= sphere test:'>=' conditionOne: 'volume' conditionTwo: '6.79'.
value printNl.
"
 

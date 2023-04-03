cube:= Box new.
cube newBox: 'Box' length: 1 width:1 height:1.
cube getInfo.

globe:= Sphere new.
globe newSphere: 'Globe' radius: 1.
globe getInfo.

cyl:= Cylinder new.
cyl newCylinder: 'cyl1' radius: 1 height: 1.
cyl getInfo.

donut:= Torus new.
donut newTorus: 'donut' radiusOne: 3 radiusTwo: 7.0.
donut getInfo.

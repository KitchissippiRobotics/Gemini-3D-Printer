// *****************************************************************************
// ( )/ )(_  _)(_  _)___(  _ \(  _  )(  _ \(  _  )(_  _)(_  _)/ __)/ __)
//  )  (  _)(_   )( (___))   / )(_)(  ) _ < )(_)(   )(   _)(_( (__ \__ \
// (_)\_)(____) (__)    (_)\_)(_____)(____/(_____) (__) (____)\___)(___/
// *****************************************************************************
// Written by bcantin@kitchissippi-robotics.com
// Copyright (c) 2015 Kitchissippi Robotics
// -----------------------------------------------------------------------------
// Hotend-Assembly Component
// *****************************************************************************

include <Dimensions.scad>

// Default Usage:	
// Part_HA_CarriageBase();

// Determine if MultiPartMode is enabled - if not, render the part automatically
// and enable support material (if it is defined)

if (MultiPartMode == undef) {
	MultiPartMode = false;
	EnableSupport = true;
	
	Part_HA_CarriageBase();
} else {
	EnableSupport = false;
}

module _topStrut() {

/*
	D'oh ... this diagram is upside down... no worries
	
	The purpose is to create a shape which can be rotated into place rather than create
	the shape at an angle to start with.
	This allows for more control over and detail over the initial shape.
	Bear with me for a basic geometry refresher...

			B
		  /	|
  		 /	|
	  c /	|
	   /	|	b
	  /		|	
	 /		|
	/_____90|
	A	a	C
	
	A = tan(a/b)					{ solve for a }
	B = tan(b/a)					{ solve for b }
	C = 90
	
	A + B + C = 180					{ all three angles total 180 degrees }
	
	a = rpXC_BeltMount_BoltSpacing /2
	b = rpXC_CarriageMount_LowerPointSpacing
	c = sqrt(a * a + b * b)			{ solve for length of c, to determine shape size}
		
*/
	
	a = rpXC_BeltMount_BoltSpacing /2;
	b = rpXC_CarriageMount_LowerPointSpacing;
	c = sqrt(a * a + b * b);
	
	A = tan(a/b);
	B = tan(b/a);
	
	rotate([0,0,A])
		cube ([10, c, rpXC_CarriageMount_BaseHeight]);
	
	// top left post location
	translate([	-rpXC_CarriageMount_BaseHeight,
				rpXC_BeltMount_BoltSpacing /2,
				0])
	_PostBase(5, 10, 2);
	
	// bottom post location	
	translate([	rpXC_CarriageMount_LowerPointSpacing +1,
				0,
				0])
		_PostBase(5, 10, 2);
}

module Part_HA_CarriageBase() {
	_topStrut();
	
	*union() {
		_HA_Strut();
		mirror([0,1,0]) _HA_Strut();
	}
	


}

module _HA_Strut() {
	difference() {
		union() { 											// union()
			hull() { 											// hull()
			// top left post location
			translate([	-rpXC_CarriageMount_BaseHeight,
						rpXC_BeltMount_BoltSpacing /2,
						0])
				_PostBase(5, 10, 2);
	
			// bottom post location	
			translate([	rpXC_CarriageMount_LowerPointSpacing +1,
						0,
						0])
				_PostBase(5, 10, 2);
				
			*translate([	-rpXC_CarriageMount_BaseHeight,
					rpXC_BeltMount_BoltSpacing /2 + rpXC_BeltMount_BoltHolderDiameter /4,
					0])
			cylinder( 	h =5,
							d = 3);
						
			*translate([	hwHA_Hotend_VerticalOffset + 4.67 + 4.67 /2,
						rpXC_BeltMount_BoltSpacing /2 + rpXC_BeltMount_BoltHolderDiameter /4,
						0])
					cylinder( 	h =12,
								d = 3);
			}
			
			hull() {											// hull()
			translate([	hwHA_Hotend_VerticalOffset + 4.67,
						0,
						0])
				cube([4.67, rpXC_BeltMount_BoltSpacing /2 + rpXC_BeltMount_BoltHolderDiameter /2 - 4.67, 12]);
				
			translate([	hwHA_Hotend_VerticalOffset + 4.67 + 4.67 /2,
						rpXC_BeltMount_BoltSpacing /2 + 4.67 /2,
						0])
					cylinder( 	h =12,
								d = 4.67);
			}
			
			*hull() {
			
			translate([	-rpXC_CarriageMount_BaseHeight,
						rpXC_BeltMount_BoltSpacing /2 + rpXC_BeltMount_BoltHolderDiameter /4,
						0])
				cylinder( 	h =5,
								d = 3);
						
			translate([	hwHA_Hotend_VerticalOffset + 4.67 + 4.67 /2,
						rpXC_BeltMount_BoltSpacing /2 + rpXC_BeltMount_BoltHolderDiameter /4,
						0])
					cylinder( 	h =12,
								d = 3);
			}
		}													// union()
		
		// hotend upper
		translate([hwHA_Hotend_VerticalOffset,
					hwHA_Hotend_Spacing /2,
					hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing])
		rotate([0,90,0])
			cylinder(h = 4.67,
					 d = 16.2);
		// hotend groovemount
		translate([hwHA_Hotend_VerticalOffset + 4.67,
					hwHA_Hotend_Spacing /2,
					hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing])
		rotate([0,90,0])
			cylinder(h = 4.67,
					 d = 12.2);
				
		// hotend lower
		translate([hwHA_Hotend_VerticalOffset + 2 * 4.67,
					hwHA_Hotend_Spacing /2,
					hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing])
		rotate([0,90,0])
			cylinder(h = 40 - 2 * 4.67,
					 d = 25);
	}
	
	// hotend spacing
	*translate([hwHA_Hotend_VerticalOffset,
				hwHA_Hotend_Spacing /2,
				hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing])
	rotate([0,90,0])
		cylinder(h = 40,
				 d = 16);
	

}

// -----------------------------------------------------------------------------
module _PostBase(baseHeight, baseDiameter, baseOffset) {
	$fn = gcFacetMedium;
	
	cylinder(		h = baseHeight,
					d = baseDiameter - baseOffset /2);
				
	translate([0,0,0])
		cylinder(	h = baseHeight - baseOffset,
					d = baseDiameter);
}
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

include <XC_Common.scad>

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

// -----------------------------------------------------------------------------
// Put it all together and carve out the hardware clearances
// -----------------------------------------------------------------------------

module Part_HA_CarriageBase() {
	difference() {
		union() {	// combine the sub components that make up the parts
			
			_HACB_BoltBases(BBStyle_Taper);
			
			*difference() {
				translate([0, - lowerBoltOffset /2, 0])
				scale([0.87,1 + 0.00,1])
				linear_extrude(height = 4.33, scale=1)
					_XCCB_OutlineCase(3.5);
				
				union() {
				translate([0, - lowerBoltOffset /2, -0.1])
				scale([0.80, 0.86, 1])	
					linear_extrude(height = 2.2, scale=1)
						_XCCB_OutlineCase();
				translate([0, - lowerBoltOffset /2, 2])
				scale([0.82, 0.92, 1])	
					linear_extrude(height = 4, scale=1)
						_XCCB_OutlineCase();
				}
			}
		}
		
		
		
		// carve things out of the shape
	}
}

// -----------------------------------------------------------------------------
// Just Draw the bolt bases
// -----------------------------------------------------------------------------

module _HACB_BoltBases(baseBBStyle) {
	

	// top left assembly bolt mount base
	translate([-boltSpacing/2, 0, 0]) {
		_BoltBase(boltDiameter - rpDefaultBevel *2, _baseThickness - rpDefaultBevel, BBStyle_Round);
	}
	
	// top right assembly bolt mount base
	translate([boltSpacing/2, 0, 0]) {
		_BoltBase(boltDiameter - rpDefaultBevel * 2, _baseThickness - rpDefaultBevel, BBStyle_Round);
	}
	
	// bottom center assembly bolt mount base
	translate([0, -lowerBoltOffset, 0]) {
		_BoltBase(boltDiameter - rpDefaultBevel * 2, _baseThickness - rpDefaultBevel, BBStyle_Round);
	}
	
}

// *****************************************************************************
// Old code - Beware, here be dragons
// *****************************************************************************

module _strutBase() {
	a = rpXC_BeltMount_BoltSpacing/2;
	b = rpXC_CarriageMount_LowerClearance + rpXC_CarriageMount_BoltHolderDiameter + rpXC_BeltMount_BoltHolderWidth /2 -1;
	c = sqrt(a * a + b * b) ;
	
	difference() {
		hull() {
			_PostBase(rpXC_BeltMount_BoltHolderWidth, 10, 2);

			translate([-5,0,0])
					cube ([10, c, rpXC_BeltMount_BoltHolderWidth], center = false);

			translate([0,c,0])	
				_PostBase(rpXC_BeltMount_BoltHolderWidth, 10, 2);
		}
		
		translate([-3,0,3])
					#cube ([6, c, rpXC_BeltMount_BoltHolderWidth - 3], center = false);
		
	}
	
	hull() _PostBase(rpXC_BeltMount_BoltHolderWidth, 10, 2);
	hull() translate([0,c,0])	
				_PostBase(rpXC_BeltMount_BoltHolderWidth, 10, 2);
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
	
	A = atan(a/b)					{ solve for a }
	B = atan(b/a)					{ solve for b }
	C = 90
	
	A + B + C = 180					{ all three angles total 180 degrees }
	
	a = rpXC_BeltMount_BoltSpacing /2
	b = rpXC_CarriageMount_LowerPointSpacing
	c = sqrt(a * a + b * b)			{ solve for length of c, to determine shape size}
		
*/
	
	a = rpXC_BeltMount_BoltSpacing/2;
	b = rpXC_CarriageMount_LowerClearance + rpXC_CarriageMount_BoltHolderDiameter + rpXC_BeltMount_BoltHolderWidth /2 -1;
	c = sqrt(a * a + b * b) ;
	
	A = atan(a/b);
	B = atan(b/a);


	translate([rpXC_CarriageMount_LowerPointSpacing,0,0])
	rotate([0,0,B])
		_strutBase();
	translate([rpXC_CarriageMount_LowerPointSpacing,0,0])
	rotate([0,0,180 - B])
		_strutBase();	
	
	
}



module _HA_Strut() {
	difference() {
		union() { 
			_topStrut();											// union()
			*hull() { 											// hull()
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
			
			*hull() {											// hull()
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
			
			hull() {
			
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
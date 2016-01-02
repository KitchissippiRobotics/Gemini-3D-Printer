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

//hwHA_Hotend_VerticalOffset = 3;

// -----------------------------------------------------------------------------
// Put it all together and carve out the hardware clearances
// -----------------------------------------------------------------------------

module CarveOut() {
	translate([0,-10,0])
		rotate([0,0,-90])
		union() {
		translate([hwHA_Hotend_VerticalOffset,
					hwHA_Hotend_Spacing /2,
					hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing])
		rotate([0,90,0])
			cylinder(h = 5,
					 d = 17);
		// hotend groovemount
		translate([hwHA_Hotend_VerticalOffset + 4.67,
					hwHA_Hotend_Spacing /2,
					hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing])
		rotate([0,90,0])
			cylinder(h = 4.67,
					 d = 13);
			
		// hotend lower
		translate([hwHA_Hotend_VerticalOffset + 2 * 4.67,
					hwHA_Hotend_Spacing /2,
					hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing])
		rotate([0,90,0])
			cylinder(h = 40 - 2 * 4.67,
					 d = 20);
				 
		rotate([0,-90,0])
			_HA_CB_BoltCarveouts();
			
			#translate([10, -25, -0.1])
		rotate([0,0,15])
				cylinder(h = 8, d1 = 8, d2 = 6.5, $fn = 6);
		}
}

module Part_HA_CarriageBase() {
	difference() {
		union() {	// combine the sub components that make up the parts
			
			_HACB_BoltBases(BBStyle_Taper);
			_HACB_HotendMount();
			//_XCCB_BoltSkeleton(BBStyle_Round);
			
		}
		
		// hotend upper
		
		translate([0,0,0]) {
			CarveOut();
			mirror([1,0,0]) CarveOut();
		}
		
		#translate([hwHA_Hotend_Spacing /2, 0, hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing])
		rotate([90,0,0])
		cylinder(h = 20, d = 4.6);
		
		#translate([-hwHA_Hotend_Spacing /2, 0, hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing])
		rotate([90,0,0])
		cylinder(h = 20, d = 4.6);
		

		
		
		// carve things out of the shape
	}
}

// -----------------------------------------------------------------------------

module _HACB_BaseLeft() {

	difference() {
		union() {
			hull() { 
	
				translate([8, -lowerBoltOffset/2 + 1, 0])
					_BoltBase(4, 4, BBStyle_Round);
		
				translate([boltSpacing/2, 0, 0])
					_BoltBase(boltDiameter, 4, BBStyle_Round);
	
				// m3 bolt mount
				translate([15, -lowerBoltOffset/2 +1, 0])
					_BoltBase(4, 3, BBStyle_Round);
			}

		
		
			hull() {
		
				translate([-boltSpacing/2, -lowerBoltOffset, 0]) 
					_BoltBase(boltDiameter, 4, BBStyle_Round);
			
				translate([-25, -lowerBoltOffset/2 - 3.5, 0])
					_BoltBase(6, 5, BBStyle_Round);
			}
		
		
			hull() {
				translate([25, -lowerBoltOffset/2 - 3.5, 0])
					_BoltBase(6, 13.5, BBStyle_Round);
		
				translate([18, -lowerBoltOffset/2 +1, 0])
					_BoltBase(8, 13.5, BBStyle_Round);
			}
		
			hull() {
				translate([18, -lowerBoltOffset/2 + 1, 0])
					_BoltBase(8, 13.5, BBStyle_Round);
		
				translate([0, -lowerBoltOffset/2 + 1, 0])
					_BoltBase(8, 13.5, BBStyle_Round);
			}
		
		
		
	}
	
	#translate([25, -lowerBoltOffset/2 - 3.0, -0.1])
		rotate([0,0,15])
				cylinder(h = 8, d1 = 8, d2 = 6.5, $fn = 6);
	
	// m3 bolt mount
			translate([25, -lowerBoltOffset/2 - 3.0, 9])
				cylinder(h = 5, d = 3.2);
				
			
	
	}
				
	// draw a cube to fit in the slots
	*translate([0, -10, 0])
	rotate([90,0,0])
	cube([25, 15, 10]);
}

// -----------------------------------------------------------------------------
// Just Draw the bolt bases
// -----------------------------------------------------------------------------

module _HACB_BoltBases(baseBBStyle) {

	
	mirror([1,0,0]) _HACB_BaseLeft();
	_HACB_BaseLeft();
	
	mirror([1,0,0]) _HACB_HotendMount();
	_HACB_HotendMount();
	

}

module _HACB_HotendMount() {
	// draw a cube to fit in the slots
	*translate([0, -10, 0])
	rotate([90,0,0])
	cube([25, 15, 10]);
}

// -----------------------------------------------------------------------------
// WARNING: Be very careful modifying this - the values are from the original 
// 			version which is all sorts of a different orientation
// -----------------------------------------------------------------------------

module _HA_CB_BoltCarveouts() {

	*translate([0 - (hwLR_Carriage_BoltLength / 2), 0 - (hwLR_Carriage_BoltWidth / 2), 0 - hwLR_Carriage_BoltDepth])
		Carve_hw_Bolt_AllenHead(rpXC_CarriageMount_BoltSize, rpXC_CarriageMount_BoltLength, 20);

	*translate([0 + (hwLR_Carriage_BoltLength / 2), 0 - (hwLR_Carriage_BoltWidth / 2),  0 - hwLR_Carriage_BoltDepth])
		Carve_hw_Bolt_AllenHead(rpXC_CarriageMount_BoltSize, rpXC_CarriageMount_BoltLength, 20);

	// [rpXC_BeltMount_BoltDepth - rpXC_BeltMount_BaseOffset, 0 - (rpXC_BeltMount_BoltSpacing / 2), rpXC_BeltMount_BoltOffset]
	#translate([rpXC_BeltMount_BoltDepth - rpXC_BeltMount_BaseOffset,
				0 - (rpXC_BeltMount_BoltSpacing / 2),
				rpXC_BeltMount_BoltOffset])
	rotate([0,-90,0])
		Carve_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, rpXC_BeltMount_BoltLength);
			
	*translate([rpXC_BeltMount_BoltDepth - rpXC_BeltMount_BaseOffset,
				0,
				-rpXC_CarriageMount_LowerPointSpacing])
		rotate([0,-90,0])
			Carve_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, rpXC_BeltMount_BoltLength);
			
	*translate([-boltSpacing/2, -lowerBoltOffset, 0])
		Carve_hw_Bolt_AllenHead(rpXC_CarriageMount_BoltSize, rpXC_CarriageMount_BoltLength, 20);	
		
	// [rpXC_BeltMount_BoltDepth - rpXC_BeltMount_BaseOffset, 0 - (rpXC_BeltMount_BoltSpacing / 2), rpXC_BeltMount_BoltOffset]
	#translate([rpXC_BeltMount_BoltDepth - rpXC_BeltMount_BaseOffset,
				0 - (rpXC_BeltMount_BoltSpacing / 2),
				-lowerBoltOffset + 10])
	rotate([0,-90,0])
		Carve_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, rpXC_BeltMount_BoltLength);
}

// -----------------------------------------------------------------------------
// Just Draw the skeleton frame between the bolt bases
// -----------------------------------------------------------------------------

/*module _XCCB_BoltSkeleton(baseBBStyle) {

		*hull() {
			translate([boltSpacing/2, 0, 0])
				_BoltBase(boltDiameter /2, _baseThickness - rpDefaultBevel, baseBBStyle);
				
			
			translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset + hwMicroSwitch_HoleSpacing /2, 0])
				_BoltBase(boltDiameter /2, _baseThickness - rpDefaultBevel, baseBBStyle);
		}
		
		*hull() {
			translate([0, -lowerBoltOffset, 0])
				_BoltBase(boltDiameter /3, _baseThickness - rpDefaultBevel, baseBBStyle);
				
			translate([switchXOffset + 2, -lowerBoltOffset + 5, 0])
				_BoltBase(boltDiameter /3, _baseThickness - rpDefaultBevel, baseBBStyle);
		}
		
		*hull() {
			translate([0, -lowerBoltOffset, 0])
				_BoltBase(boltDiameter /3, _baseThickness - rpDefaultBevel, baseBBStyle);
				
			translate([-switchXOffset - 2, -lowerBoltOffset + 5, 0])
				_BoltBase(boltDiameter /3, _baseThickness - rpDefaultBevel, baseBBStyle);
		}
		
		hull() {
			translate([boltSpacing/2, 0, 0])
			_BoltBase(boltDiameter /2, _baseThickness - rpDefaultBevel, baseBBStyle);
			translate([0, -lowerBoltOffset, 0])
			_BoltBase(boltDiameter /2, _baseThickness - rpDefaultBevel, baseBBStyle);
		}
		
		hull() {
			translate([-boltSpacing/2, 0, 0])
			_BoltBase(boltDiameter /2, _baseThickness - rpDefaultBevel, baseBBStyle);
			translate([0, -lowerBoltOffset, 0])
			_BoltBase(boltDiameter /2, _baseThickness - rpDefaultBevel, baseBBStyle);
		}
		
		*hull() {
		// top left assembly bolt mount base
		translate([-boltSpacing/2, 0, 0])
			_BoltBase(boltDiameter /2, _baseThickness - rpDefaultBevel, baseBBStyle);
			
		// top right assembly bolt mount base
		translate([boltSpacing/2, 0, 0])
			_BoltBase(boltDiameter /2, _baseThickness - rpDefaultBevel, baseBBStyle);
		}

	
}*/

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
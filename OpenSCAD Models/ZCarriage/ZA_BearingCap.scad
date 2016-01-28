// *****************************************************************************
// ( )/ )(_  _)(_  _)___(  _ \(  _  )(  _ \(  _  )(_  _)(_  _)/ __)/ __)
//  )  (  _)(_   )( (___))   / )(_)(  ) _ < )(_)(   )(   _)(_( (__ \__ \
// (_)\_)(____) (__)    (_)\_)(_____)(____/(_____) (__) (____)\___)(___/
// *****************************************************************************
// Written by bcantin@kitchissippi-robotics.com
// Copyright (c) 2016 Kitchissippi Robotics
// -----------------------------------------------------------------------------
// ZA_BearingCap.scad
// Part No. 
// Generates ZA_BearingCap.stl
// *****************************************************************************

include <../Dimensions.scad>

_drawHardware = false;


//$fn = 200;
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Default Usage:	
// Part_ZA_BearingCap();
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// Determine if MultiPartMode is enabled - if not, render the part automatically
// and enable support material (if it is defined)

if (MultiPartMode == undef) {
	MultiPartMode = false;
	EnableSupport = true;
	
	rotate([0, 90, 0])
	Part_ZA_BearingCap();
} else {
	EnableSupport = false;
}

// -----------------------------------------------------------------------------
// Put it all together and carve out the hardware clearances
// -----------------------------------------------------------------------------

module Part_ZA_BearingCap() {
	difference() {
		union() {
			_BearingCapHalf();
			
			mirror([0,1,0])
				_BearingCapHalf();
		}
		
		// carve out rods
		translate([0, -hwZA_RodYSpacing /2, -1])
		cylinder(h = hwZA_RodLength, d = hwZA_RodDiameter + 2);
	
		translate([0, hwZA_RodYSpacing /2, -1])
		cylinder(h = hwZA_RodLength, d = hwZA_RodDiameter + 2);
		
		translate([0, -hwZA_RodYSpacing /2, 3])
			cylinder(h = hwZA_BearingLength +1, d = hwZA_BearingDiameter + 0.6);
		
		translate([0, hwZA_RodYSpacing /2, 3])
			cylinder(h = hwZA_BearingLength +1, d = hwZA_BearingDiameter + 0.6);
		
		translate([0,-50, -1])
		cube([60,100,100]);
		
		// rear mounting bolts
		translate([14.5, -35, 8.6])
		rotate([0,-90,0])
			Carve_hw_Bolt_AllenHead(hwM3_Bolt_AllenHeadSize, 20, 20);
			
		translate([14.5, -35, 34.1])
		rotate([0,-90,0])
			Carve_hw_Bolt_AllenHead(hwM3_Bolt_AllenHeadSize, 20, 20);
			
		// middle mounting bolts
		translate([12, 0, 8.6])
		rotate([0,-90,0])
			Carve_hw_Bolt_AllenHead(hwM3_Bolt_AllenHeadSize, 20, 20);
			
		translate([12, 0, 34.1])
		rotate([0,-90,0])
			Carve_hw_Bolt_AllenHead(hwM3_Bolt_AllenHeadSize, 20, 20);
			
		// front mounting bolts
		translate([14.5, 35, 8.6])
		rotate([0,-90,0])
			Carve_hw_Bolt_AllenHead(hwM3_Bolt_AllenHeadSize, 20, 20);
			
		translate([14.5, 35, 34.1])
		rotate([0,-90,0])
			Carve_hw_Bolt_AllenHead(hwM3_Bolt_AllenHeadSize, 20, 20);
		
	}
}

module _BearingCarveOut() {
	// carve out rear bearing
	cylinder(h = hwZA_BearingLength +1, d = hwZA_BearingDiameter + 0.6);
	
	hull() {
		cylinder(h = hwZA_BearingLength +1, d = hwZA_BearingDiameter + 0.4);
		cylinder(h = hwZA_BearingLength + 4.75, d = hwZA_BearingDiameter + 0.6 - 4);
	}
	
	cylinder(h = hwZA_BearingLength + 6, d = hwZA_BearingDiameter + 0.6 - 4);
}

module _BearingCapHalf() {
	
	hull() {
		// tapered larger section around bearings
		translate([0, -hwZA_RodYSpacing /2, 2.5])
			cylinder(h = hwZA_BearingLength +3 , d = hwZA_BearingDiameter + 6);
		
		translate([0, -hwZA_RodYSpacing /2, 0])
			cylinder(h = hwZA_BearingLength + 8 , d = hwZA_BearingDiameter + 4);
		
		// tapered smaller section at ends
		translate([0, -hwZA_RodYSpacing /2 - 12.5, 0])
			cylinder(h = hwZA_BearingLength + 8 , d = 16);
		
		translate([0, -hwZA_RodYSpacing /2 - 12.5, 2])
			cylinder(h = hwZA_BearingLength + 4 , d = 17);
		
		// cross joining bit to make it solid - matches above
		translate([0, hwZA_RodYSpacing /2 + 12.5, 0])
			cylinder(h = hwZA_BearingLength + 8 , d = 16);
	}
	
}
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

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Default Usage:	
// Part_ZA_BearingCap();
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// Determine if MultiPartMode is enabled - if not, render the part automatically
// and enable support material (if it is defined)

if (MultiPartMode == undef) {
	MultiPartMode = false;
	EnableSupport = true;
	
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
			_BearingCap();
		}
		
		// carve out rods
		translate([0, -hwZA_RodYSpacing /2, 0])
		cylinder(h = hwZA_RodLength, d = hwZA_RodDiameter);
	
		translate([0, hwZA_RodYSpacing /2, 0])
		cylinder(h = hwZA_RodLength, d = hwZA_RodDiameter);
		
		// carve out rear bearings
		translate([0, -hwZA_RodYSpacing /2, 4])
		cylinder(h = hwZA_BearingLength, d = hwZA_BearingDiameter);
		
		translate([0, hwZA_RodYSpacing /2, 4])
		cylinder(h = hwZA_BearingLength, d = hwZA_BearingDiameter);
		
		translate([0,-50, -1])
		cube([60,100,100]);
		
		// rear mounting bolts
		translate([16, -35, 8.6])
		rotate([0,-90,0])
			Carve_hw_Bolt_AllenHead(hwM3_Bolt_AllenHeadSize, 20, 20);
			
		translate([16, -35, 34.1])
		rotate([0,-90,0])
			Carve_hw_Bolt_AllenHead(hwM3_Bolt_AllenHeadSize, 20, 20);
			
		// middle mounting bolts
		translate([16, 0, 8.6])
		rotate([0,-90,0])
			Carve_hw_Bolt_AllenHead(hwM3_Bolt_AllenHeadSize, 20, 20);
			
		translate([16, 0, 34.1])
		rotate([0,-90,0])
			Carve_hw_Bolt_AllenHead(hwM3_Bolt_AllenHeadSize, 20, 20);
			
		// front mounting bolts
		translate([16, 35, 8.6])
		rotate([0,-90,0])
			Carve_hw_Bolt_AllenHead(hwM3_Bolt_AllenHeadSize, 20, 20);
			
		translate([16, 35, 34.1])
		rotate([0,-90,0])
			Carve_hw_Bolt_AllenHead(hwM3_Bolt_AllenHeadSize, 20, 20);
		
	}
}

module _BearingCap() {
	_partThickness = 16;
	_baseThickness = 4;
	
	hull() {
		translate([0, -hwZA_RodYSpacing /2, _baseThickness])
		cylinder(h = hwZA_BearingLength , d = hwZA_BearingDiameter + 3);
	
		translate([0, hwZA_RodYSpacing /2, _baseThickness])
		cylinder(h = hwZA_BearingLength , d = hwZA_BearingDiameter + 3);
		
		translate([0, -hwZA_RodYSpacing /2, 0])
		cylinder(h = hwZA_BearingLength + _baseThickness , d = hwZA_BearingDiameter + 2);
	
		translate([0, hwZA_RodYSpacing /2, 0])
		cylinder(h = hwZA_BearingLength + _baseThickness , d = hwZA_BearingDiameter + 2);
		
		translate([0, hwZA_RodYSpacing /2 + 12.5, 0])
		cylinder(h = hwZA_BearingLength + 2*_baseThickness , d = _partThickness);
		
		translate([0, -hwZA_RodYSpacing /2 - 12.5, 0])
		cylinder(h = hwZA_BearingLength + 2*_baseThickness , d = _partThickness);
	}
}
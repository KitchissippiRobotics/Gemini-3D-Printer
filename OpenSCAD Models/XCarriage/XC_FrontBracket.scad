// *****************************************************************************
// ( )/ )(_  _)(_  _)___(  _ \(  _  )(  _ \(  _  )(_  _)(_  _)/ __)/ __)
//  )  (  _)(_   )( (___))   / )(_)(  ) _ < )(_)(   )(   _)(_( (__ \__ \
// (_)\_)(____) (__)    (_)\_)(_____)(____/(_____) (__) (____)\___)(___/
// *****************************************************************************
// Written by bcantin@kitchissippi-robotics.com
// Copyright (c) 2015 Kitchissippi Robotics
// -----------------------------------------------------------------------------
// XC_FrontBracket.scad
// Part No. XB-CB-???##
// Generates XC_FrontBracket.stl
// *****************************************************************************

include <../Dimensions.scad>
include <XC_Common.scad>

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Default Usage:	
// Part_XC_FrontBracket();
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// Determine if MultiPartMode is enabled - if not, render the part automatically
// and enable support material (if it is defined)

if (MultiPartMode == undef) {
	MultiPartMode = false;
	EnableSupport = true;
	
	Part_XC_FrontBracket();
} else {
	EnableSupport = false;
}

// -----------------------------------------------------------------------------
// Put it all together and carve out the hardware clearances
// -----------------------------------------------------------------------------

module Part_XC_FrontBracket() {

	yOffset = -6;

	difference() {
		union() {

			_FrontBracket_BoltPosts();	
			_FrontBracket_LinearMount();
			_FrontBracket_Wing();
			mirror([1,0,0])
				_FrontBracket_Wing();
				
			_FrontBracket_LowerBrace();
			mirror([1,0,0])
				_FrontBracket_LowerBrace();
				
		}
		
		// XC Mounting Bolts
		translate([rpXC_BeltMount_BoltSpacing / 2, 0, -5])
			Carve_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, rpXC_BeltMount_BoltLength);
			
		translate([-rpXC_BeltMount_BoltSpacing / 2, 0, -5])
			Carve_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, rpXC_BeltMount_BoltLength);
			
		// XC Mounting Bolts
		translate([rpXC_BeltMount_BoltSpacing / 2, -lowerBoltOffset, -5])
			Carve_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, rpXC_BeltMount_BoltLength);
			
		translate([-rpXC_BeltMount_BoltSpacing / 2, -lowerBoltOffset, -5])
			Carve_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, rpXC_BeltMount_BoltLength);	
	}
}

// -----------------------------------------------------------------------------
// Just Draw the bolt posts
// -----------------------------------------------------------------------------

module _FrontBracket_BoltPosts() {
	// top left assembly bolt mount base
	translate([-boltSpacing/2, 0, 0])
		cylinder(	h = rpXC_FrontBracketThickness,	
					d = hwM4_Bolt_ShaftDiameter + gcMachineOffset + minimumThickness,
					$fn = gcFacetLarge);
		
	// top right assembly bolt mount base
	translate([boltSpacing/2, 0, 0])
		cylinder(	h = rpXC_FrontBracketThickness,	
					d = hwM4_Bolt_ShaftDiameter + gcMachineOffset + minimumThickness,
					$fn = gcFacetLarge);
					
	// bottom left assembly bolt mount base
	translate([-boltSpacing/2, -lowerBoltOffset, 0])
		cylinder(	h = rpXC_FrontBracketThickness,	
					d = hwM4_Bolt_ShaftDiameter + gcMachineOffset + minimumThickness,
					$fn = gcFacetLarge);
		
	// bottom right assembly bolt mount base
	translate([boltSpacing/2, -lowerBoltOffset, 0])
		cylinder(	h = rpXC_FrontBracketThickness,	
					d = hwM4_Bolt_ShaftDiameter + gcMachineOffset + minimumThickness,
					$fn = gcFacetLarge);
			
}

// -----------------------------------------------------------------------------
// Linear Mount
// -----------------------------------------------------------------------------

module _FrontBracket_LinearMount(_yOffset = -6) {

	// some calculations used in the module
	centerSize = rpXC_CenterModuleDepth / 3;

	// block for bolts to mount through
	hull() {
		translate([8, _yOffset, 0])
			cylinder(h = rpXC_FrontBracketThickness, d1 = 9, d2 = 10, $fn = gcFacetLarge);

		translate([-8, _yOffset, 0])
			cylinder(h = rpXC_FrontBracketThickness, d1 = 9, d2 = 10, $fn = gcFacetLarge);
	}
}

// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------

module _FrontBracket_LowerBrace(_yOffset = -6) {
	// -- lower portion of the wing
	hull() {
		translate([-boltSpacing/2, -lowerBoltOffset /2 - 3, 0])
			cylinder(h = rpXC_FrontBracketThickness /2,	d1 = 10, d2 = 8);

		translate([-8, _yOffset, 0])
				cylinder(h = rpXC_FrontBracketThickness, d1 = 9, d2 = 7);
	}

	// -- connect lower portion of the wing to lower bolt
	hull() {
		translate([-boltSpacing/2, -lowerBoltOffset /2 -3, 0])
			cylinder(h = rpXC_FrontBracketThickness /2,	d1 = 10, d2 = 8);

		translate([-boltSpacing/2, -lowerBoltOffset, 0])
				cylinder(h = rpXC_FrontBracketThickness, d = 8);
	}
}

// -----------------------------------------------------------------------------
// Wing to attach the linear carriage mount to the bolt post 
// - left side, mirror to get right side
// -----------------------------------------------------------------------------

module _FrontBracket_Wing(_yOffset = -6) {

	// -- base portion of the wing
	hull() {
		translate([-boltSpacing/2, 0, 0])
			cylinder(h = rpXC_FrontBracketThickness,	d1 = 2.5, d2 = 4);

		translate([-8, _yOffset, 0])
				cylinder(h = rpXC_FrontBracketThickness, d1 = 4.5, d2 = 6);
		
		translate([-8, _yOffset  -2, 0])
				cylinder(h = rpXC_FrontBracketThickness / 2, d = 5);
	}		
}

// *****************************************************************************
// ( )/ )(_  _)(_  _)___(  _ \(  _  )(  _ \(  _  )(_  _)(_  _)/ __)/ __)
//  )  (  _)(_   )( (___))   / )(_)(  ) _ < )(_)(   )(   _)(_( (__ \__ \
// (_)\_)(____) (__)    (_)\_)(_____)(____/(_____) (__) (____)\___)(___/
// *****************************************************************************
// Written by bcantin@kitchissippi-robotics.com
// Copyright (c) 2015 Kitchissippi Robotics
// -----------------------------------------------------------------------------
// XC_CarriageBracket.scad
// Part No. XB-CB-ABS03 & XB-CB-ABS04
// Generates XC_CarriageBracket_Front.stl & XC_CarriageBracket_Rear.stl
// *****************************************************************************

// include <Dimensions.scad> - included from XC_Common.scad
include <XC_Common.scad>

// -----------------------------------------------------------------------------
// Default Usage:	
// Part_XC_CarriageBracket_Front();

// Determine if MultiPartMode is enabled - if not, render the part automatically
// and enable support material (if it is defined)

if (MultiPartMode == undef) {
	MultiPartMode = false;
	EnableSupport = true;
	
	Part_XC_RearBracket();
	
} else {
	EnableSupport = false;
}

// -----------------------------------------------------------------------------
// Put it all together and carve out the hardware clearances
// -----------------------------------------------------------------------------

module Part_XC_RearBracket() {

	yOffset = -6;

	difference() {
		union() {

			_RearBracket_BoltPosts();	
			_RearBracket_LinearMount();
			_RearBracket_Wing();
			mirror([1,0,0])
				_RearBracket_Wing();
				
			_RearBracket_LowerBrace();
			mirror([1,0,0])
				_RearBracket_LowerBrace();
				
			_BracketSwitchMount();
				
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
			
		translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset - hwMicroSwitch_HoleSpacing /2, 0])
				cylinder(h=10, d= 3.2);
			translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset + hwMicroSwitch_HoleSpacing /2, 0])
				cylinder(h=10, d= 3.2);
				
		// switch screw access carve out
		hull() {
			translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset - hwMicroSwitch_HoleSpacing /2, 2])
			cylinder(h=30, d= 1);
		
		
			translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset - hwMicroSwitch_HoleSpacing /2, 2])
			cylinder(h=5, d= 8.5);
		}
		
		hull() {
			translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset + hwMicroSwitch_HoleSpacing /2, 2])
			cylinder(h=30, d= 1);
		
		
			translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset + hwMicroSwitch_HoleSpacing /2, 2])
			cylinder(h=5, d= 8.5);
		}
		
		translate([-BlowerXOffset, -1, 0])
		_BlowerCarveout();
		
		// wiring channel
		hull() {
			translate([0,0,-1])
				sphere(d = 6);
				
			translate([3,-12,0])
				sphere(d = 4);
				
			translate([-3,-12,0])
				sphere(d = 4);
			}
	}
}

// -----------------------------------------------------------------------------
// Just Draw the bolt posts
// -----------------------------------------------------------------------------

module _RearBracket_BoltPosts() {
	// top left assembly bolt mount base
	translate([-boltSpacing/2, 0, 0])
		cylinder(	h = rpXC_RearBracketThickness,	
					d = hwM4_Bolt_ShaftDiameter + gcMachineOffset + minimumThickness,
					$fn = gcFacetLarge);
		
	// top right assembly bolt mount base
	translate([boltSpacing/2, 0, 0])
		cylinder(	h = rpXC_RearBracketThickness,	
					d = hwM4_Bolt_ShaftDiameter + gcMachineOffset + minimumThickness,
					$fn = gcFacetLarge);
					
	// bottom left assembly bolt mount base
	translate([-boltSpacing/2, -lowerBoltOffset, 0])
		cylinder(	h = rpXC_RearBracketThickness,	
					d = hwM4_Bolt_ShaftDiameter + gcMachineOffset + minimumThickness,
					$fn = gcFacetLarge);
		
	// bottom right assembly bolt mount base
	translate([boltSpacing/2, -lowerBoltOffset, 0])
		cylinder(	h = rpXC_RearBracketThickness,	
					d = hwM4_Bolt_ShaftDiameter + gcMachineOffset + minimumThickness,
					$fn = gcFacetLarge);
			
}

// -----------------------------------------------------------------------------
// Linear Mount
// -----------------------------------------------------------------------------

module _RearBracket_LinearMount(_yOffset = -6) {

	// some calculations used in the module
	centerSize = rpXC_CenterModuleDepth / 3;

	// block for bolts to mount through
	hull() {
		translate([8, _yOffset, 0])
			cylinder(h = rpXC_RearBracketThickness, d1 = 9, d2 = 10, $fn = gcFacetLarge);

		translate([-8, _yOffset, 0])
			cylinder(h = rpXC_RearBracketThickness, d1 = 9, d2 = 10, $fn = gcFacetLarge);
	}
}

// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------

module _RearBracket_LowerBrace(_yOffset = -6) {
	// -- lower portion of the wing
	hull() {
		translate([-boltSpacing/2, -lowerBoltOffset /2 - 3, 0])
			cylinder(h = rpXC_RearBracketThickness -1,	d1 = 10, d2 = 8);

		translate([-8, _yOffset, 0])
				cylinder(h = rpXC_RearBracketThickness, d1 = 9, d2 = 7);
	}

	// -- connect lower portion of the wing to lower bolt
	hull() {
		translate([-boltSpacing/2, -lowerBoltOffset /2 -3, 0])
			cylinder(h = rpXC_RearBracketThickness -1,	d1 = 10, d2 = 8);

		translate([-boltSpacing/2, -lowerBoltOffset, 0])
				cylinder(h = rpXC_RearBracketThickness, d = 8);
	}
}

// -----------------------------------------------------------------------------
// Wing to attach the linear carriage mount to the bolt post 
// - left side, mirror to get right side
// -----------------------------------------------------------------------------

module _RearBracket_Wing(_yOffset = -6) {

	// -- base portion of the wing
	hull() {
		translate([-boltSpacing/2, 0, 0])
			cylinder(h = rpXC_RearBracketThickness,	d1 = 2.5, d2 = 4);

		translate([-8, _yOffset, 0])
				cylinder(h = rpXC_RearBracketThickness, d1 = 4.5, d2 = 6);
		
		translate([-8, _yOffset  -2, 0])
				cylinder(h = rpXC_RearBracketThickness / 2, d = 5);
	}		
}

// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------

module _BracketSwitchMount(_baseDiameter = 10) {
	// switch holder lower screw base

	
	hull() {
	
		// make a rectangular-ish space
		// lower
		translate([switchXOffset + 3, - rpXC_BeltMount_BoltOffset + switchYOffset - hwMicroSwitch_HoleSpacing /2 - 3, 0])
			_BoltBase(1, rpXC_RearBracketThickness - 1, BBStyle_Round);
		translate([switchXOffset - 3, - rpXC_BeltMount_BoltOffset + switchYOffset - hwMicroSwitch_HoleSpacing /2 - 3, 0])
			_BoltBase(1, rpXC_RearBracketThickness - 1, BBStyle_Round);
		// upper
		translate([switchXOffset + 3, - rpXC_BeltMount_BoltOffset + switchYOffset + hwMicroSwitch_HoleSpacing /2 + 3, 0])
			_BoltBase(1, rpXC_RearBracketThickness - 1, BBStyle_Round);
		translate([switchXOffset - 3, - rpXC_BeltMount_BoltOffset + switchYOffset + hwMicroSwitch_HoleSpacing /2 + 3, 0])
			_BoltBase(1, rpXC_RearBracketThickness - 1, BBStyle_Round);
	
		// switch holder lower screw base
		translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset - hwMicroSwitch_HoleSpacing /2, 0])
			_BoltBase(hwMicroSwitch_ScrewHeadDiameter - 0.5, rpXC_RearBracketThickness - 1, BBStyle_Round);
	
		// switch holder upper screw base
		translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset + hwMicroSwitch_HoleSpacing /2, 0])
			_BoltBase(hwMicroSwitch_ScrewHeadDiameter - 0.5, rpXC_RearBracketThickness - 1, BBStyle_Round);
	}
	
}


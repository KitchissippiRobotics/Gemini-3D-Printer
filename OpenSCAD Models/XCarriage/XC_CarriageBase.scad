// *****************************************************************************
// ( )/ )(_  _)(_  _)___(  _ \(  _  )(  _ \(  _  )(_  _)(_  _)/ __)/ __)
//  )  (  _)(_   )( (___))   / )(_)(  ) _ < )(_)(   )(   _)(_( (__ \__ \
// (_)\_)(____) (__)    (_)\_)(_____)(____/(_____) (__) (____)\___)(___/
// *****************************************************************************
// Written by bcantin@kitchissippi-robotics.com
// Copyright (c) 2015 Kitchissippi Robotics
// -----------------------------------------------------------------------------
// XC_CarriageBase.scad
// Part No. XB-CB-ABS01
// Generates XC_CarriageBase.stl
// *****************************************************************************

include <../Dimensions.scad>
include <XC_Common.scad>

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Default Usage:	
// Part_XC_CarriageBase();
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// Determine if MultiPartMode is enabled - if not, render the part automatically
// and enable support material (if it is defined)

if (MultiPartMode == undef) {
	MultiPartMode = false;
	EnableSupport = true;
	
	Part_XC_CarriageBase();
} else {
	EnableSupport = false;
}

// -----------------------------------------------------------------------------
// Put it all together and carve out the hardware clearances
// -----------------------------------------------------------------------------

module Part_XC_CarriageBase() {

	_yOffset = -6;

	difference() {
		union() {

			_CarriageBase_BoltPosts();	
			_CarriageBase_LinearMount();
			_CarriageBase_Wing();
			mirror([1,0,0])
				_CarriageBase_Wing();
				
		}
		
		// XC Mounting Bolts
		translate([rpXC_BeltMount_BoltSpacing / 2, 0, -5])
			Carve_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, rpXC_BeltMount_BoltLength);
			
		translate([-rpXC_BeltMount_BoltSpacing / 2, 0, -5])
			Carve_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, rpXC_BeltMount_BoltLength);
		
		// Cut flat section off where it meets the linear carriage
		
		translate([-25, -20, -10])
			cube([50, 10, 50]);
		
		
		// carriage mounting bolts
		zOffset = (rpXC_CenterModuleDepth / 2) - (hwLR_Carriage_BoltWidth / 2);
		
		
		translate([-hwLR_Carriage_BoltLength / 2, _yOffset - rpXC_CarriageMount_BoltLength + hwLR_Carriage_BoltDepth - 1, zOffset])
		rotate([-90,0,0])
			Carve_hw_Bolt_AllenHead(rpXC_CarriageMount_BoltSize, rpXC_CarriageMount_BoltLength, 20);
			
		translate([- hwLR_Carriage_BoltLength / 2, _yOffset - rpXC_CarriageMount_BoltLength + hwLR_Carriage_BoltDepth - 1, zOffset + hwLR_Carriage_BoltWidth])
		rotate([-90,0,0])
			Carve_hw_Bolt_AllenHead(rpXC_CarriageMount_BoltSize, rpXC_CarriageMount_BoltLength, 20);
			
		translate([hwLR_Carriage_BoltLength / 2, _yOffset - rpXC_CarriageMount_BoltLength + hwLR_Carriage_BoltDepth - 1, zOffset])
		rotate([-90,0,0])
			Carve_hw_Bolt_AllenHead(rpXC_CarriageMount_BoltSize, rpXC_CarriageMount_BoltLength, 20);
			
		translate([hwLR_Carriage_BoltLength / 2, _yOffset - rpXC_CarriageMount_BoltLength + hwLR_Carriage_BoltDepth - 1, zOffset + hwLR_Carriage_BoltWidth])
		rotate([-90,0,0])
			Carve_hw_Bolt_AllenHead(rpXC_CarriageMount_BoltSize, rpXC_CarriageMount_BoltLength, 20);	
	}
			
}


// -----------------------------------------------------------------------------
// Just Draw the bolt posts
// -----------------------------------------------------------------------------

module _CarriageBase_BoltPosts() {
	// top left assembly bolt mount base
	translate([-boltSpacing/2, 0, 0])
		cylinder(	h = rpXC_CenterModuleDepth,	
					d = hwM4_Bolt_ShaftDiameter + gcMachineOffset + minimumThickness,
					$fn = gcFacetLarge);
		
	// top right assembly bolt mount base
	translate([boltSpacing/2, 0, 0])
		cylinder(	h = rpXC_CenterModuleDepth,	
					d = hwM4_Bolt_ShaftDiameter + gcMachineOffset + minimumThickness,
					$fn = gcFacetLarge);
			
}

// -----------------------------------------------------------------------------
// Linear Mount
// -----------------------------------------------------------------------------

module _CarriageBase_LinearMount(_yOffset = -6) {

	// some calculations used in the module
	centerSize = rpXC_CenterModuleDepth / 3;

	// block for bolts to mount through
	hull() {
		translate([8, _yOffset, (rpXC_CenterModuleDepth / 2) - (centerSize / 2)])
			cylinder(h = centerSize, d = 12, $fn = gcFacetLarge);

		translate([-8, _yOffset, (rpXC_CenterModuleDepth / 2) - (centerSize / 2)])
			cylinder(h = centerSize, d = 12, $fn = gcFacetLarge);
	

		translate([8, _yOffset, 0])
			cylinder(h = rpXC_CenterModuleDepth, d = 10, $fn = gcFacetLarge);

		translate([-8, _yOffset, 0])
			cylinder(h = rpXC_CenterModuleDepth, d = 10, $fn = gcFacetLarge);
	
	}
	
}

// -----------------------------------------------------------------------------
// Wing to attach the linear carriage mount to the bolt post 
// - left side, mirror to get right side
// -----------------------------------------------------------------------------

module _CarriageBase_Wing(_yOffset = -6) {

	// some calculations used in the module
	carveOffset = (hwM4_Bolt_ShaftDiameter + gcMachineOffset + minimumThickness) / 2;
	centerSize = rpXC_CenterModuleDepth / 3;
	
	// --- make a wing and then carve some space out
	difference() {
		// -- base portion of the wing
		hull() {
			translate([-boltSpacing/2, 0, 0])
				cylinder(h = rpXC_CenterModuleDepth,	d = 4);
			
			translate([-8, _yOffset, 0])
					cylinder(h = rpXC_CenterModuleDepth, d = 6);
					

			translate([-boltSpacing/2, 0, (rpXC_CenterModuleDepth / 2) - (centerSize / 2)])
				cylinder(h = centerSize,	d = 6);
			
			translate([-8, _yOffset, (rpXC_CenterModuleDepth / 2) - (centerSize / 2)])
					cylinder(h = centerSize, d = 9);
		}
	
		// -- top carve out of the wing
		_CarriageBase_WingCarveout();
		translate([-2, -9, 0])
			_CarriageBase_WingCarveout();
	}
	
	
}

// -----------------------------------------------------------------------------
// Wing carve out design
// - the design carved out probably only works when the XC posts are 52mm apart
// -----------------------------------------------------------------------------

module _CarriageBase_WingCarveout(_yOffset = -6) {

	// some calculations used in the module
	carveOffset = (hwM4_Bolt_ShaftDiameter + gcMachineOffset + minimumThickness) / 2;
	centerSize = rpXC_CenterModuleDepth / 3;
	
	hull() {
			// top left assembly bolt mount base
			translate([-boltSpacing/2 +  carveOffset, 3, (rpXC_CenterModuleDepth / 2) - (centerSize / 2)])
				cylinder(h = centerSize,	d = 8);
				
			translate([-8 - carveOffset, _yOffset + 6, (rpXC_CenterModuleDepth / 2) - (centerSize / 2)])
					cylinder(h = centerSize, d = 8);
										
				
			translate([-boltSpacing/2 +  carveOffset, 3, 2])
				cylinder(h = rpXC_CenterModuleDepth - 4,	d = 2);
				
					
			translate([-8 - carveOffset, _yOffset + 6, 2])
					cylinder(h = rpXC_CenterModuleDepth - 4, d = 2);
					
					
			translate([-8 - carveOffset, _yOffset + 6, 0])
					cylinder(h = rpXC_CenterModuleDepth, d = 1);
					
			translate([-boltSpacing/2 +  carveOffset, 3, 0])
					cylinder(h = rpXC_CenterModuleDepth, d = 1);
		}
}



		
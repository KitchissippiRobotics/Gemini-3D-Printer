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
// -----------------------------------------------------------------------------
// Note that there is some rotation done in the part module - this part started
// it's design with a different print orientation than it currently has.
// *****************************************************************************

include <../Dimensions.scad>
include <XC_Common.scad>

// -----------------------------------------------------------------------------
// Default Usage:	
// Part_XC_CarriageBase();

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

	difference() {
		union() {

			_CarriageBase_BoltPosts();	
			_CarriageBase_LinearMount();
			_CarriageBase_Wings();
				
		}
		
		translate([rpXC_BeltMount_BoltSpacing / 2, 0, -5])
			Carve_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, rpXC_BeltMount_BoltLength);
			
		translate([-rpXC_BeltMount_BoltSpacing / 2, 0, -5])
			Carve_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, rpXC_BeltMount_BoltLength);
		
		translate([-25, -20, -10])
			cube([50, 10, 50]);
		
		
			
	}
			
}


// -----------------------------------------------------------------------------
// Just Draw the bolt posts
// -----------------------------------------------------------------------------

module _CarriageBase_BoltPosts() {
	// top left assembly bolt mount base
	translate([-boltSpacing/2, 0, 0])
		cylinder(h = rpXC_CenterModuleDepth,	d = hwM4_Bolt_ShaftDiameter + gcMachineOffset + minimumThickness);
		
	// top right assembly bolt mount base
	translate([boltSpacing/2, 0, 0])
		cylinder(h = rpXC_CenterModuleDepth,	d = hwM4_Bolt_ShaftDiameter + gcMachineOffset + minimumThickness);
			
}

// -----------------------------------------------------------------------------
// Linear Mount
// -----------------------------------------------------------------------------

module _CarriageBase_LinearMount(_yOffset = -6) {
	centerSize = rpXC_CenterModuleDepth / 3;

	difference() {
		// bulk for bolts to mount through
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
		
		// mounting bolts
		zOffset = (rpXC_CenterModuleDepth / 2) - (hwLR_Carriage_BoltWidth / 2);
		
		
		translate([- hwLR_Carriage_BoltLength / 2, _yOffset - rpXC_CarriageMount_BoltLength + hwLR_Carriage_BoltDepth - 1, zOffset])
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
// Wings to attach the linear carriage mount to the bolt posts
// -----------------------------------------------------------------------------

module _CarriageBase_Wings() {
}



		
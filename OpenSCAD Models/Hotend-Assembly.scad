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

module Part_HA_CarriageBase() {




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
					 d = 16.2);
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
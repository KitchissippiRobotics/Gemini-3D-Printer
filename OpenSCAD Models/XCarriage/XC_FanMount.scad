// *****************************************************************************
// ( )/ )(_  _)(_  _)___(  _ \(  _  )(  _ \(  _  )(_  _)(_  _)/ __)/ __)
//  )  (  _)(_   )( (___))   / )(_)(  ) _ < )(_)(   )(   _)(_( (__ \__ \
// (_)\_)(____) (__)    (_)\_)(_____)(____/(_____) (__) (____)\___)(___/
// *****************************************************************************
// Written by bcantin@kitchissippi-robotics.com
// Copyright (c) 2015 Kitchissippi Robotics
// -----------------------------------------------------------------------------
// XC_FanMount.scad
// Part No. XB-CB-???##
// Generates XC_FanMount.stl
// *****************************************************************************

include <../Dimensions.scad>
include <XC_Common.scad>

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Default Usage:
// XC_FanMount();
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// Determine if MultiPartMode is enabled - if not, render the part automatically
// and enable support material (if it is defined)

if (MultiPartMode == undef) {
	MultiPartMode = false;
	EnableSupport = true;

	Part_XC_FanMount();
} else {
	EnableSupport = false;
}

// -----------------------------------------------------------------------------
// Put it all together and carve out the hardware clearances
// -----------------------------------------------------------------------------

module Part_XC_FanMount() {
	nutInset = 1;

	difference() {
		union() {
			_FanMount_FanBase();
			_FanMount_HotendMount();
		}

		// fan bolt mounts
		translate([16, -7 - hwHA_Fan_VertOffset, 8])
		rotate([180,0,0])
			Carve_hw_Bolt_AllenHead(hwM3_Bolt_AllenHeadSize, 15);

		translate([-16, -7- hwHA_Fan_VertOffset, 8])
		rotate([180,0,0])
			Carve_hw_Bolt_AllenHead(hwM3_Bolt_AllenHeadSize, 15);

		translate([16, -39- hwHA_Fan_VertOffset, 8])
		rotate([180,0,0])
			Carve_hw_Bolt_AllenHead(hwM3_Bolt_AllenHeadSize, 15);

		translate([-16, -39- hwHA_Fan_VertOffset, 8])
		rotate([180,0,0])
			Carve_hw_Bolt_AllenHead(hwM3_Bolt_AllenHeadSize, 15);

		// fan mount nuts

		translate([-16, -7- hwHA_Fan_VertOffset, nutInset])
		rotate([0,0,0])
				cylinder(h = 8, d1 = 6.6, d2 = 6.6, $fn = 6);

		translate([16, -7- hwHA_Fan_VertOffset, nutInset])
		rotate([0,0,0])
				cylinder(h = 8, d1 = 6.6, d2 = 6.6, $fn = 6);

		translate([-16, -39- hwHA_Fan_VertOffset, nutInset])
		rotate([0,0,-15])
				cylinder(h = 8, d1 = 6.6, d2 = 6.6, $fn = 6);

		translate([16, -39- hwHA_Fan_VertOffset, nutInset])
		rotate([0,0,15])
				cylinder(h = 8, d1 = 6.6, d2 = 6.6, $fn = 6);

		// hotend mount bolts
		translate([25, -10 - hwXC_BarSpacing, 15])
		rotate([180,0,0])
			Carve_hw_Bolt_AllenHead(hwM3_Bolt_AllenHeadSize, 15);

		translate([-25, -10 - hwXC_BarSpacing, 15])
		rotate([180,0,0])
			Carve_hw_Bolt_AllenHead(hwM3_Bolt_AllenHeadSize, 15);




		// hotend carveouts
		translate([0,10,3])
		_FanMount_HECarveOut();

		mirror([1,0,0])
		translate([0,10,3])
		_FanMount_HECarveOut();

	}
}

module _FanMount_FanBase() {
	difference() {
		hull() {
			translate([16, -7- hwHA_Fan_VertOffset, 0])
				cylinder(h = 6.3, d = 8);

			translate([-16, -7- hwHA_Fan_VertOffset, 0])
				cylinder(h = 6.3, d = 8);

			translate([16, -39- hwHA_Fan_VertOffset, 0])
				cylinder(h = 6.3, d = 8);

			translate([-16, -39- hwHA_Fan_VertOffset, 0])
				cylinder(h = 6.3, d = 8);
		}

		// airflow carve out
		translate([0, -23- hwHA_Fan_VertOffset, -0.1])
			cylinder(h = 10, d1 = 36, d2 = 40);
	}
}

module _FanMount_HotendMount() {
	hull() {
		translate([25, -10 - hwXC_BarSpacing, 0])
			cylinder( h = 6.3, d1 = 10, d2 = 12);

		translate([16, -7 - hwXC_BarSpacing, 0])
			cylinder( h = 6.3, d = 8);
	}

	hull() {
		translate([16, -8 - hwXC_BarSpacing, 0])
			cylinder( h = 6.3, d1 = 9, d2 = 10);

		translate([-16, -8 - hwXC_BarSpacing, 0])
			cylinder( h = 6.3, d1 = 9, d2 = 10);
	}

	hull() {
		translate([-25, -10 - hwXC_BarSpacing, 0])
			cylinder( h = 6.3, d1 = 10, d2 = 12);

		translate([-16, -7 - hwXC_BarSpacing, 0])
			cylinder( h = 6.3, d = 8);
	}
}

module _FanMount_HECarveOut() {
	translate([0,-10,-4])
		rotate([0,0,-90])
		union() {

		// top of hotend
		translate([hwHA_Hotend_VerticalOffset,
					hwHA_Hotend_Spacing /2,
					hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing])
		rotate([0,90,0])
			cylinder(h = 5,
					 d = 17);

		translate([hwHA_Hotend_VerticalOffset,
					hwHA_Hotend_Spacing /2 - 8.5,
					hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing])
			cube([5, 17, 8.5], center = false);

		// hotend groovemount
		translate([hwHA_Hotend_VerticalOffset + 4.67,
					hwHA_Hotend_Spacing /2,
					hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing])
		rotate([0,90,0])
			cylinder(h = 4.67,
					 d = 13);
		translate([hwHA_Hotend_VerticalOffset + 4.67,
					hwHA_Hotend_Spacing /2 - 6.5,
					hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing])
			cube([4.67, 13, 6.5], center = false);

		// hotend lower
		translate([hwHA_Hotend_VerticalOffset + 2 * 4.67,
					hwHA_Hotend_Spacing /2,
					hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing])
		rotate([0,90,0])
			cylinder(h = 41 - 2 * 4.67,
					 d = 20);

		*rotate([0,-90,0])
			_HA_CB_BoltCarveouts();

		*translate([10, -25, -0.1])
		rotate([0,0,15])
				cylinder(h = 8, d1 = 8, d2 = 6.8, $fn = 6);
		}
}

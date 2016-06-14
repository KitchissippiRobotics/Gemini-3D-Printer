// *****************************************************************************
// ( )/ )(_  _)(_  _)___(  _ \(  _  )(  _ \(  _  )(_  _)(_  _)/ __)/ __)
//  )  (  _)(_   )( (___))   / )(_)(  ) _ < )(_)(   )(   _)(_( (__ \__ \
// (_)\_)(____) (__)    (_)\_)(_____)(____/(_____) (__) (____)\___)(___/
// *****************************************************************************
// Written by bcantin@kitchissippi-robotics.com
// Copyright (c) 2016 Kitchissippi Robotics
// -----------------------------------------------------------------------------
// ZA_BaseStabilizer.scad
// Part No.
// Generates ZA_BaseStabilizer.stl
// *****************************************************************************

include <../Dimensions.scad>

_drawHardware = false;
//$fn = 200;
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Default Usage:
// Part_ZA_BaseStabilizer();
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// Determine if MultiPartMode is enabled - if not, render the part automatically
// and enable support material (if it is defined)

if (MultiPartMode == undef) {
	MultiPartMode = false;
	EnableSupport = true;

	Part_ZA_BaseStabilizer();
} else {
	EnableSupport = false;
}


module Part_ZA_BaseStabilizer()
{
// box around arm
	hull() {
		translate([hwZA_ArmSpacing/2 + hwZA_ArmWidth/2,hwZA_ArmYOffset,-_baseThickness])
		cylinder(h = _baseThickness + hwZA_ArmWidth, d = _partThickness);

		translate([hwZA_ArmSpacing/2 - hwZA_ArmWidth/2,hwZA_ArmYOffset,-_baseThickness])
		cylinder(h = _baseThickness + hwZA_ArmWidth, d = _partThickness);

		translate([hwZA_ArmSpacing/2 + hwZA_ArmWidth/2,-hwZA_ArmYOffset,-_baseThickness])
		cylinder(h = _baseThickness + hwZA_ArmWidth, d = _partThickness);

		translate([hwZA_ArmSpacing/2 - hwZA_ArmWidth/2,-hwZA_ArmYOffset,-_baseThickness])
		cylinder(h = _baseThickness + hwZA_ArmWidth, d = _partThickness);
	}
}

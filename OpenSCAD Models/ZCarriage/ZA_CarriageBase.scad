// *****************************************************************************
// ( )/ )(_  _)(_  _)___(  _ \(  _  )(  _ \(  _  )(_  _)(_  _)/ __)/ __)
//  )  (  _)(_   )( (___))   / )(_)(  ) _ < )(_)(   )(   _)(_( (__ \__ \
// (_)\_)(____) (__)    (_)\_)(_____)(____/(_____) (__) (____)\___)(___/
// *****************************************************************************
// Written by bcantin@kitchissippi-robotics.com
// Copyright (c) 2016 Kitchissippi Robotics
// -----------------------------------------------------------------------------
// ZA_CarriageBase.scad
// Part No. 
// Generates ZA_CarriageBase.stl
// *****************************************************************************

include <../Dimensions.scad>


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Default Usage:	
// Part_ZA_CarriageBase();
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// Determine if MultiPartMode is enabled - if not, render the part automatically
// and enable support material (if it is defined)

if (MultiPartMode == undef) {
	MultiPartMode = false;
	EnableSupport = true;
	
	Part_ZA_CarriageBase();
} else {
	EnableSupport = false;
}

// draw smooth rods

/*if (MultiPartMode == false)*/ {
	%translate([hwZA_RodXSpacing / 2, 0, 0])
	cylinder(h = hwZA_RodLength, d = hwZA_RodDiameter);

	%translate([-hwZA_RodXSpacing / 2, 0, 0])
	cylinder(h = hwZA_RodLength, d = hwZA_RodDiameter);

	%translate([hwZA_RodXSpacing / 2, -hwZA_RodYSpacing, 0])
	cylinder(h = hwZA_RodLength, d = hwZA_RodDiameter);

	%translate([-hwZA_RodXSpacing / 2, -hwZA_RodYSpacing, 0])
	cylinder(h = hwZA_RodLength, d = hwZA_RodDiameter);

	translate([hwZA_RodXSpacing / 2 + hwZA_BearingDiameter /2, - hwZA_BearingDiameter/2, hwZA_BearingLength])
	import("../Vitamins/LM12UU_Bearing.stl", convexity=3);
	
	translate([-hwZA_RodXSpacing / 2 + hwZA_BearingDiameter /2, - hwZA_BearingDiameter/2, hwZA_BearingLength])
	import("../Vitamins/LM12UU_Bearing.stl", convexity=3);
	
	translate([hwZA_RodXSpacing / 2 + hwZA_BearingDiameter /2, -hwZA_RodYSpacing - hwZA_BearingDiameter/2, hwZA_BearingLength])
	import("../Vitamins/LM12UU_Bearing.stl", convexity=3);
	
	translate([-hwZA_RodXSpacing / 2 + hwZA_BearingDiameter /2, -hwZA_RodYSpacing - hwZA_BearingDiameter/2, hwZA_BearingLength])
	import("../Vitamins/LM12UU_Bearing.stl", convexity=3);
	
	translate([hwZA_RodXSpacing / 2 + hwZA_BearingDiameter /2, -hwZA_RodYSpacing - hwZA_BearingDiameter/2, hwZA_BearingLength *2 +2])
	import("../Vitamins/LM12UU_Bearing.stl", convexity=3);
	
	translate([-hwZA_RodXSpacing / 2 + hwZA_BearingDiameter /2, -hwZA_RodYSpacing - hwZA_BearingDiameter/2, hwZA_BearingLength *2 + 2])
	import("../Vitamins/LM12UU_Bearing.stl", convexity=3);
	
	import("../Vitamins/leadscrew_bushing.stl", convexity=3);
}


// -----------------------------------------------------------------------------
// Put it all together and carve out the hardware clearances
// -----------------------------------------------------------------------------

module Part_ZA_CarriageBase() {



	// LM12UU bearings
	
	

}
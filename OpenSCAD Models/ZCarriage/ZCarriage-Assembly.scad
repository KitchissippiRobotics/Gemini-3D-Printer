// *****************************************************************************
// ( )/ )(_  _)(_  _)___(  _ \(  _  )(  _ \(  _  )(_  _)(_  _)/ __)/ __)
//  )  (  _)(_   )( (___))   / )(_)(  ) _ < )(_)(   )(   _)(_( (__ \__ \
// (_)\_)(____) (__)    (_)\_)(_____)(____/(_____) (__) (____)\___)(___/
// *****************************************************************************
// Written by bcantin@kitchissippi-robotics.com
// Copyright (c) 2016 Kitchissippi Robotics
// -----------------------------------------------------------------------------
// ZCarriage-Assembly.scad
// *****************************************************************************

include <../Dimensions.scad>

// Enable multipart mode - this disables built in support material and automatic 
// rendering of the parts

MultiPartMode = true;

colourPrimary = "Snow";
colourSecondary = "SeaGreen";

// 12mm x 450mm smooth rods
%translate([hwZA_RodXSpacing / 2, -hwZA_RodYSpacing /2, -15])
cylinder(h = hwZA_RodLength, d = hwZA_RodDiameter);

%translate([-hwZA_RodXSpacing / 2, -hwZA_RodYSpacing /2, -15])
cylinder(h = hwZA_RodLength, d = hwZA_RodDiameter);

%translate([hwZA_RodXSpacing / 2, hwZA_RodYSpacing /2, -15])
cylinder(h = hwZA_RodLength, d = hwZA_RodDiameter);

%translate([-hwZA_RodXSpacing / 2, hwZA_RodYSpacing /2, -15])
cylinder(h = hwZA_RodLength, d = hwZA_RodDiameter);

// bearings/bushings
%translate([hwZA_RodXSpacing / 2 + hwZA_BearingDiameter /2, - hwZA_BearingDiameter/2 +hwZA_RodYSpacing /2, 19.1])
import("../Vitamins/LM12UU_Bearing.stl", convexity=3);

%translate([-hwZA_RodXSpacing / 2 + hwZA_BearingDiameter /2, - hwZA_BearingDiameter/2 +hwZA_RodYSpacing /2, 19.1])
import("../Vitamins/LM12UU_Bearing.stl", convexity=3);

%translate([hwZA_RodXSpacing / 2 + hwZA_BearingDiameter /2, -hwZA_RodYSpacing /2 - hwZA_BearingDiameter/2, 19.1])
import("../Vitamins/LM12UU_Bearing.stl", convexity=3);

%translate([-hwZA_RodXSpacing / 2 + hwZA_BearingDiameter /2, -hwZA_RodYSpacing /2 - hwZA_BearingDiameter/2, 19.1])
import("../Vitamins/LM12UU_Bearing.stl", convexity=3);

// doubled up bearings - not used in this version

*translate([hwZA_RodXSpacing / 2 + hwZA_BearingDiameter /2, hwZA_RodYSpacing /2 - hwZA_BearingDiameter/2, hwZA_BearingLength *2 +hwZA_BearingZSpacing])
import("../Vitamins/LM12UU_Bearing.stl", convexity=3);

*translate([-hwZA_RodXSpacing / 2 + hwZA_BearingDiameter /2, hwZA_RodYSpacing /2 - hwZA_BearingDiameter/2, hwZA_BearingLength *2 + hwZA_BearingZSpacing])
import("../Vitamins/LM12UU_Bearing.stl", convexity=3);

// leadscrew bushing
%translate([0,0,19.1 - hwZA_BushingZOffset])
rotate([0,180,0])
import("../Vitamins/leadscrew_bushing.stl", convexity=3);

// support arms
%translate([hwZA_ArmSpacing /2 - hwZA_ArmWidth/2, hwZA_ArmYOffset, hwZA_ArmZOffset])
cube([hwZA_ArmWidth, hwZA_ArmLength, hwZA_ArmWidth]);

%translate([-hwZA_ArmSpacing /2 - hwZA_ArmWidth/2, hwZA_ArmYOffset, hwZA_ArmZOffset])
cube([hwZA_ArmWidth, hwZA_ArmLength, hwZA_ArmWidth]);


include <ZA_CarriageBase.scad>

color(colourPrimary)
translate([0,0,19.1])
rotate([0,180,0])
	Part_ZA_CarriageBase();
	
include <ZA_BearingCap.scad>

color(colourSecondary)
translate([-hwZA_RodXSpacing /2,0,-15])
rotate([0,0,0])
	Part_ZA_BearingCap();
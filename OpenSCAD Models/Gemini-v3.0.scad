// *****************************************************************************
// ( )/ )(_  _)(_  _)___(  _ \(  _  )(  _ \(  _  )(_  _)(_  _)/ __)/ __)
//  )  (  _)(_   )( (___))   / )(_)(  ) _ < )(_)(   )(   _)(_( (__ \__ \
// (_)\_)(____) (__)    (_)\_)(_____)(____/(_____) (__) (____)\___)(___/
// *****************************************************************************
// Written by bcantin@kitchissippi-robotics.com
// Copyright (c) 2015-2016 Kitchissippi Robotics
// -----------------------------------------------------------------------------
// Full Machine Model
// *****************************************************************************

include <./Dimensions.scad>
include <Gemini-Configuration.scad>

// Enable multipart mode - this disables built in support material and automatic 
// rendering of the parts

MultiPartMode = true;
AssemblyMode = true;

// Colour Scheme for Parts

colourPrimary = "Snow";
colourSecondary = "SeaGreen";

// Frame Layout

include <./Frame/Frame-Assembly.scad>

// Z Axis

include <./ZCarriage/ZCarriage-Assembly.scad>

translate([0, HW_FrameLength /2 - 28, 15])
rotate([0,0,180])
	Assembly_ZCarriage(380);

color(colourSecondary)
translate([0, 190 + 30, 506])
	import("./STL Files/ZCarriage/ZA_MotorMount.stl", convexity = 3);
	
color(colourPrimary)
translate([hwZA_RodXSpacing/2, 190 + 30, 524])
	import("./STL Files/ZAxis/ZA_RodHolderUpper.stl", convexity = 3);
	
color(colourPrimary)
translate([-hwZA_RodXSpacing/2, 190 + 30, 524])
	import("./STL Files/ZAxis/ZA_RodHolderUpper.stl", convexity = 3);
	
	
include <./XCarriage/XCarriage-Assembly.scad>

translate([0, 0, 500])
rotate([0,0,-90])
	Assembly_XCarriage();
// *****************************************************************************
// ( )/ )(_  _)(_  _)___(  _ \(  _  )(  _ \(  _  )(_  _)(_  _)/ __)/ __)
//  )  (  _)(_   )( (___))   / )(_)(  ) _ < )(_)(   )(   _)(_( (__ \__ \
// (_)\_)(____) (__)    (_)\_)(_____)(____/(_____) (__) (____)\___)(___/
// *****************************************************************************
// Written by bcantin@kitchissippi-robotics.com
// Copyright (c) 2015 Kitchissippi Robotics
// -----------------------------------------------------------------------------
// Frame Assembly
// *****************************************************************************

// =============================================================================
// Frame Layout
// =============================================================================

include <../Vitamins/extrusion_profile.scad>

// --- Bottom Frame ------------------------------------------------------------

// rear outside bottom tube

%translate([-HW_FrameLength /2,HW_FrameLength /2 + HW_FrameSize /2,HW_FrameSize /2])
rotate([0,90,0])
	Vitamin_AluminumExtrusion(HW_FrameLength);
	
// right outside bottom tube

%translate([HW_FrameLength /2 + HW_FrameSize /2,-HW_FrameLength /2,HW_FrameSize /2])
rotate([0,90,90])
	Vitamin_AluminumExtrusion(HW_FrameLength);
	
// left outside bottom tube

%translate([-HW_FrameLength /2 - HW_FrameSize /2,-HW_FrameLength /2,HW_FrameSize /2])
rotate([0,90,90])
	Vitamin_AluminumExtrusion(HW_FrameLength);
	
// front outside bottom tube

%translate([-HW_FrameLength /2,- HW_FrameLength /2 - HW_FrameSize /2,HW_FrameSize /2])
rotate([0,90,0])
	Vitamin_AluminumExtrusion(HW_FrameLength);
	
// rear inside bottom tube

%translate([-HW_FrameLength /2,180,HW_FrameSize /2])
rotate([0,90,0])
	Vitamin_AluminumExtrusion(HW_FrameLength);
	
// --- Top Frame ---------------------------------------------------------------

_topHeight = 565;

// rear outside top tube

%translate([-HW_FrameLength /2,HW_FrameLength /2 + HW_FrameSize /2, _topHeight + HW_FrameSize /2])
rotate([0,90,0])
	Vitamin_AluminumExtrusion(HW_FrameLength);
	
// right outside top tube

%translate([HW_FrameLength /2 + HW_FrameSize /2,-HW_FrameLength /2, _topHeight + HW_FrameSize /2])
rotate([0,90,90])
	Vitamin_AluminumExtrusion(HW_FrameLength);
	
// left outside top tube

%translate([-HW_FrameLength /2 - HW_FrameSize /2,-HW_FrameLength /2, _topHeight + HW_FrameSize /2])
rotate([0,90,90])
	Vitamin_AluminumExtrusion(HW_FrameLength);
	
// front outside top tube

%translate([-HW_FrameLength /2,- HW_FrameLength /2 - HW_FrameSize /2, _topHeight + HW_FrameSize /2])
rotate([0,90,0])
	Vitamin_AluminumExtrusion(HW_FrameLength);
	
// --- Mid Frame ---------------------------------------------------------------

_midHeight = 506;

// rear outside mid tube

%translate([-HW_FrameLength /2,HW_FrameLength /2 + HW_FrameSize /2,_midHeight + HW_FrameSize /2])
rotate([0,90,0])
	Vitamin_AluminumExtrusion(HW_FrameLength);

// rear inside mid tube

%translate([-HW_FrameLength /2,180,_midHeight + HW_FrameSize /2])
rotate([0,90,0])
	Vitamin_AluminumExtrusion(HW_FrameLength);
	
// right outside mid tube

%translate([HW_FrameLength /2 + HW_FrameSize /2,-HW_FrameLength /2,_midHeight + HW_FrameSize /2])
rotate([0,90,90])
	Vitamin_AluminumExtrusion(HW_FrameLength);
	
// left outside mid tube

%translate([-HW_FrameLength /2 - HW_FrameSize /2,-HW_FrameLength /2,_midHeight + HW_FrameSize /2])
rotate([0,90,90])
	Vitamin_AluminumExtrusion(HW_FrameLength);

// --- Vertical Frame ----------------------------------------------------------

_topLength = 750;

// front left tube

%translate([-HW_FrameLength /2 - HW_FrameSize /2,- HW_FrameLength /2 - HW_FrameSize /2, 0])
rotate([0,0,0])
	Vitamin_AluminumExtrusion(_topLength);
	
// front right tube

%translate([HW_FrameLength /2 + HW_FrameSize /2,- HW_FrameLength /2 - HW_FrameSize /2, 0])
rotate([0,0,0])
	Vitamin_AluminumExtrusion(_topLength);
	
// rear left tube

%translate([-HW_FrameLength /2 - HW_FrameSize /2, HW_FrameLength /2 + HW_FrameSize /2, 0])
rotate([0,0,0])
	Vitamin_AluminumExtrusion(_topLength);
	
// rear right tube

%translate([HW_FrameLength /2 + HW_FrameSize /2, HW_FrameLength /2 + HW_FrameSize /2, 0])
rotate([0,0,0])
	Vitamin_AluminumExtrusion(_topLength);
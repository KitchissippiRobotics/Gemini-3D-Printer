// *****************************************************************************
// ( )/ )(_  _)(_  _)___(  _ \(  _  )(  _ \(  _  )(_  _)(_  _)/ __)/ __)
//  )  (  _)(_   )( (___))   / )(_)(  ) _ < )(_)(   )(   _)(_( (__ \__ \
// (_)\_)(____) (__)    (_)\_)(_____)(____/(_____) (__) (____)\___)(___/
// *****************************************************************************
// Written by bcantin@kitchissippi-robotics.com
// Copyright (c) 2015 Kitchissippi Robotics
// -----------------------------------------------------------------------------
// X-Carriage Component
// *****************************************************************************

include <../Dimensions.scad>

// Enable multipart mode - this disables built in support material and automatic 
// rendering of the parts

MultiPartMode = true;

colourPrimary = "Snow";
colourSecondary = "Green";

// Parts List for XC Assembly
// -----------------------------------------------------------------------------

// ~~ Part No. XB-CB-ABS01 ~~ (XC_CarriageBase.stl)
// ~~ Part No. XC-CB-MB01 ~~ (M3x10)
// ~~ Part No. XC-CB-MB02 ~~ (M3x10)
// ~~ Part No. XC-CB-MB03 ~~ (M3x10)
// ~~ Part No. XC-CB-MB04 ~~ (M3x10)
// ~~ Part No. XB-CB-ABS02 ~~ (XC_BeltClamp.stl)
// ~~ Part No. XC_BM-MB05 ~~ (M4x40)
// ~~ Part No. XC_BM-MB06 ~~ (M4x40)
// ~~ Part No. XC_BM-MB06 ~~ (M3x10)
// ~~ Part No. XC_BM-MB07 ~~ (M3x10)
// ~~ Part No. XC-HA-HOTENDS.COM-01 ~~ (J-Head from hotends.com)
// ~~ Part No. XC-HA-HOTENDS.COM-02 ~~ (J-Head from hotends.com)
// ~~ Part No. XC_CB-FAN01 ~~ (40mm fan)


// =============================================================================
// Render: XC_CarriageBracket_Front
// =============================================================================

//include <XC_CarriageBracket.scad>

//color("Black")
/*translate([rpXC_CarriageMount_BaseWidth / 2,0,10.1])
rotate([90,0,90])
	Part_XC_CarriageBracket_Front();*/
	
	
// =============================================================================
// Render: XC_CarriageBracket_Rear
// =============================================================================
	
include <XC_RearBracket.scad>	
	
color(colourPrimary)
translate([-rpXC_CarriageMount_BaseWidth  + rpXC_BeltMount_BoltHolderWidth,0,10.1])
rotate([90,0,90])
	Part_XC_RearBracket();
	
// =============================================================================
// Render: XC_BlowerCase
// =============================================================================

include <XC_BlowerCase.scad>

color(colourSecondary)
translate([-11,0,-24])
rotate([90,0,90])
	Part_XC_BlowerCase();

// =============================================================================
// Render: XC_CarriageBase
// =============================================================================

include <XC_CarriageBase.scad>

// ~~ Part No. XB-CB-ABS01 ~~ (XC_CarriageBase.stl)

// translate([-rpXC_CarriageMount_BaseWidth + rpXC_BeltMount_BoltHolderWidth ,0,0])

color(colourPrimary)
translate([-rpXC_CarriageMount_BaseWidth + rpXC_BeltMount_BoltHolderWidth ,0,10.1])
rotate([90,0,90])
	Part_XC_CarriageBase();

// Four Mounting Bolts

// ~~ Part No. XC-CB-MB01 ~~ (M3x10)
translate([0 - (hwLR_Carriage_BoltLength / 2), 0 - (hwLR_Carriage_BoltWidth / 2), 0 - hwLR_Carriage_BoltDepth])
	Draw_hw_Bolt_AllenHead(rpXC_CarriageMount_BoltSize, rpXC_CarriageMount_BoltLength);
	
// ~~ Part No. XC-CB-MB02 ~~ (M3x10)
translate([0 + (hwLR_Carriage_BoltLength / 2), 0 - (hwLR_Carriage_BoltWidth / 2),  0 - hwLR_Carriage_BoltDepth])
	Draw_hw_Bolt_AllenHead(rpXC_CarriageMount_BoltSize, rpXC_CarriageMount_BoltLength);
	
// ~~ Part No. XC-CB-MB03 ~~ (M3x10)
translate([0 - (hwLR_Carriage_BoltLength / 2), 0 + (hwLR_Carriage_BoltWidth / 2),  0 - hwLR_Carriage_BoltDepth])
	Draw_hw_Bolt_AllenHead(rpXC_CarriageMount_BoltSize, rpXC_CarriageMount_BoltLength);
	
// ~~ Part No. XC-CB-MB04 ~~ (M3x10)
translate([0 + (hwLR_Carriage_BoltLength / 2), 0 + (hwLR_Carriage_BoltWidth / 2),  0 - hwLR_Carriage_BoltDepth])
	Draw_hw_Bolt_AllenHead(rpXC_CarriageMount_BoltSize, rpXC_CarriageMount_BoltLength);
	
// =============================================================================
// Render: HA_CarriageBase
// =============================================================================	

include <XC_HotendMount.scad>

color(colourPrimary)
translate([10.5 + 4,0,10.1])
rotate([90,0,90])
	Part_HA_CarriageBase();

// =============================================================================
// Render: X-Endstop Microswitch
// =============================================================================

%translate([0 - (rpXC_BeltMount_BaseOffset) - 3,
			rpXC_BeltMount_BoltSpacing / 2 + 5,
			-10])
rotate([-90,180,0])
	import("../Vitamins/microswitch.stl", convexity = 3);
	
// =============================================================================
// Render: Print Cooling Fan
// =============================================================================

color("Black")
%translate([-19,
			5,
			-36])
rotate([0,180,90])
	import("../Vitamins/blower.stl", convexity = 3);
	
// =============================================================================
// Render: XC_CarriageBeltClamp
// =============================================================================


include <XC_BeltClamp.scad>

// ~~ Part No. XB-CB-ABS02 ~~ (XC_BeltClamp.stl)
color(colourPrimary)
translate([0 - (rpXC_BeltMount_BaseOffset),0,rpXC_BeltMount_BoltOffset])
rotate([-90,0,90])
	Part_XC_BeltClamp();
	
// Mount Bolts for belt clamp and hotend assembly

// upper bolts
// ~~ Part No. XC_BM-MB05 ~~ (M4x40)
translate([- rpXC_BeltMount_BoltDepth + rpXC_BeltMount_BaseOffset, 0 - (rpXC_BeltMount_BoltSpacing / 2), rpXC_BeltMount_BoltOffset])
	rotate([0,-90,180])
		Draw_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, rpXC_BeltMount_BoltLength);
		
// ~~ Part No. XC_BM-MB06 ~~ (M4x40)
translate([rpXC_BeltMount_BoltDepth- rpXC_BeltMount_BaseOffset, 0 + (rpXC_BeltMount_BoltSpacing / 2), rpXC_BeltMount_BoltOffset])
	rotate([0,-90,0])
		Draw_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, rpXC_BeltMount_BoltLength);
		
// lower bolts
translate([rpXC_BeltMount_BoltDepth- rpXC_BeltMount_BaseOffset - 5, 0 - (rpXC_BeltMount_BoltSpacing / 2), -rpXC_CarriageMount_LowerPointSpacing])
	rotate([0,-90,0])
		Draw_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, rpXC_BeltMount_BoltLength);
		
translate([rpXC_BeltMount_BoltDepth- rpXC_BeltMount_BaseOffset - 5, 0 + (rpXC_BeltMount_BoltSpacing / 2), -rpXC_CarriageMount_LowerPointSpacing])
	rotate([0,-90,0])
		Draw_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, rpXC_BeltMount_BoltLength);
		
// Belt clamp covers

include <XC_BeltCover.scad>	
color(colourSecondary)
translate([-11 - (rpXC_BeltMount_BaseOffset),13,rpXC_BeltMount_BoltOffset])
rotate([-90,0,-90])
	Part_XC_BeltCover();
	
color(colourSecondary)
translate([-11 - (rpXC_BeltMount_BaseOffset),-13,rpXC_BeltMount_BoltOffset])
rotate([-90,0,-90])
	Part_XC_BeltCover();
		
// Mount bolts for the belt clamp covers
		
// ~~ Part No. XC_BM-MB06 ~~ (M3x10)
translate([rpXC_BeltMount_ClampBoltDepth, 0 - (rpXC_BeltMount_ClampBoltSpacing / 2), rpXC_BeltMount_ClampBoltOffset])
	rotate([0,-90,0])
		Draw_hw_Bolt_AllenHead(rpXC_BeltMount_ClampBoltSize, rpXC_BeltMount_ClampBoltLength);
		
// ~~ Part No. XC_BM-MB07 ~~ (M3x10)
translate([rpXC_BeltMount_ClampBoltDepth, 0 + (rpXC_BeltMount_ClampBoltSpacing / 2), rpXC_BeltMount_ClampBoltOffset])
	rotate([0,-90,0])
		Draw_hw_Bolt_AllenHead(rpXC_BeltMount_ClampBoltSize, rpXC_BeltMount_ClampBoltLength);
		
// cover type bolts - experimental

*translate([24, 0, 4])
	rotate([0,90,0])
		Draw_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, 10);
		


// =============================================================================
// Placement: J Head Hotend
// =============================================================================
	
include <../Vitamins/hotend-jhead.scad>

// ~~~ Part No. XC-HA-HOTENDS.COM-01 ~~~ (J-Head from hotends.com)
%translate([hwHA_Hotend_Offset,
			-(hwHA_Hotend_Spacing /2),
			-hwHA_Hotend_VerticalOffset])
rotate([0,180,90])
	hotend_jhead();
	
// ~~~ Part No. XC-HA-HOTENDS.COM-02 ~~~ (J-Head from hotends.com)

%translate([hwHA_Hotend_Offset,
			(hwHA_Hotend_Spacing /2),
			-hwHA_Hotend_VerticalOffset])
rotate([0,180,90])
	hotend_jhead();
	
// pushfit
color("Gold")
%translate([hwHA_Hotend_Offset,
			(hwHA_Hotend_Spacing /2),
			9.5])
rotate([0,0,0])
import("../Vitamins/pushfit.stl", convexity=3);

color("Gold")
%translate([hwHA_Hotend_Offset,
			-(hwHA_Hotend_Spacing /2),
			9.5])
rotate([0,0,0])
import("../Vitamins/pushfit.stl", convexity=3);
	
// =============================================================================
// Placement: 40mm J Head Cooling Fan
// =============================================================================

include <../Vitamins/parametric-fan.scad>

// ~~ Part No. XC_CB-FAN01 ~~ (40mm fan)
%translate([hwHA_Fan_Offset,
			0,
			-23])	// 50% of the fan size
rotate([0,90,0])
	fan(40, 10, 32);
	
// mount bolts for fan
	

translate([	hwHA_Fan_Offset - 7.8, 
			16, 
			-7])
	rotate([0, 90,0])
		Draw_hw_Bolt_AllenHead(hwM3_Bolt_AllenHeadSize, 10);
		
translate([	hwHA_Fan_Offset - 7.8, 
			-16, 
			-7])
	rotate([0, 90,0])
		Draw_hw_Bolt_AllenHead(hwM3_Bolt_AllenHeadSize, 10);
		
translate([	hwHA_Fan_Offset - 7.8, 
			16, 
			-39])
	rotate([0, 90,0])
		Draw_hw_Bolt_AllenHead(hwM3_Bolt_AllenHeadSize, 10);
		
translate([	hwHA_Fan_Offset - 7.8, 
			-16, 
			-39])
	rotate([0, 90,0])
		Draw_hw_Bolt_AllenHead(hwM3_Bolt_AllenHeadSize, 10);

// =============================================================================
// Placement: HiWin Linear Rail System
// =============================================================================

// hiwin rail
%translate([0,
			0,
			-7])
rotate([0,0,90])
import("../Vitamins/hiwin12-rail.stl", convexity=3);	

// hiwin carriage
%translate([0,
			0,
			-4])
rotate([0,0,90])
import("../Vitamins/hiwin12-carriage.stl", convexity=3);	

// flat bar
%translate([-(19.1/2),
			-(540/2),
			-13.2])
cube(size=[	19.1, 540, 3.2]);




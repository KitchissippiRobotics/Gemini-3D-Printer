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

include <Dimensions.scad>

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



// =============================================================================
// Render: XC_CarriageBase
// =============================================================================

include <XC_CarriageBase.scad>

// ~~ Part No. XB-CB-ABS01 ~~ (XC_CarriageBase.stl)
color("FireBrick")
	translate([-rpXC_CarriageMount_BaseWidth + rpXC_BeltMount_BoltHolderWidth ,0,0])
	rotate([0,90,0])
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
// Render: X-Endstop Microswitch
// =============================================================================

%translate([0,0,0])
	import("./Vitamins/microswitch.stl", convexity = 10);
	
// =============================================================================
// Render: XC_CarriageBeltClamp
// =============================================================================

include <XC_BeltClamp.scad>

// ~~ Part No. XB-CB-ABS02 ~~ (XC_BeltClamp.stl)
color("DarkSlateGray")
	translate([0 - (rpXC_BeltMount_BaseOffset),0,rpXC_BeltMount_BoltOffset])
	rotate([0,-90,0])
	Part_XC_BeltClamp();
	
// Mount Bolts for belt clamp and hotend assembly

// ~~ Part No. XC_BM-MB05 ~~ (M4x40)
translate([rpXC_BeltMount_BoltDepth - rpXC_BeltMount_BaseOffset, 0 - (rpXC_BeltMount_BoltSpacing / 2), rpXC_BeltMount_BoltOffset])
	rotate([0,-90,0])
		Draw_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, rpXC_BeltMount_BoltLength);
		
// ~~ Part No. XC_BM-MB06 ~~ (M4x40)
translate([rpXC_BeltMount_BoltDepth- rpXC_BeltMount_BaseOffset, 0 + (rpXC_BeltMount_BoltSpacing / 2), rpXC_BeltMount_BoltOffset])
	rotate([0,-90,0])
		Draw_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, rpXC_BeltMount_BoltLength);
		
// Mount bolts for the belt clamp covers
		
// ~~ Part No. XC_BM-MB06 ~~ (M3x10)
translate([rpXC_BeltMount_ClampBoltDepth, 0 - (rpXC_BeltMount_ClampBoltSpacing / 2), rpXC_BeltMount_ClampBoltOffset])
	rotate([0,-90,0])
		Draw_hw_Bolt_AllenHead(rpXC_BeltMount_ClampBoltSize, rpXC_BeltMount_ClampBoltLength);
		
// ~~ Part No. XC_BM-MB07 ~~ (M3x10)
translate([rpXC_BeltMount_ClampBoltDepth, 0 + (rpXC_BeltMount_ClampBoltSpacing / 2), rpXC_BeltMount_ClampBoltOffset])
	rotate([0,-90,0])
		Draw_hw_Bolt_AllenHead(rpXC_BeltMount_ClampBoltSize, rpXC_BeltMount_ClampBoltLength);
		
		

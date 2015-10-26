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

// Global Constants
// =============================================================================

// Draw Main Box - This should be split into modules after testing is completed


    
// Carve out Bolt Holes

difference() { 
	translate([0,0,rpXC_CarriageMount_BlockHeight/2])
		cube(size = [20, 25, rpXC_CarriageMount_BlockHeight], center = true);
	union() {
		translate([0 - (hwLR_Carriage_BoltLength / 2), 0 - (hwLR_Carriage_BoltWidth / 2), 0 - hwLR_Carriage_BoltDepth])
			Carve_hw_Bolt_AllenHead(rpXC_CarriageMount_BoltSize, rpXC_CarriageMount_BoltLength, 5);
		
		translate([0 + (hwLR_Carriage_BoltLength / 2), 0 - (hwLR_Carriage_BoltWidth / 2),  0 - hwLR_Carriage_BoltDepth])
			Carve_hw_Bolt_AllenHead(rpXC_CarriageMount_BoltSize, rpXC_CarriageMount_BoltLength, 5);

		translate([0 - (hwLR_Carriage_BoltLength / 2), 0 + (hwLR_Carriage_BoltWidth / 2),  0 - hwLR_Carriage_BoltDepth])
			Carve_hw_Bolt_AllenHead(rpXC_CarriageMount_BoltSize, rpXC_CarriageMount_BoltLength, 5);

		translate([0 + (hwLR_Carriage_BoltLength / 2), 0 + (hwLR_Carriage_BoltWidth / 2),  0 - hwLR_Carriage_BoltDepth])
			Carve_hw_Bolt_AllenHead(rpXC_CarriageMount_BoltSize, rpXC_CarriageMount_BoltLength, 5);
	}
}
	
	
// Draw Four Bolt Positions

translate([0 - (hwLR_Carriage_BoltLength / 2), 0 - (hwLR_Carriage_BoltWidth / 2), 0 - hwLR_Carriage_BoltDepth])
	Draw_hw_Bolt_AllenHead(rpXC_CarriageMount_BoltSize, rpXC_CarriageMount_BoltLength);

translate([0 + (hwLR_Carriage_BoltLength / 2), 0 - (hwLR_Carriage_BoltWidth / 2),  0 - hwLR_Carriage_BoltDepth])
	Draw_hw_Bolt_AllenHead(rpXC_CarriageMount_BoltSize, rpXC_CarriageMount_BoltLength);

translate([0 - (hwLR_Carriage_BoltLength / 2), 0 + (hwLR_Carriage_BoltWidth / 2),  0 - hwLR_Carriage_BoltDepth])
	Draw_hw_Bolt_AllenHead(rpXC_CarriageMount_BoltSize, rpXC_CarriageMount_BoltLength);

translate([0 + (hwLR_Carriage_BoltLength / 2), 0 + (hwLR_Carriage_BoltWidth / 2),  0 - hwLR_Carriage_BoltDepth])
	Draw_hw_Bolt_AllenHead(rpXC_CarriageMount_BoltSize, rpXC_CarriageMount_BoltLength);
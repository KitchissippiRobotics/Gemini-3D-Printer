// *****************************************************************************
// ( )/ )(_  _)(_  _)___(  _ \(  _  )(  _ \(  _  )(_  _)(_  _)/ __)/ __)
//  )  (  _)(_   )( (___))   / )(_)(  ) _ < )(_)(   )(   _)(_( (__ \__ \
// (_)\_)(____) (__)    (_)\_)(_____)(____/(_____) (__) (____)\___)(___/
// *****************************************************************************
// Written by bcantin@kitchissippi-robotics.com
// Copyright (c) 2015 Kitchissippi Robotics
// -----------------------------------------------------------------------------
// XC_CarriageBase.scad
// Part No. XB-CB-ABS01
// Generates XC_CarriageBase.stl
// *****************************************************************************

include <Dimensions.scad>

// Default Usage:
// Part_XC_CarriageBase();


// -----------------------------------------------------------------------------

module Part_XC_CarriageBase() {
	translate([0,0,rpXC_CarriageMount_BaseWidth /2])
	rotate([0,-90,0]) {
	_XC_CarriageBase_Left();
	mirror([0,1,0])
		_XC_CarriageBase_Left();
	}
}

// -----------------------------------------------------------------------------

module _XC_CarriageBase_Left() {
	difference() { 
		// main box
		union() { // union()
		
			hull() { // hull()
				// base portion of the design
				translate([0 - (rpXC_CarriageMount_BaseWidth / 2),
						   0 - (rpXC_CarriageMount_BaseLength /2) ,
						   0])
					cube(size = [rpXC_CarriageMount_BaseWidth,
								 rpXC_CarriageMount_BaseLength /2,
								 rpXC_CarriageMount_BaseHeight - rpXC_CarriageMount_BaseBevelHeight],
						 center = false);

				// this cube is the top portion of the design
				translate([0 - (rpXC_CarriageMount_BaseWidth / 2),
						   0 - (rpXC_CarriageMount_BaseLength /2)+ rpXC_CarriageMount_BaseBevelDepth,
						   rpXC_CarriageMount_BaseHeight - rpXC_CarriageMount_BaseBevelHeight])
					cube(size = [rpXC_CarriageMount_BaseWidth - rpXC_CarriageMount_BaseBevelDepth,
								 rpXC_CarriageMount_BaseLength / 2 - rpXC_CarriageMount_BaseBevelDepth,
								 rpXC_CarriageMount_BaseBevelHeight], 
						 center = false);
			}
			
			
			hull() { // hull()
				// this cube is for creating the fill-in angles from the bolt holder
				translate([0 - (rpXC_CarriageMount_BaseWidth / 2)  - rpXC_BeltMount_BoltHolderWidth,
						   0 - (rpXC_BeltMount_BoltSpacing / 2) - (rpXC_BeltMount_BoltHolderDiameter /2),
						   0])
					cube(size = [rpXC_BeltMount_BoltHolderWidth,
								 (rpXC_BeltMount_BoltSpacing / 2) + (rpXC_BeltMount_BoltHolderDiameter /2), 
								 rpXC_BeltMount_BoltHolderWidth], 
						 center = false);
						 
				// this cube is for creating the fill-in angles from the bolt holder
				translate([0 - (rpXC_CarriageMount_BaseWidth / 2)  - rpXC_BeltMount_BoltHolderWidth,
						   0 - (rpXC_BeltMount_BoltSpacing / 2),
						   0])
					cube(size = [rpXC_BeltMount_BoltHolderWidth,
								 rpXC_BeltMount_BoltSpacing / 2, 
								 rpXC_BeltMount_BaseWidth], 
						 center = false);
		
				// bolt holder
				translate([0 - (rpXC_CarriageMount_BaseWidth / 2) - rpXC_BeltMount_BoltHolderWidth, 0 - (rpXC_BeltMount_BoltSpacing / 2), rpXC_BeltMount_BoltOffset])
					rotate([0,90,0])	
						cylinder(h = rpXC_BeltMount_BoltHolderWidth, d = rpXC_BeltMount_BoltHolderDiameter);
			}
		
		}
		
		// carve holes out of box for mounting bolts
		union() {
			translate([0 - (hwLR_Carriage_BoltLength / 2), 0 - (hwLR_Carriage_BoltWidth / 2), 0 - hwLR_Carriage_BoltDepth])
				Carve_hw_Bolt_AllenHead(rpXC_CarriageMount_BoltSize, rpXC_CarriageMount_BoltLength, 5);
		
			translate([0 + (hwLR_Carriage_BoltLength / 2), 0 - (hwLR_Carriage_BoltWidth / 2),  0 - hwLR_Carriage_BoltDepth])
				Carve_hw_Bolt_AllenHead(rpXC_CarriageMount_BoltSize, rpXC_CarriageMount_BoltLength, 5);

			translate([rpXC_BeltMount_BoltDepth, 0 - (rpXC_BeltMount_BoltSpacing / 2), rpXC_BeltMount_BoltOffset])
				rotate([0,90,0])
					Carve_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, rpXC_BeltMount_BoltLength);
		}
	}
}


		
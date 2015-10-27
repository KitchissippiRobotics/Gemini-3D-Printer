// *****************************************************************************
// ( )/ )(_  _)(_  _)___(  _ \(  _  )(  _ \(  _  )(_  _)(_  _)/ __)/ __)
//  )  (  _)(_   )( (___))   / )(_)(  ) _ < )(_)(   )(   _)(_( (__ \__ \
// (_)\_)(____) (__)    (_)\_)(_____)(____/(_____) (__) (____)\___)(___/
// *****************************************************************************
// Written by bcantin@kitchissippi-robotics.com
// Copyright (c) 2015 Kitchissippi Robotics
// -----------------------------------------------------------------------------
// XC_BeltClamp.scad
// Part No. XB-CB-ABS02
// Generates XC_BeltClamp.stl
// *****************************************************************************

include <Dimensions.scad>

// Default Usage:
//Part_XC_BeltClamp();


// -----------------------------------------------------------------------------

module Part_XC_BeltClamp() {
	_XC_BeltClamp_Left();
	mirror([0,1,0])
		_XC_BeltClamp_Left();
}

// -----------------------------------------------------------------------------

module _XC_BeltClamp_Left() {

	difference() {
		hull() {
			translate([0, rpXC_BeltMount_BoltSpacing /2, 0])
				cylinder(h = rpXC_BeltMount_BaseThickness, 
						 d = rpXC_BeltMount_BoltHolderDiameter);
			color("red")
			translate([0 - (rpXC_BeltMount_BaseWidth / 2),0,0])
				cube(size = [rpXC_CarriageMount_BaseWidth, 
							 rpXC_BeltMount_BaseLength / 2, 
							 rpXC_BeltMount_BaseThickness],
					center = false);
					
					
					
		}
	
		translate([0, 0 + (rpXC_BeltMount_BoltSpacing / 2), rpXC_BeltMount_BoltDepth])
			rotate([0,0,0])
				Carve_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, 
										rpXC_BeltMount_BoltLength);
	}
	
	translate([0 + ((rpXC_BeltMount_BaseWidth /2) -1.4), 0 , 0])
	cube(size = [2, rpXC_BeltMount_BaseLength / 2, 6], center = false);
	
	translate([0 - ((rpXC_BeltMount_BaseWidth /2)), 0 , 0])
	cube(size = [2, rpXC_BeltMount_BaseLength / 2, 6], center = false);
		 
}


		
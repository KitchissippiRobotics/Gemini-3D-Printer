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
// Part_XC_BeltClamp();


// -----------------------------------------------------------------------------

module Part_XC_BeltClamp() {
	_XC_BeltClamp_Left();
	mirror([0,1,0])
		_XC_BeltClamp_Left();
}

// -----------------------------------------------------------------------------

module _XC_BeltClamp_Left() {

	
	difference() {
		// base piece with belt clamp troughs
		union() {
			difference() {
		
				// This builds the base portion of the part
				hull() {
					translate([0, rpXC_BeltMount_BoltSpacing /2, 0])
						cylinder(h = rpXC_BeltMount_BaseThickness, 
								 d = rpXC_BeltMount_BoltHolderDiameter);

					translate([0 - (rpXC_BeltMount_BaseWidth / 2),0,0])
						cube(size = [rpXC_BeltMount_BaseWidth, 
									 rpXC_BeltMount_BaseLength / 2, 
									 rpXC_BeltMount_BaseThickness],
							center = false);
				}
			
				// carve out bolt hole
				translate([0, 0 + (rpXC_BeltMount_BoltSpacing / 2), rpXC_BeltMount_BoltDepth])
					rotate([0,0,0])
						Carve_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, 
												rpXC_BeltMount_BoltLength);
											
				// carve out nut trap
				// TODO: XB-CB-ABS02
			}
	
			// edge grooves to hold belts inline
			translate([- 2 + (rpXC_BeltMount_BaseWidth /2), 0 , 0])
				cube(size = [rpXC_BeltMount_ChannelEdgeWidth, 
							rpXC_BeltMount_BaseLength / 2,
							rpXC_BeltMount_ChannelEdgeHeight],
					center = false);
	
			translate([0 - ((rpXC_BeltMount_BaseWidth /2)), 0 , 0])
				cube(size = [rpXC_BeltMount_ChannelEdgeWidth,
							 rpXC_BeltMount_BaseLength / 2, 
							 rpXC_BeltMount_ChannelEdgeHeight],
					center = false);
			
			// centre groove to hold belts inline as well as bolt clamp covers to
			translate([0 - (rpXC_BeltMount_ChannelCenterWidth /2 ), 0 , 0])
				cube(size = [rpXC_BeltMount_ChannelCenterWidth,
							 rpXC_BeltMount_ChannelCenterLength / 2, 
							 rpXC_BeltMount_ChannelCenterHeight],
					center = false);
			
			// need module for belt teeth	
			// TODO: XB-CB-ABS02
		}
		// hole for clamp covers
		
		translate([0, 0 + (rpXC_BeltMount_ClampBoltSpacing / 2), 0])
			rotate([0,0,0])
				Carve_hw_Bolt_AllenHead(rpXC_BeltMount_ClampBoltSize, 
										rpXC_BeltMount_ClampBoltLength);
	}
		
				
	
		 
}

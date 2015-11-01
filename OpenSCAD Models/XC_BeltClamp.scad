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

// Determine if MultiPartMode is enabled - if not, render the part automatically
// and enable support material (if it is defined)

if (MultiPartMode == undef) {
	MultiPartMode = false;
	EnableSupport = true;
	
	Part_XC_BeltClamp();
} else {
	EnableSupport = false;
}

// -----------------------------------------------------------------------------

module Part_XC_BeltClamp() {
	_XC_BeltClamp_Left();
	mirror([0,1,0])
		_XC_BeltClamp_Left();
}

// -----------------------------------------------------------------------------

module _GT2_BeltTeeth(_beltLength, _toothDepth) {
	_toothSize = 1;		// unsophisticated 1mm teeth design
	_beltWidth = 6.2;
	
	for (i = [0 : 2 : _beltLength]) {
		translate([0, i * _toothSize, 0])
			cube(size=[	_beltWidth, _toothSize, _toothDepth]);
	}
	
	translate([0, 0, 1])
		cube(size=[_beltWidth, _beltLength, _toothDepth - _toothSize]);
}

// -----------------------------------------------------------------------------

module _XC_BeltClamp_Left() {

	
	difference() {
		// base piece with belt clamp troughs
		union() { // union()
			difference() { // difference
		
				// This builds the base portion of the part
				hull() { // hull()
					translate([	0,
								rpXC_BeltMount_BoltSpacing /2,
								0])
						cylinder(	h = rpXC_BeltMount_BaseThickness, 
								 	d1 = rpXC_BeltMount_BoltHolderDiameter + rpXC_BeltMount_CoverOffset,
								 	d2 = rpXC_BeltMount_BoltHolderDiameter);

					translate([0 - (rpXC_BeltMount_BaseWidth / 2) - (rpXC_BeltMount_CoverOffset/2),0,0])
						cube(size = [	rpXC_BeltMount_BaseWidth  + rpXC_BeltMount_CoverOffset, 
									 	rpXC_BeltMount_BaseLength /2, 
									 	rpXC_BeltMount_BaseThickness],
							center = false);
							
					// edge grooves to hold belts inline
					translate([	-2 +(rpXC_BeltMount_BaseWidth /2),
								0, 
								0])
						cube(size = [	rpXC_BeltMount_ChannelEdgeWidth, 
										rpXC_BeltMount_BaseLength /2,
										rpXC_BeltMount_ChannelEdgeHeight],
					center = false);
					
					translate([	0 - ((rpXC_BeltMount_BaseWidth /2)),
								0,
								0])
						cube(size = [	rpXC_BeltMount_ChannelEdgeWidth,
									 	rpXC_BeltMount_BaseLength /2, 
									 	rpXC_BeltMount_ChannelEdgeHeight],
							center = false);
							
					// centre groove to hold belts inline as well as to bolt clamp covers to
					translate([	0 - (rpXC_BeltMount_ChannelCenterWidth /2 ),
								0, 
								0])
						cube(size = [	rpXC_BeltMount_ChannelCenterWidth,
									 	rpXC_BeltMount_ChannelCenterLength /2, 
									 	rpXC_BeltMount_ChannelCenterHeight],
							center = false);
				}
			

											
				// carve out nut trap
				// TODO: XB-CB-ABS02
			}
	
			// edge grooves to hold belts inline

			*translate([	-(rpXC_BeltMount_BaseWidth /2),
							0, 
							0])
				cube(size = [rpXC_BeltMount_BoltHolderDiameter,
							 rpXC_BeltMount_BaseLength / 2, 
							 rpXC_BeltMount_ChannelEdgeHeight],
					center = false);
			
			// centre groove to hold belts inline as well as bolt clamp covers to
			*translate([0 - (rpXC_BeltMount_ChannelCenterWidth /2 ), 0 , 0])
				cube(size = [rpXC_BeltMount_ChannelCenterWidth,
							 rpXC_BeltMount_ChannelCenterLength / 2, 
							 rpXC_BeltMount_ChannelCenterHeight],
					center = false);
			

			
		}

		// carve outs for hardware		
		union() { // union()
		
			_centerSpace = 5;
		
			// carve teeth to hold belts inline (upper)
			translate([(rpXC_BeltMount_BaseWidth / 4) - 3.1,
						_centerSpace,
						rpXC_BeltMount_BaseThickness])
				_GT2_BeltTeeth(30, 5);
				
			translate([(rpXC_BeltMount_BaseWidth / 4) - 3.1,
						_centerSpace - 0.2,
						rpXC_BeltMount_BaseThickness +2])
			rotate([0,90,0])
				cylinder( h = 6.2,
						  d = 4,
						  $fn = gcFacetSmall);
				
			// carve teeth to hold belts inline (lower)
			translate([-(rpXC_BeltMount_BaseWidth / 4) - 3.1,
						_centerSpace,
						rpXC_BeltMount_BaseThickness])
				_GT2_BeltTeeth(30, 5);
				
			translate([-(rpXC_BeltMount_BaseWidth / 4) - 3.1,
						_centerSpace - 0.2,
						rpXC_BeltMount_BaseThickness +2])
			rotate([0,90,0])
				cylinder( h = 6.2,
						  d = 4,
						  $fn = gcFacetSmall);
						  
			// groove for fitting clamps (lower)
			translate([- (rpXC_BeltMount_BaseWidth/2 + rpXC_BeltMount_CoverOffset /2), _centerSpace , rpXC_BeltMount_BaseThickness - rpXC_BeltMount_CoverOffset])
				cube(size = [rpXC_BeltMount_CoverOffset,
							 rpXC_BeltMount_ChannelCenterLength / 4, 
							 rpXC_BeltMount_CoverOffset],
					center = false);
					
			// groove for fitting clamps (upper)	
			translate([(rpXC_BeltMount_BaseWidth/2 - rpXC_BeltMount_CoverOffset/2), _centerSpace , rpXC_BeltMount_BaseThickness - rpXC_BeltMount_CoverOffset])
				cube(size = [rpXC_BeltMount_CoverOffset,
							 rpXC_BeltMount_ChannelCenterLength / 4, 
							 rpXC_BeltMount_CoverOffset],
					center = false);
					
			// slot for fitting clamps (upper)
			translate([(rpXC_BeltMount_BaseWidth/2 - rpXC_BeltMount_CoverOffset/2) + 2, 0 , rpXC_BeltMount_BaseThickness - rpXC_BeltMount_CoverOffset +2])
				cube(size = [rpXC_BeltMount_CoverOffset,
							 rpXC_BeltMount_ChannelCenterLength / 4 + _centerSpace, 
							 rpXC_BeltMount_BaseThickness],
					center = false);
			
			// slot for fitting cover (upper)
			translate([(rpXC_BeltMount_BaseWidth/2 - rpXC_BeltMount_CoverOffset/2) + 2, 0 , -rpXC_BeltMount_BaseThickness + rpXC_BeltMount_CoverOffset ])
				cube(size = [rpXC_BeltMount_CoverOffset,
							 rpXC_BeltMount_ChannelCenterLength / 2 + _centerSpace, 
							 rpXC_BeltMount_BaseThickness * 2],
					center = false);
					
			// slot for fitting clamps (lower)
			translate([- (rpXC_BeltMount_BaseWidth/2 + rpXC_BeltMount_CoverOffset /2) - 2, 0 , rpXC_BeltMount_BaseThickness - rpXC_BeltMount_CoverOffset +2])
				cube(size = [rpXC_BeltMount_CoverOffset,
							 rpXC_BeltMount_ChannelCenterLength /4 + _centerSpace, 
							 rpXC_BeltMount_BaseThickness],
					center = false);
		
			// bolt holder for clamping to base
			translate([0, 0 + (rpXC_BeltMount_ClampBoltSpacing / 2), 0])
			rotate([0,0,0])
				Carve_hw_Bolt_AllenHead(rpXC_BeltMount_ClampBoltSize, 
										rpXC_BeltMount_ClampBoltLength);
										
			// carve out bolt hole
			translate([0, 
						0 + (rpXC_BeltMount_BoltSpacing / 2), 
						-rpXC_BeltMount_BoltDepth])
				Carve_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, 
										rpXC_BeltMount_BoltLength,
										10);
		}
	}
		
				
	
		 
}

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

// include <Dimensions.scad> - included from XC_Common.scad
include <XC_Common.scad>

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

module _XCBC_BeltMount() {
	hull() {	
		// right belt clamp base
	
		translate([-20, 7, 0])
		cylinder(h = rpXC_BeltMount_BaseThickness + 2, d = 5);
		
		translate([-20, -7, 0])
		cylinder(h = rpXC_BeltMount_BaseThickness + 2, d = 5);
		
		translate([-4.5, 7, 0])
		cylinder(h = rpXC_BeltMount_BaseThickness + 2, d = 6);
		
		translate([-4.5, -7, 0])
		cylinder(h = rpXC_BeltMount_BaseThickness + 2, d = 6);
		
		// right belt clamp base
	
		translate([-20, 7, 2.0])
		cylinder(h = rpXC_BeltMount_BaseThickness - 1.5, d = 6);
		
		translate([-20, -7, 2.0])
		cylinder(h = rpXC_BeltMount_BaseThickness - 1.5, d = 6);
		
		translate([-4.5, 7, 2.0])
		cylinder(h = rpXC_BeltMount_BaseThickness - 1.5, d = 8);
		
		translate([-4.5, -7, 2.0])
		cylinder(h = rpXC_BeltMount_BaseThickness - 1.5, d = 8);
	}
}

module _XCBC_BeltCarveOut() {
		// --- belt path carve out : right side
		
		translate([-31.1, 1.9, rpXC_BeltMount_BaseThickness])
		cube([10, 6.2, 2.1]);
		
		translate([-31.1, -8.1, rpXC_BeltMount_BaseThickness])
		cube([10, 6.2, 2.1]);
		
		// carve teeth to hold belts inline (lower)
		translate([-(rpXC_BeltMount_BaseWidth / 4), 1.9, rpXC_BeltMount_BaseThickness])
		rotate([0,0,90])
		_GT2_BeltTeeth(15, 5.25);
		
		translate([-4.75,-1.9,rpXC_BeltMount_BaseThickness + 1.5])
		rotate([90,0,0])
		cylinder(h = 6.2, d = 3);
		
		translate([-4.75, 8.1,rpXC_BeltMount_BaseThickness + 1.5])
		rotate([90,0,0])
		cylinder(h = 6.2, d = 3);
		
		// carve teeth to hold belts inline (upper)
		translate([-(rpXC_BeltMount_BaseWidth / 4), -8.1, rpXC_BeltMount_BaseThickness])
		rotate([0,0,90])
		_GT2_BeltTeeth(15, 5.25);
		
		// --- carve outs for clamp
		hull() {
			translate([-8, 9.0, -0.1])
				cylinder(h = 10, d = 2);
			translate([-18, 9.0, -0.1])
				cylinder(h = 10, d = 2);
				
			translate([-8, 11.25, -0.1])
				cylinder(h = 10, d = 2);
			translate([-18, 11.25, -0.1])
				cylinder(h = 10, d = 2);
		}
		
		hull() {
			translate([-8, -9.0, -0.1])
				cylinder(h = 10, d = 2);
			translate([-18, -9.0, -0.1])
				cylinder(h = 10, d = 2);
				
			translate([-8, -11.25, -0.1])
				cylinder(h = 10, d = 2);
			translate([-18, -11.25, -0.1])
				cylinder(h = 10, d = 2);
		}
	}
	
module Part_XC_ClampCover() {
	difference() {
		union() {
			// upper tab
			hull() {
				translate([-8, 8.6, 0])
					cylinder(h = 10, d = 1.0);
				translate([-18, 8.6, 0])
					cylinder(h = 10, d = 1.0);
			
				translate([-8, 11.25, 0])
					cylinder(h = 10, d = 1.0);
				translate([-18, 11.25, 0])
					cylinder(h = 10, d = 1.0);
			
			
				translate([-8, 9.0, 2])
					cylinder(h = 6, d = 1.6);
				translate([-18, 9.0, 2])
					cylinder(h = 6, d = 1.6);
			
				translate([-8, 11.25, 2])
					cylinder(h = 6, d = 1.6);
				translate([-18, 11.25, 2])
					cylinder(h = 6, d = 1.6);
			}
	
			// lower tab
			hull() {
				translate([-8, -8.6, 0])
					cylinder(h = 11, d = 1.0);
				translate([-18, -8.6, 0])
					cylinder(h = 11, d = 1.0);
			
				translate([-8, -11.25, 0])
					cylinder(h = 11, d = 1.0);
				translate([-18, -11.25, 0])
					cylinder(h = 11, d = 1.0);
			
			
				translate([-8, -9.0, 2])
					cylinder(h = 6, d = 1.6);
				translate([-18, -9.0, 2])
					cylinder(h = 6, d = 1.6);
			
				translate([-8, -11.25, 2])
					cylinder(h = 6, d = 1.6);
				translate([-18, -11.25, 2])
					cylinder(h = 6, d = 1.6);
			}
	
	
			// main cover	
			hull() {

			
				translate([-8, 11.25, 8])
					cylinder(h = 1, d = 1.6);
				translate([-18, 11.25, 8])
					cylinder(h = 1, d = 1.6);
			
			
				translate([-8, -11.25, 8])
					cylinder(h = 1, d = 1.6);
				translate([-18, -11.25, 8])
					cylinder(h = 1, d = 1.6);
			
				translate([-8, 11.25, 9])
					cylinder(h = 2, d = 1);
				translate([-18, 11.25, 9])
					cylinder(h = 2, d = 1);
			
			
				translate([-8, -11.25, 9])
					cylinder(h = 2, d = 1);
				translate([-18, -11.25, 9])
					cylinder(h = 2, d = 1);

			}
		}
		
		translate([-19,-2.2,6])
		cube([12,4.4,2]);
		
		translate([-19,-8.1,6.5])
		cube([12,6.1,2]);
		
		translate([-19,2.0,6.5])
		cube([12,6.1,2]);
		
		translate([-13.5, 0,0])
		cylinder(d = 4, h = 20);
	}
	
	// raised bit to press on belt upper
	hull() {
		translate([-17, -6.5, 9]) 
			sphere(h= 4);
			
		translate([-9, -6.5, 9]) 
			sphere(h= 4);
			
		translate([-17, -3.5, 9]) 
			sphere(h= 4);
			
		translate([-9, -3.5, 9]) 
			sphere(h= 4);
	}
	
	// raised bit to press on belt lower
	hull() {
		translate([-17, 6.5, 9.0]) 
			sphere(h= 4);
			
		translate([-9, 6.5, 9.0]) 
			sphere(h= 4);
			
		translate([-17, 3.5, 9.0]) 
			sphere(h= 4);
			
		translate([-9, 3.5, 9.0]) 
			sphere(h= 4);
	}
}

// -----------------------------------------------------------------------------

module Part_XC_BeltClamp() {

	// build up the clamp base and then carve out the bolts, belt teeth, etc.
	difference() {
	
		// ---- main body
		union() {
			// --- bolt post bases - joined together
			hull() {
				// top right assembly bolt mount base
				translate([rpXC_UpperMount_BoltSpacing/2, 0, rpXC_BeltMount_BaseThickness - 4]) 
					_BoltBase(hwM4_Bolt_AllenHeadDiameter - 2, 4, BBStyle_Round);
					
				// top left assembly bolt mount base
				translate([-rpXC_UpperMount_BoltSpacing/2, 0,rpXC_BeltMount_BaseThickness -  4]) 
					_BoltBase(hwM4_Bolt_AllenHeadDiameter - 2, 4, BBStyle_Round);
					
				// top left assembly bolt mount base
				translate([-rpXC_UpperMount_BoltSpacing/2, 0, 0])
					cylinder(h = 1,	d = hwM4_Bolt_ShaftDiameter + gcMachineOffset + minimumThickness);
		
				// top right assembly bolt mount base
				translate([rpXC_UpperMount_BoltSpacing/2, 0, 0])
					cylinder(h = 1,	d = hwM4_Bolt_ShaftDiameter + gcMachineOffset + minimumThickness);
			
			translate([-4.5, 7, 0])
			cylinder(h = 3, d = 8);
		
			translate([4.5, 7, 0])
			cylinder(h = 3, d = 8);
			
			}
		
			
			_XCBC_BeltMount();
			mirror([1,0,0]) 
				_XCBC_BeltMount();
				
			
			
			
		}
		
		// ---- carve outs
		
		
		_XCBC_BeltCarveOut();
		mirror([1,0,0])
			_XCBC_BeltCarveOut();
		
		
		// --- mounting hardware carveouts
		union() {
			// -- carve out main mounting holes
		
			// left mounting hole
			translate([rpXC_UpperMount_BoltSpacing / 2, 0, -rpXC_BeltMount_BoltDepth + 15])
				Carve_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, rpXC_BeltMount_BoltLength, 10);
				
				
			translate([rpXC_UpperMount_BoltSpacing / 2, 0, 4])
			cylinder(h = 5, d = 8.6, $fn = 6);
			
			translate([-rpXC_UpperMount_BoltSpacing / 2, 0, 4])
			cylinder(h = 5, d = 8.6, $fn = 6);
									
			// right mounting hole
			translate([-rpXC_UpperMount_BoltSpacing / 2, 0, -rpXC_BeltMount_BoltDepth + 15])
				Carve_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, rpXC_BeltMount_BoltLength, 10);
				
			// -- carve out clamp mounting holes
			
			// left clamp bolt
			translate([-rpXC_BeltMount_ClampBoltSpacing / 2, 0, 6])
				Carve_hw_Bolt_AllenHead(rpXC_BeltMount_ClampBoltSize, rpXC_BeltMount_ClampBoltLength);
				
			// right clamp bolt
			translate([rpXC_BeltMount_ClampBoltSpacing / 2, 0, 6])
				Carve_hw_Bolt_AllenHead(rpXC_BeltMount_ClampBoltSize, rpXC_BeltMount_ClampBoltLength);
			
			// -- carve out clamp mounting nuts
			
			// left clamp nut
			translate([-rpXC_BeltMount_ClampBoltSpacing / 2, 0, 2.5])
			rotate([0,0,-45])
				cylinder(h = 3, d = 6.6, $fn = 6);
				
			translate([-rpXC_BeltMount_ClampBoltSpacing / 2, 0, -0.1])
			rotate([0,0,-45])
				cylinder(h = 2.7, d1 = 7.6, d2 = 6.6, $fn = 6);
				
			// right clamp nut
			translate([rpXC_BeltMount_ClampBoltSpacing / 2, 0, 2.5])
			rotate([0,0,45])
				cylinder(h = 3, d = 6.6, $fn = 6);
				
			translate([rpXC_BeltMount_ClampBoltSpacing / 2, 0, -0.1])
			rotate([0,0,45])
				cylinder(h = 2.7, d1 = 6.8, d2 = 6.6, $fn = 6);
				
			// wiring channel
			hull() {
			translate([0,0,-1])
				sphere(d = 6);
				
			translate([3,12,0])
				sphere(d = 4);
				
			translate([-3,12,0])
				sphere(d = 4);
			}
		
		}
		

		
		

	}

}

module _XCBC_BoltPosts() {
// top left assembly bolt mount base
	translate([-boltSpacing/2, 0, 0]) {
		*_BoltBase(boltDiameter + rpDefaultBevel, _baseThickness, baseBBStyle);
		_BoltBase(boltDiameter + rpDefaultBevel, _baseThickness - 2.05, BBStyle_Round);
	}

// top left assembly bolt mount base
	*translate([boltSpacing/2, 0, 0]) {
		_BoltBase(boltDiameter + rpDefaultBevel, _baseThickness, baseBBStyle);
		_BoltBase(boltDiameter + rpDefaultBevel * 2, _baseThickness - rpDefaultBevel + 0.15, BBStyle_Round);
	}										
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
		cube(size=[_beltWidth, _beltLength + 10, _toothDepth - _toothSize]);
}

// -----------------------------------------------------------------------------

module _XC_BeltClamp_Left() {

	
	difference() {
		// base piece with belt clamp troughs
		union() { // union()
		
			
		
			difference() { // difference
			
			
			
		
				// This builds the base portion of the part
				hull() { // hull()
					*translate([	0,
								rpXC_BeltMount_BoltSpacing /2,
								0])
						cylinder(	h = rpXC_BeltMount_BaseThickness, 
								 	d1 = rpXC_BeltMount_BoltHolderDiameter + rpXC_BeltMount_CoverOffset,
								 	d2 = rpXC_BeltMount_BoltHolderDiameter);

					*translate([0 - (rpXC_BeltMount_BaseWidth / 2) - (rpXC_BeltMount_CoverOffset/2),0,0])
						cube(size = [	rpXC_BeltMount_BaseWidth  + rpXC_BeltMount_CoverOffset, 
									 	rpXC_BeltMount_BaseLength /2 - 6, 
									 	rpXC_BeltMount_BaseThickness],
							center = false);
							
					// edge grooves to hold belts inline
					*translate([	-2 +(rpXC_BeltMount_BaseWidth /2),
								0, 
								0])
						cube(size = [	rpXC_BeltMount_ChannelEdgeWidth, 
										rpXC_BeltMount_BaseLength /2 - 6,
										rpXC_BeltMount_ChannelEdgeHeight - 3],
					center = false);
					
					*translate([	0 - ((rpXC_BeltMount_BaseWidth /2)),
								0,
								0])
						cube(size = [	rpXC_BeltMount_ChannelEdgeWidth,
									 	rpXC_BeltMount_BaseLength /2 - 6, 
									 	rpXC_BeltMount_ChannelEdgeHeight - 3],
							center = false);
							
					// centre groove to hold belts inline as well as to bolt clamp covers to
					*translate([	0 - (rpXC_BeltMount_ChannelCenterWidth /2 ),
								0, 
								0])
						cube(size = [	rpXC_BeltMount_ChannelCenterWidth,
									 	rpXC_BeltMount_ChannelCenterLength /2 - 3, 
									 	rpXC_BeltMount_ChannelCenterHeight - 3.25],
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
			
			rotate([0,0,90])
					_XCBC_BoltPosts();
			
		}

		// carve outs for hardware		
		union() { // union()
		
			_centerSpace = 5;
		
			// carve teeth to hold belts inline (upper)
			translate([(rpXC_BeltMount_BaseWidth / 4) - 3.1,
						_centerSpace,
						rpXC_BeltMount_BaseThickness])
				_GT2_BeltTeeth(15, 5.25);
				
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
				_GT2_BeltTeeth(15, 5.25);
				
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
			translate([0, 0 + (rpXC_BeltMount_ClampBoltSpacing / 2) + 5, 0])
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

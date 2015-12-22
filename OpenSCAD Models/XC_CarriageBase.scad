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
// -----------------------------------------------------------------------------
// Note that there is some rotation done in the part module - this part started
// it's design with a different print orientation than it currently has.
// *****************************************************************************

// Revision & Design Notes
// v3.0.1: Initial 3-point test
// v3.1.0: Alternate design, automatic angle calculation, switch and fan holder test
// v3.1.1: Built on alternative design
//		- lay down base components, switch mount, bolt mount points, base of fan mount and then combine those
//		- place bolt posts and fan mount components onto this base
//		- carve out bolt holes from this part
//		- airflow and wire routing considerations?
//		x revise belt clamp component to match
//		x revise hotend mount to match
// v3.1.2: Based on above build concepts the shape has changed - triangle math is obselete
// v3.2.0: Yet another rewrite:
//		- Revert to original 3-point locating scheme
//		- blower fan holder and output vents included
//		- 

// include <Dimensions.scad> - included from XC_Common.scad
include <XC_Common.scad>

// -----------------------------------------------------------------------------
// Default Usage:	
// Part_XC_CarriageBase();

// Determine if MultiPartMode is enabled - if not, render the part automatically
// and enable support material (if it is defined)

if (MultiPartMode == undef) {
	MultiPartMode = false;
	EnableSupport = true;
	
	Part_XC_CarriageBase();
} else {
	EnableSupport = false;
}

// -----------------------------------------------------------------------------
// Just Draw the bolt bases
// -----------------------------------------------------------------------------

module _XCCB_BoltBases(baseBBStyle) {


	// top left assembly bolt mount base
	translate([-boltSpacing/2, 0, 0]) {
		_BoltBase(boltDiameter + rpDefaultBevel, _baseThickness, baseBBStyle);
		_BoltBase(boltDiameter + rpDefaultBevel * 2, _baseThickness - rpDefaultBevel, BBStyle_Round);
	}
	
	// top right assembly bolt mount base
	translate([boltSpacing/2, 0, 0]) {
		_BoltBase(boltDiameter + rpDefaultBevel, _baseThickness, baseBBStyle);
		_BoltBase(boltDiameter + rpDefaultBevel * 2, _baseThickness - rpDefaultBevel, BBStyle_Round);
	}
	
	// bottom center assembly bolt mount base
	translate([0, -lowerBoltOffset, 0]) {
		_BoltBase(boltDiameter + rpDefaultBevel, _baseThickness, baseBBStyle);
		_BoltBase(boltDiameter + rpDefaultBevel * 2, _baseThickness - rpDefaultBevel, BBStyle_Round);
	}
	
	
	// switch holder lower screw base
	hull() {
		translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset - hwMicroSwitch_HoleSpacing /2, 0])
			_BoltBase(hwMicroSwitch_ScrewHeadDiameter, _baseThickness, BBStyle_Round);
	
		// switch holder upper screw base
		translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset + hwMicroSwitch_HoleSpacing /2, 0])
			_BoltBase(hwMicroSwitch_ScrewHeadDiameter, _baseThickness, BBStyle_Round);
	}
}

// -----------------------------------------------------------------------------
// creates a shape for clearance of the linear rail to be carved out of the part
// -----------------------------------------------------------------------------

module _HIWINClearance() {
	
				
	union() {
			// cut out space for Hiwin carriage, clearance of the bar and mount bolts
			
	// carriage carve out
				translate([	0,
							-25,
							rpXC_CarriageMount_BaseWidth /2 - rpXC_BeltMount_BoltHolderWidth])
					cube(size= [9,
								50,
								rpXC_CarriageMount_BaseWidth],
						center = false);		
			hull() {
			
	translate([2, 50,7])
	rotate([90,0,0])
				cylinder(h = 100, d = 4);
				
	translate([1, 50,35])
	rotate([90,0,0])
				cylinder(h = 100, d = 4);			
				
	translate([15,50,7])
	rotate([90,0,0])
				cylinder(h = 100, d = 4);
	translate([15,50,35])
	rotate([90,0,0])
				cylinder(h = 100, d = 4);
				
			
				
					
				// bar carve out

				translate([11.5,
							0,
							rpXC_CarriageMount_BaseWidth /2 + 5.5])
					cube(size= [3.2,
								100,
								rpXC_CarriageMount_BaseWidth],
						center = true);
			
				translate([11.5,
							0,
							rpXC_CarriageMount_BaseWidth /2 + 5.5])
					cube(size= [5,
								100,
								rpXC_CarriageMount_BaseWidth],
						center = true);
			
				// clearance for bar/rail mounting bolts	
				translate([16.5,
							0,
							rpXC_CarriageMount_BaseWidth /2 + 5.5])
					cube(size= [5,
								100,
								3],
						center = true);

			}
}
}

// -----------------------------------------------------------------------------
// Just Draw the skeleton frame between the bolt bases
// -----------------------------------------------------------------------------

module _XCCB_BoltSkeleton(baseBBStyle) {

		*hull() {
			translate([boltSpacing/2, 0, 0])
				_BoltBase(boltDiameter /2, _baseThickness - rpDefaultBevel, baseBBStyle);
				
			
			translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset + hwMicroSwitch_HoleSpacing /2, 0])
				_BoltBase(boltDiameter /2, _baseThickness - rpDefaultBevel, baseBBStyle);
		}
		
		*hull() {
			translate([0, -lowerBoltOffset, 0])
				_BoltBase(boltDiameter /3, _baseThickness - rpDefaultBevel, baseBBStyle);
				
			translate([switchXOffset + 2, -lowerBoltOffset + 5, 0])
				_BoltBase(boltDiameter /3, _baseThickness - rpDefaultBevel, baseBBStyle);
		}
		
		*hull() {
			translate([0, -lowerBoltOffset, 0])
				_BoltBase(boltDiameter /3, _baseThickness - rpDefaultBevel, baseBBStyle);
				
			translate([-switchXOffset - 2, -lowerBoltOffset + 5, 0])
				_BoltBase(boltDiameter /3, _baseThickness - rpDefaultBevel, baseBBStyle);
		}
		
		hull() {
			translate([boltSpacing/2, 0, 0])
			_BoltBase(boltDiameter /2, _baseThickness - rpDefaultBevel, baseBBStyle);
			translate([0, -lowerBoltOffset, 0])
			_BoltBase(boltDiameter /2, _baseThickness - rpDefaultBevel, baseBBStyle);
		}
		
		hull() {
			translate([-boltSpacing/2, 0, 0])
			_BoltBase(boltDiameter /2, _baseThickness - rpDefaultBevel, baseBBStyle);
			translate([0, -lowerBoltOffset, 0])
			_BoltBase(boltDiameter /2, _baseThickness - rpDefaultBevel, baseBBStyle);
		}
		
		*hull() {
		// top left assembly bolt mount base
		translate([-boltSpacing/2, 0, 0])
			_BoltBase(boltDiameter /2, _baseThickness - rpDefaultBevel, baseBBStyle);
			
		// top right assembly bolt mount base
		translate([boltSpacing/2, 0, 0])
			_BoltBase(boltDiameter /2, _baseThickness - rpDefaultBevel, baseBBStyle);
		}

	
}

// -----------------------------------------------------------------------------
// Just Draw the bolt posts
// -----------------------------------------------------------------------------

module _XCCB_BoltPosts() {
	// top left assembly bolt mount base
	translate([-boltSpacing/2, 0, 0])
		cylinder(h = 26,d2 = hwM4_Bolt_ShaftDiameter + gcMachineOffset + gRender_Clearance + minimumThickness - bevelSize /2,
						d1 = hwM4_Bolt_ShaftDiameter + gcMachineOffset + gRender_Clearance + minimumThickness);
		
	// top right assembly bolt mount base
	translate([boltSpacing/2, 0, 0])
		cylinder(h = 26,d2 = hwM4_Bolt_ShaftDiameter + gcMachineOffset + gRender_Clearance + minimumThickness - bevelSize /2,
						d1 = hwM4_Bolt_ShaftDiameter + gcMachineOffset + gRender_Clearance + minimumThickness);

	// bottom center assembly bolt mount base
	translate([0, -lowerBoltOffset, 0])
		cylinder(h = 26,d2 = hwM4_Bolt_ShaftDiameter + gcMachineOffset + gRender_Clearance + minimumThickness - bevelSize /2,
						d1 = hwM4_Bolt_ShaftDiameter + gcMachineOffset + gRender_Clearance + minimumThickness);
}

// -----------------------------------------------------------------------------
// Wiring Access hole at top of carriage
// -----------------------------------------------------------------------------

module _XCCB_WiringAccessHole() {
	hull() {
		translate([6, 12, 7])
		rotate([90,0,0])
		cylinder(h = 10, d = 6);

		translate([-6, 12, 7])
		rotate([90,0,0])
		cylinder(h = 10, d = 6);

		translate([6, 12, 30])
		rotate([90,0,0])
		cylinder(h = 10, d = 6);

		translate([-6, 12, 30])
		rotate([90,0,0])
		cylinder(h = 10, d = 6);
	}
}

// -----------------------------------------------------------------------------
// Blower Fan Carvout
// -----------------------------------------------------------------------------

module _XCCB_BlowerSpace() {

	// additional blower air exit space
	translate([-10.5, -52.5, 0])
	cube([19, 15, 26]);

	// main blower channel
	translate([-12, -53.5, 0])
	cube([22, 17, 25]);
	
	// main blower body
	translate([-18,-36.25,-5])
	rotate([90,0,0])
	cylinder(h = 17, d = 57);
	
	// intake clearance
	translate([-18,-42,-5])
	rotate([90,0,0])
	cylinder(h = 32, d = 36);
	
	// mounting clearance
	*translate([-45, -53, 0])
	cube([20, 17, 24]);
	
	hull() {
		translate([6, -60, 27])
		rotate([90,0,90])
		cylinder(h = 11, d = 3);
	
		translate([0, -38, 25])
		rotate([90,0,90])
		cylinder(h = 8, d = 3);
		
		translate([0, -52, 24])
		rotate([90,0,90])
		cylinder(h = 8, d = 2);
	}
	
	hull() {
		translate([-18, -60, 27])
		rotate([90,0,90])
		cylinder(h = 11, d = 3);
	
		translate([-11, -38, 25])
		rotate([90,0,90])
		cylinder(h = 10, d = 3);
		
		translate([-11, -52, 24])
		rotate([90,0,90])
		cylinder(h = 10, d = 2);
	}
	
	translate([-38,-52,16])
		rotate([90,0,0])
		cylinder(h = 20, d = 6);
		
	translate([-38,-55.5,16])
		rotate([90,0,0])
		cylinder(h = 20, d = 11, $fn = 6);
	
}

// -----------------------------------------------------------------------------
// Blower Fan Case
// -----------------------------------------------------------------------------

module _XCCB_BlowerCase() {
	hull() {
		translate([9,-37,0])
		cylinder(h = 26, d = 7);
		
		// front right edge
		translate([9,-53,0])
		cylinder(h = 26, d = 8);
		
		// front left edge
		translate([-12,-53,0])
		cylinder(h = 23, d = 7);
	
		// 
		translate([-25.5,-37,0])
		rotate([0,6,0])
		cylinder(h = 26, d = 7);
	
// 
		translate([-25.5,-55,0])
		rotate([0,6,0])
		cylinder(h = 26, d = 4);
		
		
		// top of exit portion
		translate([9,-36,24])
		rotate([90,0,0])
		cylinder(h = 18, d = 4);
		
		translate([-9,-36,24])
		rotate([90,0,0])
		cylinder(h = 18, d = 4);
	}
	
	hull() {
		// front right edge
		translate([9,-55,0])
		cylinder(h = 23, d = 4);
		
		translate([-25.5,-55,0])
		rotate([0,6,0])
		cylinder(h = 26, d = 4);
		
		// attachement bolt point
		translate([-38,-53,16])
		rotate([90,0,0])
		_BoltBase(11 + rpDefaultBevel, 4, BBStyle_Round);
		
		// base of attachement point
		translate([-38.5,-55,0])
		cylinder(h = 18, d = 4);
		
		
		*translate([-38,-53,16])
		rotate([90,0,0])
		cylinder(h = 5, d = 14);
	}
	
	hull() {
		translate([4, -58, 26])
		rotate([90,0,90])
		cylinder(h = 15, d = 5);
	
		translate([-10, -37, 26])
		rotate([90,0,90])
		cylinder(h = 19, d = 4);
		
		translate([-8, -52, 0])
		rotate([90,0,90])
		cylinder(h = 16, d = 2);
	}
	
	hull() {
		translate([-20, -58, 26])
		rotate([90,0,90])
		cylinder(h = 15, d = 5);
	
		translate([-10, -37, 26])
		rotate([90,0,90])
		cylinder(h = 19, d = 4);
		
		translate([-8, -52, 0])
		rotate([90,0,90])
		cylinder(h = 16, d = 2);
	}
}

// -----------------------------------------------------------------------------
// creates a block of vent cutouts
// -----------------------------------------------------------------------------

module _XCCB_VentBlock(_blockRise = 0.66) {
	_blockHeight = 0.5;
	_blockWidth = 2;
	_blockSpace = 4;
	//_blockRise = 0.66;

	translate([0,-2,0])
	cube([_blockWidth, 10, _blockHeight]);
	
	*translate([_blockSpace,0,0])
	cube([_blockWidth, 10, _blockHeight]);
	
	*translate([_blockSpace * 2,0,0])
	cube([_blockWidth, 10, _blockHeight]);
	
	translate([_blockSpace / 2,-2,_blockHeight + _blockRise])
	cube([_blockWidth, 10, _blockHeight]);
	
	*translate([_blockSpace / 2 + _blockSpace,0,_blockHeight + _blockRise])
	cube([_blockWidth, 10, _blockHeight]);
	
	*translate([_blockSpace / 2 + _blockSpace * 2,0,_blockHeight + _blockRise])
	cube([_blockWidth, 10, _blockHeight]);
	

}

// -----------------------------------------------------------------------------
// creates the top vent cutouts - this could be combined with a design or text
// -----------------------------------------------------------------------------

module _XCCB_TopVents(_drawText = true) {

		for (i = [0 : 1 : 9]) {
		
		translate([5.5,0,i * 3 - 2])
		_XCCB_VentBlock(0.5);
		
		translate([-4.66,0,i * 3 - 2])
		_XCCB_VentBlock(0.5);
		
		if ((_drawText == false) || (i == 0) || (i == 9))
			translate([0.33,0,i * 3 - 2])
				_XCCB_VentBlock();
		
		}
		

	if (_drawText == true) {
		translate([0, 2.6, 24.0])
		rotate([-1,84,-90])
		scale([1.1,1,1])
		linear_extrude(height = 2)
			text("Gemini", font="Phosphate:style=Solid", size = 5);
			
			
	}
	
}


// -----------------------------------------------------------------------------
// Shell around the main components
// -----------------------------------------------------------------------------

module _XCCB_Shell() {
	difference() {

		STYLE_SCALE = 1.0;
		STYLE_SIZE = 4.33;	// 4.33 for 5 stacks in 26mm

		// shaped stack of the outline design
		hull() { // union() : switch to hull() if a less stylized design is desired
			translate([0, - lowerBoltOffset /2, 0])
			scale([1 - 0.00,1 - 0.00,1])
			linear_extrude(height = STYLE_SIZE, scale=STYLE_SCALE)
				_XCCB_OutlineCase(0);

			translate([0, - lowerBoltOffset /2, 1 * STYLE_SIZE])
			scale([0.98,1 + 0.00,1])
			linear_extrude(height = STYLE_SIZE, scale=STYLE_SCALE)
				_XCCB_OutlineCase(0.5);

			translate([0, - lowerBoltOffset /2, 2 * STYLE_SIZE])
			scale([0.96,1 + 0.00,1])
			linear_extrude(height = STYLE_SIZE, scale=STYLE_SCALE)
				_XCCB_OutlineCase(1);
			
			translate([0, - lowerBoltOffset /2, 3 * STYLE_SIZE])
			scale([1 - 0.06,1 + 0.00,1])
			linear_extrude(height = STYLE_SIZE, scale=STYLE_SCALE)
				_XCCB_OutlineCase(1.5);
			
			translate([0, - lowerBoltOffset /2, 4 * STYLE_SIZE])
			scale([0.92,1 + 0.00,1])
			linear_extrude(height = STYLE_SIZE, scale=STYLE_SCALE)
				_XCCB_OutlineCase(2);
			
			translate([0, - lowerBoltOffset /2, 5 * STYLE_SIZE])
			scale([0.90,1 + 0.00,1])
			linear_extrude(height = STYLE_SIZE, scale=STYLE_SCALE)
				_XCCB_OutlineCase(2.5);
				
			translate([0, - lowerBoltOffset /2, 6 * STYLE_SIZE])
			scale([0.88,1 + 0.00,1])
			linear_extrude(height = STYLE_SIZE, scale=STYLE_SCALE)
				_XCCB_OutlineCase(3);
				
			translate([0, - lowerBoltOffset /2, 7 * STYLE_SIZE])
			scale([0.86,1 + 0.00,1])
			linear_extrude(height = STYLE_SIZE, scale=STYLE_SCALE)
				_XCCB_OutlineCase(3.5);
				
			union() {
			// Draw the case to hold the blower fan here
			*_XCCB_BlowerCase();
			
			// border around access hole with access hole cut out for wiring to exit
			hull() {
				translate([11,9.6,0])			
				cylinder(h = 32, r = 2);
			
				translate([-11,9.6,0])			
				cylinder(h = 32, r = 2);
			}
			
			// border around access hole for hiwin rail
			
			}
			
		} // union
		
		translate([25,-42,4.33])
		rotate([0,0,70])
			_XCCB_TopVents();
		
		mirror([1,0,0])	
		translate([25,-42,4.33])
		rotate([0,0,70])
			_XCCB_TopVents(false);
			
	
		// carve out center, leaving just a shell
		union() {
			translate([0, - lowerBoltOffset /2, -0.1])
			scale([0.875, 0.75, 1])	
				linear_extrude(height = 2.2, scale=1)
					_XCCB_OutlineCase();
	
	
			translate([0, - lowerBoltOffset /2, 2])
			scale([0.9, 0.98, 1])	
				linear_extrude(height = 33, scale=0.90)
					_XCCB_OutlineCase();
				
						// cut out space for HA_CarriageBase to insert
			
			difference() {
			translate([0, - lowerBoltOffset /2, 26])
			scale([0.84, 0.96, 1])	
				linear_extrude(height = 12, scale=1)
					_XCCB_OutlineCase(3.5);
					
			translate([-40,-60,25])
				cube([80,40,20]);
			}
					
				
			*_XCCB_WiringAccessHole();
			
			*_XCCB_BlowerSpace();
		} // union
		
	} // difference
	
	

	union() {
		// Draw the case to hold the blower fan here
		_XCCB_BlowerCase();
		
		// border around access hole with access hole cut out for wiring to exit
		hull() {
			translate([11,9.6,0])			
			cylinder(h = 32, r = 2);
		
			translate([-11,9.6,0])			
			cylinder(h = 32, r = 2);
		}
		
		hull() {
				translate([29,-9.6,-1])	
				rotate([-2,-7,0])		
				cylinder(h = 36, r = 2);
			
				translate([29,-30,-1])
				rotate([-1,-7,0])		
				cylinder(h = 36, r = 2);
			}
			
			hull() {
				translate([-28,-9.6,-1])	
				rotate([-2,7,0])		
				cylinder(h = 36, r = 2);
			
				translate([-28,-30,-1])
				rotate([-1,7,0])		
				cylinder(h = 36, r = 2);
			}
		
	}	
}

// -----------------------------------------------------------------------------
// Put it all together and carve out the hardware clearances
// -----------------------------------------------------------------------------

module Part_XC_CarriageBase() {

*_XCCB_TopVents();

	difference() {
		union() {
			// start with the base elements
			_XCCB_BoltSkeleton(BBStyle_Round);
			_XCCB_BoltBases(BBStyle_Taper);
			_XCCB_BoltPosts();
		
			// case skin
			_XCCB_Shell();				
		}
			
		union() {
		
			// switch screw carve out
			translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset - hwMicroSwitch_HoleSpacing /2, 0])
				cylinder(h=2, d= 3);
			translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset + hwMicroSwitch_HoleSpacing /2, 0])
				cylinder(h=2, d= 3);
			
			// switch screw access carve out
			hull() {
				translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset - hwMicroSwitch_HoleSpacing /2, 2])
				cylinder(h=30, d= 1);
			
			
				translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset - hwMicroSwitch_HoleSpacing /2, 2])
				cylinder(h=5, d= 8.5);
			}
			
			hull() {
				translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset + hwMicroSwitch_HoleSpacing /2, 2])
				cylinder(h=30, d= 1);
			
			
				translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset + hwMicroSwitch_HoleSpacing /2, 2])
				cylinder(h=5, d= 8.5);
			}
			
			translate([0,-10,0])
			rotate([0,0,-90])
				_HIWINClearance();
			
			//translate([-rpXC_CarriageMount_LowerPointSpacing,0,rpXC_BeltMount_BaseThickness + rpXC_BeltMount_BoltHolderWidth +rpXC_BeltMount_BoltHolderOffset + 1.8]) 
			translate([0,-10,rpXC_BeltMount_BaseThickness + rpXC_BeltMount_BoltHolderWidth +rpXC_BeltMount_BoltHolderOffset + 1.8])
			rotate([0,-90,-90]) {
				_XC_CB_BoltCarveouts();
		
				mirror([0,1,0])
				_XC_CB_BoltCarveouts();
			}
		
			_XCCB_BlowerSpace();	
			
			_XCCB_WiringAccessHole();
			
			
			translate([12, -12, 40])
			rotate([90,0,0])
			cylinder(h = 40, d = 18);
			
			translate([12, -52, 40])
			rotate([90,0,0])
			cylinder(h = 10, d = 20);
			
			translate([-12, -12, 40])
			rotate([90,0,0])
			cylinder(h = 40, d = 18);
			
			translate([-12, -52, 40])
			rotate([90,0,0])
			cylinder(h = 10, d = 20);
				
			
			//translate([0, - lowerBoltOffset /2, 26])_BoltBase(boltDiameter + rpDefaultBevel * 2, _baseThickness - rpDefaultBevel, BBStyle_Round);
		
			// top flat cut
			translate([-100,-20,30.25])
				cube([200,80,20]);
		
			// bottom flat cut
			translate([-100,-100,-20])
				cube([200,200,20]);
		}
	}
}

// -----------------------------------------------------------------------------
// old code, not currently referenced
// -----------------------------------------------------------------------------

/*
	
	*difference() {
		union() {
			
			
			rotate([0,0,rpXC_CarriageBase_StrutAngle])
					_XC_CB_StrutPosts();
					
			rotate([0,0,180 -rpXC_CarriageBase_StrutAngle])
					_XC_CB_StrutPosts();
					
			translate([0,0,0])
					_BlowerHolder();
					
			hull() {		
					
			rotate([0,0,180 -rpXC_CarriageBase_StrutAngle])
					_XC_CB_Strut();
					
			// base of bolt point
				translate([xOffset, -10 - (rpXC_CarriageMount_BoltHolderDiameter /2),0])
				rotate([0,-90,0])
					cube(size=[rpXC_BeltMount_BaseThickness, rpXC_CarriageMount_BoltHolderDiameter - 4, rpXC_BeltMount_BaseThickness],
						 centre = false);
					
			*translate([0,0,0])
					_BlowerHolder();
					
			*mirror([0,1,0])
				translate([xOffset, 0, 0])
				rotate([0,-90,0])
				cube(size=[rpXC_BeltMount_BaseThickness, 20, rpXC_BeltMount_BaseThickness], centre = false);
					
					
			translate([xOffset, -25 - (rpXC_CarriageMount_BoltHolderDiameter /2),0])
				rotate([0,-90,0])
					cube(size=[rpXC_BeltMount_BaseThickness, rpXC_CarriageMount_BoltHolderDiameter - 4, rpXC_BeltMount_BaseThickness],
						 centre = false);
						 
			// mirror switch holder shape to create symmetry
				
				*mirror([0,1,0])
				translate([-rpXC_CarriageMount_LowerPointSpacing + rpDefaultBevel /2, rpXC_BeltMount_BoltSpacing /2 - rpXC_BeltMount_BoltHolderWidth/2, 0])
					_XC_CB_Switch();			 
						 
			//}
			
			// three point mounting struts
			//hull() { // hull()
		
				rotate([0,0,rpXC_CarriageBase_StrutAngle])
					_XC_CB_Strut();
	
				// x-endstop switch holder
		
				translate([-rpXC_CarriageMount_LowerPointSpacing + rpDefaultBevel /2, rpXC_BeltMount_BoltSpacing /2 - rpXC_BeltMount_BoltHolderWidth/2 + switchOffset, 0])
					_XC_CB_Switch();
					
			
				translate([xOffset, -10 + rpXC_BeltMount_BaseThickness, 0])
				rotate([0,-90,0])
				cube(size=[rpXC_BeltMount_BaseThickness, 20, rpXC_BeltMount_BaseThickness], centre = false);
				
				
			}
				
			// mounting block to attach to the HIWIN carriage
			
			translate([-rpXC_CarriageMount_LowerPointSpacing,0,rpXC_BeltMount_BaseThickness + rpXC_BeltMount_BoltHolderWidth +rpXC_BeltMount_BoltHolderOffset + 1.8])
			rotate([0,-90,0]) {
				_XC_CB_CarriageMount();
				mirror([0,1,0])
				_XC_CB_CarriageMount();
			}
			
			
		}
		
		_XC_CB_BlowerHole();
		
		translate([-rpXC_CarriageMount_LowerPointSpacing + rpDefaultBevel /2, rpXC_BeltMount_BoltSpacing /2 - rpXC_BeltMount_BoltHolderWidth/2 + switchOffset, 0])
			_XC_CB_SwitchHoles();
		
		translate([-rpXC_CarriageMount_LowerPointSpacing,0,rpXC_BeltMount_BaseThickness + rpXC_BeltMount_BoltHolderWidth +rpXC_BeltMount_BoltHolderOffset + 1.8]) 
		rotate([0,-90,0]) {
			_XC_CB_BoltCarveouts();
		
			mirror([0,1,0])
			_XC_CB_BoltCarveouts();
			
			
		}
		
		translate([-rpXC_CarriageMount_LowerPointSpacing,0,0])
		_HIWINClearance();
	}
	
}*/




// -----------------------------------------------------------------------------
// This makes the blower fan holder portion
// -----------------------------------------------------------------------------



module _BlowerHolder() {

	difference() {
	
		union() {
		
			hull() {
			
			// curve for where this meets the output edge bit	 
			translate([xOffset - (rpXC_BeltMount_BaseThickness /2), 12,0])
				rotate([0,0,0])
				cylinder(h = 22, d = rpXC_BeltMount_BaseThickness);
			
			
				
			// edge to hold blower straight
			// cube size x = height of protrusion
			//		size y = thickness of protrusion
			//		size z = distance it protrudes
			translate([22, 10,0])
				rotate([0,-90,0])
					cube(size=[	22, 
								rpXC_BeltMount_BaseThickness, 
								17],
						 centre = false);
				
			// blower output edge bit	
				 
			translate([25, -12,0])
			rotate([0,-90,0])
				cube(size=[20, 24, rpXC_BeltMount_BaseThickness],
					centre = false);
					
			#translate([30, 2,20])
			rotate([0,-90,0])
				cube(size=[8, 18, 8],
					centre = false);
					
			#translate([30, -20,20])
			rotate([0,-90,0])
				cube(size=[8, 18, 8],
					centre = false);
					
			translate([xOffset, -10,2])
				rotate([0,-90,0])
					cube(size=[20, 20  + (rpXC_BeltMount_BaseThickness /2), rpXC_BeltMount_BaseThickness],
						 centre = false);
						 
				
				// base of bolt point
				*translate([xOffset, -25 - (rpXC_CarriageMount_BoltHolderDiameter /2),0])
				rotate([0,-90,0])
					cube(size=[rpXC_BeltMount_BaseThickness, rpXC_CarriageMount_BoltHolderDiameter - 4, rpXC_BeltMount_BaseThickness],
						 centre = false);
			}
			
			hull() {
			// blower output edge bit		 
				translate([xOffset, -10,2])
				rotate([0,-90,0])
					cube(size=[20, 20  + (rpXC_BeltMount_BaseThickness /2), rpXC_BeltMount_BaseThickness],
						 centre = false);
						 
				
				// base of bolt point
				translate([xOffset, -25 - (rpXC_CarriageMount_BoltHolderDiameter /2),0])
				rotate([0,-90,0])
					cube(size=[rpXC_BeltMount_BaseThickness, rpXC_CarriageMount_BoltHolderDiameter - 4, rpXC_BeltMount_BaseThickness],
						 centre = false);
			//}
		
			//hull() {	// hull()
			
				// point to bolt fan to
				translate([xOffset,-37,zOffset])
				rotate([0,-90,0])
					_XC_CB_PostBase(rpXC_BeltMount_BaseThickness, rpXC_CarriageMount_BoltHolderDiameter -2, rpDefaultBevel);
					
				// base of bolt point
				translate([xOffset, -25 - (rpXC_CarriageMount_BoltHolderDiameter /2),0])
				rotate([0,-90,0])
					cube(size=[rpXC_BeltMount_BaseThickness * 2, rpXC_CarriageMount_BoltHolderDiameter - 4, rpXC_BeltMount_BaseThickness],
						 centre = false);
						 
				// rectangle to form the printable base portion
				*translate([xOffset, -20, 0])
				rotate([0,-90,0])
				cube(size=[rpXC_BeltMount_BaseThickness, 40, rpXC_BeltMount_BaseThickness], centre = false);
				
			}
		
			*hull() {	// hull()
				translate([- (rpXC_CarriageMount_BoltHolderDiameter /2)  - rpDefaultBevel, -yOffset - (rpXC_CarriageMount_BoltHolderDiameter /2),0])
				rotate([0,0,0])
					cube(size=[rpXC_CarriageMount_BoltHolderDiameter, rpXC_CarriageMount_BoltHolderDiameter, rpXC_BeltMount_BaseThickness],
						 centre = false);
		
				rotate([0,0,180-rpXC_CarriageBase_StrutAngle]) 
				translate([	0, rpXC_CarriageBase_StrutLength, 0])
				_XC_CB_PostBase(rpXC_BeltMount_BaseThickness, rpXC_CarriageMount_BoltHolderDiameter, rpDefaultBevel);
		
				*translate([-20, -12 - (rpXC_CarriageMount_BoltHolderDiameter /2),0])
				rotate([0,0,0])
					cube(size=[rpXC_CarriageMount_BoltHolderDiameter, rpXC_CarriageMount_BoltHolderDiameter, rpXC_BeltMount_BaseThickness],
						 centre = false);
			}
		}
		
		// bolt hole
		*translate([xOffset + 10,-21,zOffset])
		rotate([0,-90,0])
		Carve_hw_Bolt_AllenHead(hwM4_Bolt_AllenHeadSize, 20, 0);
	}
}

// just the mount hole(s) - copied from above

module _XC_CB_BlowerHole() {
		// bolt hole
		translate([xOffset + 15,-37,zOffset])
		rotate([0,-90,0])
		Carve_hw_Bolt_AllenHead(hwM4_Bolt_AllenHeadSize, 20, 10);
}

// -----------------------------------------------------------------------------
// This makes the switch holder portion
// -----------------------------------------------------------------------------

module _XC_CB_Switch() {
	difference() {
		hull() {
			minkowski() {

			cube(size=[hwMicroSwitch_Length  - rpDefaultBevel, hwMicroSwitch_Width - rpDefaultBevel , rpXC_BeltMount_BaseThickness - rpDefaultBevel],
				 center = false);
		 
			cylinder(d = rpDefaultBevel, h = rpDefaultBevel);

			}
	
			translate([hwMicroSwitch_Length -rpDefaultBevel, -rpXC_BeltMount_BoltHolderWidth *2, 0])
			cylinder(d = rpDefaultBevel, h = rpXC_BeltMount_BaseThickness);
		}
		
		*translate([hwMicroSwitch_Length /2, 0, 0]) {
			translate([hwMicroSwitch_HoleSpacing / 2, hwMicroSwitch_Width - hwMicroSwitch_HoleOffset, 0])
				cylinder(d = hwMicroSwitch_HoleSize, h = rpXC_BeltMount_BaseThickness);
			
			*translate([-hwMicroSwitch_HoleSpacing / 2, hwMicroSwitch_Width - hwMicroSwitch_HoleOffset, 0])
				cylinder(d = hwMicroSwitch_HoleSize, h = rpXC_BeltMount_BaseThickness);
		}
	}
	
}

// just the holes - code copied from above

module _XC_CB_SwitchHoles() {
	translate([hwMicroSwitch_Length /2, 0, 0]) {
	
		// hole for clearance of the screw head
		translate([hwMicroSwitch_HoleSpacing / 2, hwMicroSwitch_Width - hwMicroSwitch_HoleOffset, rpXC_BeltMount_BaseThickness])
			cylinder(d = hwMicroSwitch_HoleSize + 4, h = 20);
	
		// hole for the shaft of the small screw used to mount switch
		translate([hwMicroSwitch_HoleSpacing / 2, hwMicroSwitch_Width - hwMicroSwitch_HoleOffset, 0])
			cylinder(d = hwMicroSwitch_HoleSize, h = rpXC_BeltMount_BaseThickness);
			
			
		// hole for clearance of the screw head
		translate([-hwMicroSwitch_HoleSpacing / 2, hwMicroSwitch_Width - hwMicroSwitch_HoleOffset, rpXC_BeltMount_BaseThickness])
			cylinder(d = hwMicroSwitch_HoleSize + 4, h = 20);
	
		// hole for the shaft of the small screw used to mount switch
		translate([-hwMicroSwitch_HoleSpacing / 2, hwMicroSwitch_Width - hwMicroSwitch_HoleOffset, 0])
			cylinder(d = hwMicroSwitch_HoleSize, h = rpXC_BeltMount_BaseThickness);
	}
}

// -----------------------------------------------------------------------------
// This makes one strut of the three-point-mount
// -----------------------------------------------------------------------------

module _XC_CB_Strut() {
	
	//difference() {
		// basic strut design
		union() { 
			// main bulk of the strut - this is made of two cubes
			// - outer cube:
			hull() {	// hull
				translate([-rpXC_CarriageMount_BoltHolderDiameter / 2, 0, 0])
					cube(size =[rpXC_CarriageMount_BoltHolderDiameter, 
								rpXC_CarriageBase_StrutLength, 
								rpXC_BeltMount_BaseThickness - rpDefaultBevel],
						 center = false);
			 
				// - inner cube:
				translate([-rpXC_CarriageMount_BoltHolderDiameter / 2 + rpDefaultBevel /2, 0, 0])
					cube(size =[rpXC_CarriageMount_BoltHolderDiameter - rpDefaultBevel, 
								rpXC_CarriageBase_StrutLength, 
								rpXC_BeltMount_BaseThickness],
						 center = false);
			}
		}
		
		// carve out the inner portion to make the part lighter & fancier
		/*translate([-rpXC_CarriageMount_BoltHolderDiameter / 2 + rpDefaultWallThickness /2, 0, rpDefaultBaseThickness])
			cube(size=[	rpXC_CarriageMount_BoltHolderDiameter - rpDefaultWallThickness, 
						rpXC_CarriageBase_StrutLength, 
						rpXC_BeltMount_BaseThickness - rpDefaultBaseThickness],
				 center = false);*/
				 
	//}
	
	// lower bolt mount
	
	hull()
	_XC_CB_PostBase(rpXC_BeltMount_BaseThickness, rpXC_CarriageMount_BoltHolderDiameter, rpDefaultBevel);
	
	*translate([	0, 0, rpXC_BeltMount_BaseThickness])
	cylinder(h = rpXC_CarriageMount_BaseWidth + rpXC_CarriageMount_BaseSpacing *2, d1 = rpXC_CarriageMount_BoltHolderDiameter - (rpDefaultBevel /2), d2 = rpXC_CarriageMount_BoltHolderDiameter - rpDefaultBevel);

	// upper bolt mount
	translate([	0, rpXC_CarriageBase_StrutLength, 0])
	hull() 
	_XC_CB_PostBase(rpXC_BeltMount_BaseThickness, rpXC_CarriageMount_BoltHolderDiameter, rpDefaultBevel);
	

	*translate([	0, rpXC_CarriageBase_StrutLength, rpXC_BeltMount_BaseThickness])
	cylinder(h = rpXC_CarriageMount_BaseWidth + rpXC_CarriageMount_BaseSpacing *2, d1 = rpXC_CarriageMount_BoltHolderDiameter  - (rpDefaultBevel /2), d2 = rpXC_CarriageMount_BoltHolderDiameter - rpDefaultBevel);
	
	
}


// just the posts - copied from above

module _XC_CB_StrutPosts() {
	
	
	
	hull()
	_XC_CB_PostBase(rpXC_BeltMount_BaseThickness, rpXC_CarriageMount_BoltHolderDiameter, rpDefaultBevel);
	
	translate([	0, 0, rpXC_BeltMount_BaseThickness])
	cylinder(h = 18, d1 = rpXC_CarriageMount_BoltHolderDiameter - (rpDefaultBevel /2), d2 = rpXC_CarriageMount_BoltHolderDiameter - rpDefaultBevel);

	// upper bolt mount
	translate([	0, rpXC_CarriageBase_StrutLength, 0])
	hull() 
	_XC_CB_PostBase(rpXC_BeltMount_BaseThickness, rpXC_CarriageMount_BoltHolderDiameter, rpDefaultBevel);
	

	translate([	0, rpXC_CarriageBase_StrutLength, rpXC_BeltMount_BaseThickness])
	cylinder(h = rpXC_CarriageMount_BaseWidth + rpXC_CarriageMount_BaseSpacing *2, d1 = rpXC_CarriageMount_BoltHolderDiameter  - (rpDefaultBevel /2), d2 = rpXC_CarriageMount_BoltHolderDiameter - rpDefaultBevel);
	
	
}



// -----------------------------------------------------------------------------
// WARNING: Be very careful modifying this - the values are from the original 
// 			version which is all sorts of a different orientation
// -----------------------------------------------------------------------------

module _XC_CB_BoltCarveouts() {

	translate([0 - (hwLR_Carriage_BoltLength / 2), 0 - (hwLR_Carriage_BoltWidth / 2), 0 - hwLR_Carriage_BoltDepth])
		Carve_hw_Bolt_AllenHead(rpXC_CarriageMount_BoltSize, rpXC_CarriageMount_BoltLength, 20);

	translate([0 + (hwLR_Carriage_BoltLength / 2), 0 - (hwLR_Carriage_BoltWidth / 2),  0 - hwLR_Carriage_BoltDepth])
		Carve_hw_Bolt_AllenHead(rpXC_CarriageMount_BoltSize, rpXC_CarriageMount_BoltLength, 20);

	// [rpXC_BeltMount_BoltDepth - rpXC_BeltMount_BaseOffset, 0 - (rpXC_BeltMount_BoltSpacing / 2), rpXC_BeltMount_BoltOffset]
	translate([rpXC_BeltMount_BoltDepth - rpXC_BeltMount_BaseOffset,
				0 - (rpXC_BeltMount_BoltSpacing / 2),
				rpXC_BeltMount_BoltOffset])
	rotate([0,-90,0])
		Carve_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, rpXC_BeltMount_BoltLength);
			
	translate([rpXC_BeltMount_BoltDepth - rpXC_BeltMount_BaseOffset,
				0,
				-rpXC_CarriageMount_LowerPointSpacing])
		rotate([0,-90,0])
			Carve_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, rpXC_BeltMount_BoltLength);
						
}



// -----------------------------------------------------------------------------
module _XC_BoltPost(_flareDiameter, _postDiameter, _postLength) {
	$fn = gcFacetMedium;
	hull() {	// hull()
		cylinder(h = 0.1,
				 d = _flareDiameter + 3);

		cylinder(h = 2,
				 d = _flareDiameter + 1);
	}
	
	hull() {	// hull()	 
		cylinder(h = 2,
				 d = _flareDiameter +1);	
	
		cylinder(h = _postLength,
				 d = _postDiameter + 4);
	}
}

// -----------------------------------------------------------------------------
module _XC_CB_PostBase(baseHeight, baseDiameter, baseOffset) {
	$fn = gcFacetMedium;
	
	cylinder(		h = baseHeight,
					d = baseDiameter - baseOffset /2);
				
	translate([0,0,0])
		cylinder(	h = baseHeight - baseOffset,
					d = baseDiameter);
}

// -----------------------------------------------------------------------------
module _XC_CB_MountBase() {
	$fn = gcFacetMedium;

	hull() { // hull()	
		// slightly raised face for bolt hole (upper)
		translate([-(rpXC_CarriageMount_BaseWidth / 2) - rpXC_BeltMount_BoltHolderWidth,
					-(rpXC_BeltMount_BoltSpacing /2), 
					rpXC_BeltMount_BoltOffset])
		rotate([0,90,0]) 
			_XC_CB_PostBase(rpXC_BeltMount_BoltHolderWidth, rpXC_BeltMount_BoltHolderDiameter, 2);
						

					  
		// slightly raised face for bolt hole (lower)
		translate([	-(rpXC_CarriageMount_BaseWidth / 2) - rpXC_BeltMount_BoltHolderWidth,
					0, 
					-rpXC_CarriageMount_LowerPointSpacing])
		rotate([0,90,0]) 
			_XC_CB_PostBase(rpXC_BeltMount_BoltHolderWidth, rpXC_BeltMount_BoltHolderDiameter, 2);
	 			 
	}
	
	// bolt holder post (upper)
	translate([	0 - (rpXC_CarriageMount_BaseWidth / 2),
				0 - (rpXC_BeltMount_BoltSpacing / 2), 
				rpXC_BeltMount_BoltOffset])
	rotate([0,90,0]) 
		_XC_BoltPost(	rpXC_BeltMount_InnerBoltHolderDiameter,
						rpXC_BeltMount_BoltSize[iBolt_ShaftDiameter],
						rpXC_CarriageMount_BaseWidth + rpXC_CarriageMount_BaseSpacing);
									
	// bolt holder post (lower)
	translate([	-(rpXC_CarriageMount_BaseWidth / 2),
				0, 
				-rpXC_CarriageMount_LowerPointSpacing])
	rotate([0,90,0]) 
		_XC_BoltPost(	rpXC_BeltMount_InnerBoltHolderDiameter,
						rpXC_BeltMount_BoltSize[iBolt_ShaftDiameter],
						rpXC_CarriageMount_BaseWidth + rpXC_CarriageMount_BaseSpacing);

}

// -----------------------------------------------------------------------------
module _XC_CB_CarriageMount() {
	hull() { // hull()
		// rounded meeting point
		$fn = gcFacetMedium;
	
		// base portion of the design
		translate([0 - (rpXC_CarriageMount_BaseWidth / 2) -2,
				   0 - (rpXC_CarriageMount_BaseLength /2) ,
				   0])
			cube(size = [rpXC_CarriageMount_BaseWidth + 2,
						 rpXC_CarriageMount_BaseLength /2,
						 rpXC_CarriageMount_BaseHeight - rpXC_CarriageMount_BaseBevelHeight],
				 center = false);

		// this cube is the top portion of the design
		translate([0 - (rpXC_CarriageMount_BaseWidth / 2) + rpXC_CarriageMount_BaseBevelDepth,
				   0 - (rpXC_CarriageMount_BaseLength /2)+ rpXC_CarriageMount_BaseBevelDepth,
				   rpXC_CarriageMount_BaseHeight - rpXC_CarriageMount_BaseBevelHeight])
			cube(size = [rpXC_CarriageMount_BaseWidth - rpXC_CarriageMount_BaseBevelDepth * 2,
						 rpXC_CarriageMount_BaseLength / 2 - rpXC_CarriageMount_BaseBevelDepth,
						 rpXC_CarriageMount_BaseBevelHeight], 
				 center = false);
				 
		*translate([-(rpXC_CarriageMount_BaseWidth / 2) -5,
				   -(rpXC_CarriageMount_BaseLength /2),
				   rpXC_CarriageMount_BaseBevelHeight])
		rotate([0,90,0])
			cylinder(	h = rpXC_CarriageMount_BaseWidth + rpXC_BeltMount_BoltHolderWidth + rpXC_CarriageMount_BaseSpacing,
						d1 = rpXC_BeltMount_BoltSize[iBolt_ShaftDiameter] +3,
						d2 = rpXC_BeltMount_BoltSize[iBolt_ShaftDiameter] +3);
						
		*translate([-(rpXC_CarriageMount_BaseWidth / 2) -5,
				   -(rpXC_CarriageMount_BaseLength /2) +7,
				   rpXC_CarriageMount_BaseBevelHeight +1])
		rotate([0,90,0])
			cylinder(	h = rpXC_CarriageMount_BaseWidth + rpXC_BeltMount_BoltHolderWidth,
						d1 = rpXC_BeltMount_BoltSize[iBolt_ShaftDiameter] +3,
						d2 = rpXC_BeltMount_BoltSize[iBolt_ShaftDiameter]);
						
	}
	
	// joining parts where the upper posts meet the carriage base
	hull() { // hull 
		$fn = gcFacetMedium;
		// base portion of the design - split
		
		translate([-(rpXC_CarriageMount_BaseWidth / 2) -2,
				   -(rpXC_CarriageMount_BaseLength /2) +0.5,
				   rpXC_CarriageMount_BaseBevelHeight -1])
		rotate([0,90,0])
			cylinder(	h = rpXC_CarriageMount_BaseWidth + 2,
						d = rpXC_BeltMount_BoltSize[iBolt_ShaftDiameter]);
					
						 
		translate([	0 - (rpXC_CarriageMount_BaseWidth / 2) -2,
					0 - (rpXC_BeltMount_BoltSpacing / 2), 
					rpXC_BeltMount_BoltOffset])						 
		rotate([0,90,0]) 
			cylinder(	h = rpXC_CarriageMount_BaseWidth + 2,
						d = rpXC_BeltMount_BoltSize[iBolt_ShaftDiameter],
						$fn = gcFacetMedium);
						
	}
}




		
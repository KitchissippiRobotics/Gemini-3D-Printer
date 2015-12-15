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

include <Dimensions.scad>

// -----------------------------------------------------------------------------
// Some internal switch values:
// -----------------------------------------------------------------------------

BBStyle_Simple = 0;
BBStyle_Bevel = 1;
BBStyle_Round = 2;
BBStyle_Taper = 3;

// -----------------------------------------------------------------------------
// Some internal used values:
// -----------------------------------------------------------------------------

_baseThickness = rpDefaultBaseThickness + rpDefaultBevel * 2;		// mm
minimumThickness = 2.2; // mm
boltSpacing = 40;		// mm
boltDiameter = hwM4_Bolt_ShaftDiameter;
lowerBoltOffset = rpXC_BeltMount_BoltOffset + rpXC_CarriageMount_LowerPointSpacing;	// mm
bevelSize = rpDefaultBevel;	// mm

switchXOffset = 25;
switchYOffset = -10;

caseRightSide = switchXOffset + hwMicroSwitch_ScrewHeadDiameter;
caseLeftSide = caseRightSide;	// symmetrical sizes
caseTopSide = 20;
caseBottomSide = 20;

caseWallThickness = minimumThickness;
caseHeight = 60;
caseWidth = 2 * (switchXOffset) - 4;
caseOffset = -20;
caseDepth = 60;

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


	xOffset = 7;
	yOffset = 10;
	zOffset = 17;
	
	switchOffset  = 2;


// -----------------------------------------------------------------------------
// Draw the case base outline shape (experimental)
// -----------------------------------------------------------------------------

module _XCCB_CaseLayer() {
	hull() {
	
		// top belt clamp area
		
		translate([-18, 6, 0])
			circle(d = 8);
	
		translate([18, 6, 0])
			circle(d = 8);
			
			
		// bottom blower range
		
		translate([20, -50, 0])
			circle(d = 8);
			
		translate([-20, -50, 0])
			circle(d = 8);
		
		// top clamp mount right
		
		translate([-boltSpacing/2, 0, 0])
			circle(d = 12);
			
		// top clamp mount left
		
		translate([boltSpacing/2, 0, 0])
			circle(d = 12);
			
		// switch holder
	
		translate([caseWidth/2, - rpXC_BeltMount_BoltOffset + switchYOffset + hwMicroSwitch_HoleSpacing /2, 0])
			circle(d = 10);
		translate([caseWidth/2, - rpXC_BeltMount_BoltOffset + switchYOffset - hwMicroSwitch_HoleSpacing /2, 0])
			circle(d = 10);
			
		// mirror of switch holder
		
		translate([-caseWidth/2, - rpXC_BeltMount_BoltOffset + switchYOffset + hwMicroSwitch_HoleSpacing /2, 0])
			circle(d = 10);
		translate([-caseWidth/2, - rpXC_BeltMount_BoltOffset + switchYOffset - hwMicroSwitch_HoleSpacing /2, 0])
			circle(d = 10);
	}	
}

// -----------------------------------------------------------------------------
// Draw the case base outline shape (experimental)
// -----------------------------------------------------------------------------

module _XCCB_OutlineCase(outlineThickness = 1) {
	translate([0, lowerBoltOffset /2, 0])
	hull() {
	
		// top belt clamp area
		
		translate([-18, 6, 0])
			circle(d = 8);
	
		translate([18, 6, 0])
			circle(d = 8);
			
			
		// bottom blower range
		
		translate([15, -40, 0])
			circle(d = 8);
			
		translate([-15, -40, 0])
			circle(d = 8);
		
		// top clamp mount right
		
		translate([-boltSpacing/2, 0, 0])
			circle(d = 12);
			
		// top clamp mount left
		
		translate([boltSpacing/2, 0, 0])
			circle(d = 12);
			
		// switch holder
	
		translate([caseWidth/2, - rpXC_BeltMount_BoltOffset + switchYOffset + hwMicroSwitch_HoleSpacing /2 + 5, 0])
			circle(d = 12);
		translate([caseWidth/2, - rpXC_BeltMount_BoltOffset + switchYOffset - hwMicroSwitch_HoleSpacing /2 - 2, 0])
			circle(d = 12);
			
		// mirror of switch holder
		
		translate([-caseWidth/2, - rpXC_BeltMount_BoltOffset + switchYOffset + hwMicroSwitch_HoleSpacing /2 +5, 0])
			circle(d = 10);
		translate([-caseWidth/2, - rpXC_BeltMount_BoltOffset + switchYOffset - hwMicroSwitch_HoleSpacing /2 - 2, 0])
			circle(d = 10);
	}
}

// -----------------------------------------------------------------------------
// Just Draw the bolt bases
// -----------------------------------------------------------------------------

module _XCCB_BoltBases(baseBBStyle) {


	// top left assembly bolt mount base
	translate([-boltSpacing/2, 0, 0])
		_BoltBase(boltDiameter + rpDefaultBevel, _baseThickness, baseBBStyle);
		
	// top right assembly bolt mount base
	translate([boltSpacing/2, 0, 0])
		_BoltBase(boltDiameter + rpDefaultBevel, _baseThickness, baseBBStyle);

	// bottom center assembly bolt mount base
	translate([0, -lowerBoltOffset, 0])
		_BoltBase(boltDiameter + rpDefaultBevel, _baseThickness, baseBBStyle);
	
	
	// switch holder lower screw base
	hull() {
		translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset - hwMicroSwitch_HoleSpacing /2 - 2, 0])
			_BoltBase(hwMicroSwitch_ScrewHeadDiameter, _baseThickness, baseBBStyle);
	
		// switch holder upper screw base
		translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset + hwMicroSwitch_HoleSpacing /2 + 2, 0])
			_BoltBase(hwMicroSwitch_ScrewHeadDiameter, _baseThickness, baseBBStyle);
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
		
		hull() {
			translate([0, -lowerBoltOffset, 0])
				_BoltBase(boltDiameter /2, _baseThickness - rpDefaultBevel, baseBBStyle);
				
			translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset, 0])
				_BoltBase(boltDiameter /2, _baseThickness - rpDefaultBevel, baseBBStyle);
		}
		
		hull() {
			translate([0, -lowerBoltOffset, 0])
				_BoltBase(boltDiameter /2, _baseThickness - rpDefaultBevel, baseBBStyle);
				
			translate([-switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset, 0])
				_BoltBase(boltDiameter /2, _baseThickness - rpDefaultBevel, baseBBStyle);
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
		cylinder(h = 20, d = hwM4_Bolt_ShaftDiameter + gcMachineOffset + gRender_Clearance + minimumThickness + bevelSize);
		
		
	// top right assembly bolt mount base
	translate([boltSpacing/2, 0, 0])
		cylinder(h = 20, d = hwM4_Bolt_ShaftDiameter + gcMachineOffset + gRender_Clearance + minimumThickness + bevelSize);

	// bottom center assembly bolt mount base
	translate([0, -lowerBoltOffset, 0])
		cylinder(h = 20, d = hwM4_Bolt_ShaftDiameter + gcMachineOffset + gRender_Clearance + minimumThickness + bevelSize);
}



// -----------------------------------------------------------------------------
// Put it all together and carve out the hardware clearances
// -----------------------------------------------------------------------------

module Part_XC_CarriageBase() {

	// start with the base elements
	
	

	
	difference() {
		union() {
			_XCCB_BoltSkeleton(BBStyle_Bevel);
			_XCCB_BoltBases(BBStyle_Taper);
			_XCCB_BoltPosts();
		
			// case shape
		
			difference() {
			
				STYLE_SCALE = 1.06;
				STYLE_SIZE = 4.33;
			
				union() {
					translate([0, - lowerBoltOffset /2, 0])
					scale([1 - 0.00,1 - 0.00,1])
					linear_extrude(height = STYLE_SIZE, scale=STYLE_SCALE)
						_XCCB_OutlineCase();
			
					translate([0, - lowerBoltOffset /2, 1 * STYLE_SIZE])
					scale([1 + 0.02,1 + 0.00,1])
					linear_extrude(height = STYLE_SIZE, scale=STYLE_SCALE)
						_XCCB_OutlineCase();
			
					translate([0, - lowerBoltOffset /2, 2 * STYLE_SIZE])
					scale([1 + 0.04,1 + 0.00,1])
					linear_extrude(height = STYLE_SIZE, scale=STYLE_SCALE)
						_XCCB_OutlineCase();
						
					translate([0, - lowerBoltOffset /2, 3 * STYLE_SIZE])
					scale([1 + 0.06,1 + 0.00,1])
					linear_extrude(height = STYLE_SIZE, scale=STYLE_SCALE)
						_XCCB_OutlineCase();
						
					translate([0, - lowerBoltOffset /2, 4 * STYLE_SIZE])
					scale([1 + 0.08,1 + 0.00,1])
					linear_extrude(height = STYLE_SIZE, scale=STYLE_SCALE)
						_XCCB_OutlineCase();
						
					translate([0, - lowerBoltOffset /2, 5 * STYLE_SIZE])
					scale([1 + 0.1,1 + 0.00,1])
					linear_extrude(height = STYLE_SIZE, scale=STYLE_SCALE)
						_XCCB_OutlineCase();
					
					//rotate([-5,0,0])
					
					hull() {
						translate([11,9.6,0])			
						cylinder(h = 26, r = 2);
						
						translate([-11,9.6,0])			
						cylinder(h = 26, r = 2);
					}
				}
			
				union() {
					translate([0, - lowerBoltOffset /2, 0])
					scale([0.90, 0.90, 1])	
						linear_extrude(height = 2, scale=1)
							_XCCB_OutlineCase();
				
				
					translate([0, - lowerBoltOffset /2, 2])
					scale([0.95, 0.95, 1])	
						linear_extrude(height = 17, scale=0.97)
							_XCCB_OutlineCase();
							
					*translate([0, - lowerBoltOffset /2, 17])
					scale([0.95, 0.95, 1])	
						linear_extrude(height = 2, scale=0.97)
							_XCCB_OutlineCase();
							
					translate([0, - lowerBoltOffset /2, 19])
					scale([0.97, 0.97, 1])	
						linear_extrude(height = 7, scale=1)
							_XCCB_OutlineCase();
							
					hull() {
						translate([5, 13, 7])
						rotate([90,0,0])
						cylinder(h = 5, d = 6);
					
						translate([-5, 13, 7])
						rotate([90,0,0])
						cylinder(h = 5, d = 6);
					
						translate([6, 13, 27])
						rotate([90,0,0])
						cylinder(h = 5, d = 6);
					
						translate([-6, 13, 27])
						rotate([90,0,0])
						cylinder(h = 5, d = 6);
					}
				}			
			}
			
			
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
	}
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
	
}

// -----------------------------------------------------------------------------
// bolt base - a simple point for a bolt to go through strongly on the base
// -----------------------------------------------------------------------------

module _BoltBase(shaftSize, baseThickness, style = BBStyle_Simple) {
	if (style == BBStyle_Simple)
		cylinder(h = baseThickness, d = shaftSize + gcMachineOffset + gRender_Clearance + minimumThickness + bevelSize);
	else if (style == BBStyle_Bevel) {
		cylinder(h = baseThickness - bevelSize, d = shaftSize + gcMachineOffset + gRender_Clearance + minimumThickness + bevelSize);
		translate([0,0,baseThickness - bevelSize])
			cylinder(h = bevelSize, d2 = shaftSize + gcMachineOffset + gRender_Clearance + minimumThickness,
									d1 = shaftSize + gcMachineOffset + gRender_Clearance + minimumThickness + bevelSize);
	}
	else if (style == BBStyle_Round) {
		hull() {
			cylinder(h = baseThickness - bevelSize, d = shaftSize + gcMachineOffset + gRender_Clearance + minimumThickness + bevelSize);
			translate([0,0,baseThickness - bevelSize])
				rotate_extrude(angle = 360, covexity = 1)
				translate([(shaftSize + gcMachineOffset + gRender_Clearance + minimumThickness + bevelSize) /2 - bevelSize,0,0])
					circle(h = bevelSize, d = bevelSize * 2);
		}
	}
	else if (style == BBStyle_Taper) {
		difference() {
			cylinder(h = baseThickness, d = shaftSize + gcMachineOffset + gRender_Clearance + minimumThickness + bevelSize);
		
			translate([0,0,baseThickness])
				rotate_extrude(angle = 360, covexity = 1)
				translate([(shaftSize + gcMachineOffset + gRender_Clearance + bevelSize) /2 + minimumThickness/2,0,0])
					circle(h = bevelSize, d = bevelSize * 2);
		}
	}	
}


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
// creates a shape for clearance of the linear rail to be carved out of the part
// -----------------------------------------------------------------------------

module _HIWINClearance() {
	union() {
			// cut out space for Hiwin carriage, clearance of the bar and mount bolts
			hull() {
				// carriage carve out
				translate([	0,
							-50,
							rpXC_CarriageMount_BaseWidth /2 - rpXC_BeltMount_BoltHolderWidth])
					cube(size= [9,
								100,
								rpXC_CarriageMount_BaseWidth],
						center = false);
					
				// bar carve out

				translate([11.5,
							0,
							rpXC_CarriageMount_BaseWidth /2 + 5.5])
					cube(size= [3.2,
								100,
								rpXC_CarriageMount_BaseWidth + 1],
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




		
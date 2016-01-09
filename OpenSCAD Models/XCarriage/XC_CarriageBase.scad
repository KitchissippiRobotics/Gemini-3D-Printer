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

include <../Dimensions.scad>
include <XC_Common.scad>

BlowerXOffset = 10;
BlowerCaseExtension = 20;

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
// Just Draw the bolt posts
// -----------------------------------------------------------------------------

module _CarriageBase_BoltPosts() {
	// top left assembly bolt mount base
	translate([-boltSpacing/2, 0, 0])
		cylinder(h = 26,	d = hwM4_Bolt_ShaftDiameter + gcMachineOffset + minimumThickness);
		
	// top right assembly bolt mount base
	translate([boltSpacing/2, 0, 0])
		cylinder(h = 26,	d = hwM4_Bolt_ShaftDiameter + gcMachineOffset + minimumThickness);
			
}

module _CarriageBase_LinearMount() {
	// bulk for bolts to mount through
	hull() {
		translate([8, -6, 8])
			cylinder(h = 15, d = 12, $fn = gcFacetLarge);
	
		translate([-8, -6, 8])
			cylinder(h = 15, d = 12, $fn = gcFacetLarge);
		
	
		translate([8, -6, 0])
			cylinder(h = 26, d = 10, $fn = gcFacetLarge);
	
		translate([-8, -6, 0])
			cylinder(h = 26, d = 10, $fn = gcFacetLarge);
		
	}
}

// -----------------------------------------------------------------------------
// Put it all together and carve out the hardware clearances
// -----------------------------------------------------------------------------

module Part_XC_CarriageBase() {

	difference() {
		union() {
			// start with the base elements
			_CarriageBase_BoltPosts();
	
			_width = 35;
			
			// mount to hiwin carriage
			
			_CarriageBase_LinearMount();
			
			// wings for bolt post to meet with
			*hull() {
				*translate([15, -7, 0])
				cylinder(h = 20, d = 6);
			
				*translate([-15, -7, 0])
				cylinder(h = 20, d = 6);
			
				translate([8, -7, 0])
				cylinder(h = 26, d = 6);
			
				translate([-8, -7, 0])
				cylinder(h = 26, d = 6);
			}
			
			// left joining bit
			hull() {
				translate([- rpXC_BeltMount_BoltSpacing /2, 0, 0])
				_BoltBase(0, 26, BBStyle_Round);
				
			
				translate([-8, -7, 0])
				_BoltBase(0, 26, BBStyle_Round);
			}
			
			// left joining bit
			*hull() {
				translate([- rpXC_BeltMount_BoltSpacing /2, 0, 20])
				_BoltBase(0, 6, BBStyle_Round);
			
				translate([-8, -7, 20])
				_BoltBase(0, 6, BBStyle_Round);
			}
			
			// right joining bit
			hull() {
				translate([rpXC_BeltMount_BoltSpacing /2, 0, 0])
				_BoltBase(0, 26, BBStyle_Round);
			
				translate([8, -7, 0])
				_BoltBase(0, 26, BBStyle_Round);
			}
			
			// right joining bit
			*hull() {
				translate([rpXC_BeltMount_BoltSpacing /2, 0, 20])
				_BoltBase(0, 6, BBStyle_Round);
			
				translate([8, -7, 20])
				_BoltBase(0, 6, BBStyle_Round);
			}
			
			*translate([- _width / 2,-10,0])
			cube([_width,8,26]);			
		}
			
		union() {
		
			// switch screw carve out
			*translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset - hwMicroSwitch_HoleSpacing /2, 0])
				cylinder(h=2, d= 3);
			*translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset + hwMicroSwitch_HoleSpacing /2, 0])
				cylinder(h=2, d= 3);
			
			// switch screw access carve out
			*hull() {
				translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset - hwMicroSwitch_HoleSpacing /2, 2])
				cylinder(h=30, d= 1);
			
			
				translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset - hwMicroSwitch_HoleSpacing /2, 2])
				cylinder(h=5, d= 8.5);
			}
			
			*hull() {
				translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset + hwMicroSwitch_HoleSpacing /2, 2])
				cylinder(h=30, d= 1);
			
			
				translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset + hwMicroSwitch_HoleSpacing /2, 2])
				cylinder(h=5, d= 8.5);
			}
			
			translate([0,-10,0])
			rotate([0,0,-90])
				_HIWINClearance();
			
			//translate([-rpXC_CarriageMount_LowerPointSpacing,0,rpXC_BeltMount_BaseThickness + rpXC_BeltMount_BoltHolderWidth +rpXC_BeltMount_BoltHolderOffset + 1.8]) 
			translate([0,-10,rpXC_BeltMount_BaseThickness + rpXC_BeltMount_BoltHolderWidth +rpXC_BeltMount_BoltHolderOffset - 0.25])
			rotate([0,-90,-90]) {
				_XC_CB_BoltCarveouts();
		
				mirror([0,1,0])
				_XC_CB_BoltCarveouts();
			}
		
			
			hull() {
				translate([12, -22, 40])
				rotate([90,0,0])
				cylinder(h = 18, d = 18);
			
				translate([12, -23, 40])
				rotate([90,0,0])
				cylinder(h = 16, d = 20);
			}
			
			
			translate([12, -12, 40])
			rotate([90,0,0])
			cylinder(h = 40, d = 18);
			
			translate([12, -52, 40])
			rotate([90,0,0])
			cylinder(h = 10, d = 20);
			
			translate([-12, -12, 40])
			rotate([90,0,0])
			cylinder(h = 40, d = 18);
			
			hull() {
				translate([-12, -22, 40])
				rotate([90,0,0])
				cylinder(h = 18, d = 18);
			
				translate([-12, -23, 40])
				rotate([90,0,0])
				cylinder(h = 16, d = 20);
			}
			
			translate([-12, -52, 40])
			rotate([90,0,0])
			cylinder(h = 10, d = 20);
				
			// wire routing channel
			hull() {
			translate([0, 0, 0])
			rotate([90,0,0])
			cylinder(h = 12, d = 6);
			
			// wire routing channel
			translate([4, 0, 0])
			rotate([90,0,0])
			cylinder(h = 12, d = 6);
			}
			
			//translate([0, - lowerBoltOffset /2, 26])_BoltBase(boltDiameter + rpDefaultBevel * 2, _baseThickness - rpDefaultBevel, BBStyle_Round);
		
			// bottom left assembly bolt mount base
			translate([-boltSpacing/2, -lowerBoltOffset, 26])
				cylinder(h = 26 - _baseThickness,	d = hwM4_Bolt_ShaftDiameter + gcMachineOffset + gRender_Clearance + minimumThickness + 2);
		
			// top flat cut
			translate([-100,-20,30.25])
				cube([200,80,20]);
		
			// bottom flat cut
			translate([-100,-100,-36])
				cube([200,200,40]);
		}
	}
	
	*hull() {
			translate([4, -6, 26])
			cylinder(h = 10, d = 7);
			
			translate([-4, -6, 26])
			cylinder(h = 10, d = 7);
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
				0 - (rpXC_BeltMount_BoltSpacing / 2),
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




		
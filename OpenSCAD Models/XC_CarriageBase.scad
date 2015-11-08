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

include <Dimensions.scad>

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
module Part_XC_CarriageBase() {

	difference() {
		union() {
			
			
		
			rotate([0,0,180 -rpXC_CarriageBase_StrutAngle])
				_XC_CB_Strut();
		
			
			
			rotate([0,0,rpXC_CarriageBase_StrutAngle])
				_XC_CB_Strut();
	
			// x-endstop switch holder
		
			translate([-rpXC_CarriageMount_LowerPointSpacing + rpDefaultBevel /2, rpXC_BeltMount_BoltSpacing /2 - rpXC_BeltMount_BoltHolderWidth/2, 0])
				_XC_CB_Switch();
				
			
			
			translate([-rpXC_CarriageMount_LowerPointSpacing,0,rpXC_BeltMount_BaseThickness + rpXC_BeltMount_BoltHolderWidth +rpXC_BeltMount_BoltHolderOffset + 1.8])
			rotate([0,-90,0]) {
				_XC_CB_CarriageMount();
				mirror([0,1,0])
				_XC_CB_CarriageMount();
			}
		}
		
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
// This makes the switch holder portion

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
		
		translate([hwMicroSwitch_Length /2, 0, 0]) {
			translate([hwMicroSwitch_HoleSpacing / 2, hwMicroSwitch_Width - hwMicroSwitch_HoleOffset, 0])
				cylinder(d = hwMicroSwitch_HoleSize, h = rpXC_BeltMount_BaseThickness);
			
			translate([-hwMicroSwitch_HoleSpacing / 2, hwMicroSwitch_Width - hwMicroSwitch_HoleOffset, 0])
				cylinder(d = hwMicroSwitch_HoleSize, h = rpXC_BeltMount_BaseThickness);
		}
	}
}

// -----------------------------------------------------------------------------
// This makes one strut of the three-point-mount

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
	
	translate([	0, 0, rpXC_BeltMount_BaseThickness])
	cylinder(h = rpXC_CarriageMount_BaseWidth + rpXC_CarriageMount_BaseSpacing *2, d1 = rpXC_CarriageMount_BoltHolderDiameter - (rpDefaultBevel /2), d2 = rpXC_CarriageMount_BoltHolderDiameter - rpDefaultBevel);

	// upper bolt mount
	translate([	0, rpXC_CarriageBase_StrutLength, 0])
	hull() 
	_XC_CB_PostBase(rpXC_BeltMount_BaseThickness, rpXC_CarriageMount_BoltHolderDiameter, rpDefaultBevel);
	

	translate([	0, rpXC_CarriageBase_StrutLength, rpXC_BeltMount_BaseThickness])
	cylinder(h = rpXC_CarriageMount_BaseWidth + rpXC_CarriageMount_BaseSpacing *2, d1 = rpXC_CarriageMount_BoltHolderDiameter  - (rpDefaultBevel /2), d2 = rpXC_CarriageMount_BoltHolderDiameter - rpDefaultBevel);
	
	
}

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

module Part_XC_CarriageBase_OLD() {

	// find the hypotenuse of the three bolt mount points
	//a = rpXC_BeltMount_BoltSpacing /2;
	//b = rpXC_CarriageMount_LowerClearance;
	//c = sqrt(a * a + b * b);

	difference() {
		translate([0,0,rpXC_CarriageMount_BaseWidth - rpXC_BeltMount_BoltHolderWidth])
		rotate([0,-90,0])
		{
			difference() {
				union() {
					_XC_CB_MountBase();
					_XC_CB_CarriageMount();
				
					mirror([0,1,0])  {
						_XC_CB_MountBase();
						_XC_CB_CarriageMount();
					}
				}
				
				// carve holes out of box for mounting bolts
		
				_XC_CB_BoltCarveouts();
				mirror([0,1,0]) _XC_CB_BoltCarveouts();	
			}
		}
			
		
		
		union() {
			// cut out space for Hiwin carriage, clearance of the bar and mount bolts
			hull() {
				// carriage carve out
				translate([	0,
							-rpXC_CarriageMount_BaseLength /2,
							rpXC_CarriageMount_BaseWidth /2 - rpXC_BeltMount_BoltHolderWidth])
					cube(size= [9,
								rpXC_CarriageMount_BaseLength,
								rpXC_CarriageMount_BaseWidth],
						center = false);
					
				// bar carve out

				translate([11.5,
							0,
							rpXC_CarriageMount_BaseWidth /2 + 5.5])
					cube(size= [3.2,
								32,
								rpXC_CarriageMount_BaseWidth + 1],
						center = true);
			
				translate([11.5,
							0,
							rpXC_CarriageMount_BaseWidth /2 + 5.5])
					cube(size= [5,
								32,
								rpXC_CarriageMount_BaseWidth],
						center = true);
			
				// clearance for bar/rail mounting bolts	
				translate([16.5,
							0,
							rpXC_CarriageMount_BaseWidth /2 + 5.5])
					cube(size= [5,
								32,
								3],
						center = true);

			}
			
			translate([0,0,-0.1])
			hull() { // hull()
			
				translate([9, 0, 0])
				cylinder(h = rpXC_BeltMount_BoltHolderWidth + 0.5,
						 d1 = 4,
						 d2 = 3,
						 $fn = gcFacetSmall);
						 
				translate([1.2, 6, 0])
				cylinder(h = rpXC_BeltMount_BoltHolderWidth + 0.5,
						 d1 = 4,
						 d2 = 2.4,
						 $fn = gcFacetSmall);
						 
				translate([1.2, -6, 0])
				cylinder(h = rpXC_BeltMount_BoltHolderWidth + 0.5,
						 d1 = 4,
						 d2 = 2.4,
						 $fn = gcFacetSmall);
			}
			
			*translate([-10,0,0])
			rotate([0,90,0])
				cylinder(h = 10,
						 d = rpXC_BeltMount_BoltHolderWidth * 2,
						 $fn = gcFacetSmall);
			
		}
	}
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




		
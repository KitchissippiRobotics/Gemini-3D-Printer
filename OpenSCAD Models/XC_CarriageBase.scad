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

// Default Usage:	*** comment out this call when not editing the object solo
// Part_XC_CarriageBase();


// -----------------------------------------------------------------------------

module Part_XC_CarriageBase() {

	difference() {
		translate([0,0,rpXC_CarriageMount_BaseWidth - rpXC_BeltMount_BoltHolderWidth]) {
			union() {
				rotate([0,-90,0]) {
					_XC_CarriageBase_Left();
				mirror([0,1,0])
					_XC_CarriageBase_Left();
				}
			}
		}
		
		// cut out space for Hiwin carriage and clearance of the bar
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
			hull() { // hull()
	
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
		}
	}
}

// -----------------------------------------------------------------------------
module _XC_BoltPost(_flareDiameter, _postDiameter, _postLength) {

	hull() {	// hull()
		cylinder(h = 0.1,
				 d = _flareDiameter + 3,
				 $fn = gcFacetMedium);

		cylinder(h = 2,
				 d = _flareDiameter + 1,
				 $fn = gcFacetMedium);
	}
	
	hull() {	// hull()	 
		cylinder(h = 2,
				 d = _flareDiameter +1,
				 $fn = gcFacetMedium);	
	
		cylinder(h = _postLength,
				 d = _postDiameter + 4,
				 $fn = gcFacetSmall);
	}
}

// -----------------------------------------------------------------------------

module _XC_CarriageBase_Left() {
	difference() { 
		// main box
		union() { // union()
		
			hull() { // hull()
				// base portion of the design
				translate([0 - (rpXC_CarriageMount_BaseWidth / 2) - rpXC_BeltMount_BoltHolderWidth,
						   0 - (rpXC_CarriageMount_BaseLength /2) ,
						   0])
					cube(size = [rpXC_CarriageMount_BaseWidth + rpXC_BeltMount_BoltHolderWidth,
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
			}
			
			hull() { // hull 
			
				// base portion of the design - split
				translate([0 - (rpXC_CarriageMount_BaseWidth / 2),
						   0 - (rpXC_CarriageMount_BaseLength /2),
						   0])
					cube(size = [rpXC_CarriageMount_BaseWidth,
								 rpXC_CarriageMount_BaseLength /5 - 0.5,
								 rpXC_CarriageMount_BaseHeight - rpXC_CarriageMount_BaseBevelHeight],
						 center = false);
						 
				translate([	0 - (rpXC_CarriageMount_BaseWidth / 2),
							0 - (rpXC_BeltMount_BoltSpacing / 2), 
							rpXC_BeltMount_BoltOffset])						 
				rotate([0,90,0]) 
					cylinder(	h = rpXC_CarriageMount_BaseWidth,
								d = rpXC_BeltMount_BoltSize[iBolt_ShaftDiameter] + 3,
								$fn = gcFacetMedium);
								
			}
			
			// bolt holder post (upper)
			translate([	0 - (rpXC_CarriageMount_BaseWidth / 2),
					   	0 - (rpXC_BeltMount_BoltSpacing / 2), 
					   	rpXC_BeltMount_BoltOffset])
			rotate([0,90,0]) 
				_XC_BoltPost(	rpXC_BeltMount_InnerBoltHolderDiameter,
								rpXC_BeltMount_BoltSize[iBolt_ShaftDiameter],
								rpXC_CarriageMount_BaseWidth);
											
			// bolt holder post (lower)
			translate([	-(rpXC_CarriageMount_BaseWidth / 2),
					   	0, 
					   	-rpXC_CarriageMount_LowerPointSpacing])
			rotate([0,90,0]) _XC_BoltPost(	rpXC_BeltMount_InnerBoltHolderDiameter,
											rpXC_BeltMount_BoltSize[iBolt_ShaftDiameter],
											rpXC_CarriageMount_BaseWidth);
			
			
			hull() { // hull()
				// this cube is for creating the fill-in angles from the bolt holder - lower
				*translate([0 - (rpXC_CarriageMount_BaseWidth / 2)  - rpXC_BeltMount_BoltHolderWidth,
						    0 - (rpXC_BeltMount_BoltSpacing / 2) - (rpXC_BeltMount_BoltHolderDiameter /2),
						    0 - (rpXC_BeltMount_BoltHolderWidth + 25)])
					cube(size = [rpXC_BeltMount_BoltHolderWidth,
								 (rpXC_BeltMount_BoltSpacing / 2) + (rpXC_BeltMount_BoltHolderDiameter /2), 
								 rpXC_BeltMount_BoltHolderWidth + 25], 
						 center = false);
						 
				// this cube is for creating the fill-in angles from the bolt holder - upper
				*translate([0 - (rpXC_CarriageMount_BaseWidth / 2)  - rpXC_BeltMount_BoltHolderWidth,
						   0 - (rpXC_BeltMount_BoltSpacing / 2),
						   0])
					cube(size = [rpXC_BeltMount_BoltHolderWidth,
								 rpXC_BeltMount_BoltSpacing / 2, 
								 rpXC_BeltMount_BaseWidth], 
						 center = false);
				
				
				// slightly raised face for bolt hole (upper)
				translate([	0 - (rpXC_CarriageMount_BaseWidth / 2),
					   		0 - (rpXC_BeltMount_BoltSpacing / 2), 
					   		rpXC_BeltMount_BoltOffset])
				rotate([0,90,0]) cylinder(	h = 1,
					 						d = rpXC_BeltMount_InnerBoltHolderDiameter + 2,
					 						$fn = gcFacetMedium);
					 
				// slightly raised face for bolt hole (lower)
				translate([	-(rpXC_CarriageMount_BaseWidth / 2),
					   		0, 
					   		-rpXC_CarriageMount_LowerPointSpacing])
				rotate([0,90,0]) cylinder(	h = 1,
					 						d = rpXC_BeltMount_InnerBoltHolderDiameter + 2,
					 						$fn = gcFacetMedium);

		
				// bolt holder (upper)
				translate([-(rpXC_CarriageMount_BaseWidth / 2) - rpXC_BeltMount_BoltHolderWidth, -(rpXC_BeltMount_BoltSpacing / 2), rpXC_BeltMount_BoltOffset])
				rotate([0,90,0])	
					cylinder(h = rpXC_BeltMount_BoltHolderWidth,
							 d = rpXC_BeltMount_BoltHolderDiameter,
							 $fn = gcFacetMedium);
							 
				// bolt holder (lower)
				translate([	-(rpXC_CarriageMount_BaseWidth / 2) - rpXC_BeltMount_BoltHolderWidth,
							0,
							-rpXC_CarriageMount_LowerPointSpacing])
				rotate([0,90,0])	
					cylinder(h = rpXC_BeltMount_BoltHolderWidth,
							 d = rpXC_BeltMount_BoltHolderDiameter,
							 $fn = gcFacetMedium);
							 
			}
			

		
		}
		
		
		
		// carve holes out of box for mounting bolts
		union() {

		
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
	}
}


		
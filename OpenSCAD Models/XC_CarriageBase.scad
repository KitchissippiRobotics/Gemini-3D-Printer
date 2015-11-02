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

module Part_XC_CarriageBase() {

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
	hull() { // hull()	
		// slightly raised face for bolt hole (upper)
		translate([-(rpXC_CarriageMount_BaseWidth / 2) - rpXC_BeltMount_BoltHolderWidth,
					-(rpXC_BeltMount_BoltSpacing /2), 
					rpXC_BeltMount_BoltOffset])
		rotate([0,90,0]) 
			_XC_CB_PostBase(rpXC_BeltMount_BoltHolderWidth, rpXC_BeltMount_BoltHolderDiameter, 1);
						

					  
		// slightly raised face for bolt hole (lower)
		translate([	-(rpXC_CarriageMount_BaseWidth / 2) - rpXC_BeltMount_BoltHolderWidth,
					0, 
					-rpXC_CarriageMount_LowerPointSpacing])
		rotate([0,90,0]) 
			_XC_CB_PostBase(rpXC_BeltMount_BoltHolderWidth, rpXC_BeltMount_BoltHolderDiameter, 1);
	 			 
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
			cube(size = [rpXC_CarriageMount_BaseWidth +2,
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
				 
		translate([-(rpXC_CarriageMount_BaseWidth / 2) -5,
				   -(rpXC_CarriageMount_BaseLength /2),
				   rpXC_CarriageMount_BaseBevelHeight])
		rotate([0,90,0])
			cylinder(	h = rpXC_CarriageMount_BaseWidth + rpXC_BeltMount_BoltHolderWidth,
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
		
		translate([-(rpXC_CarriageMount_BaseWidth / 2),
				   -(rpXC_CarriageMount_BaseLength /2),
				   rpXC_CarriageMount_BaseBevelHeight -1.3])
		rotate([0,90,0])
			cylinder(	h = rpXC_CarriageMount_BaseWidth,
						d = rpXC_BeltMount_BoltSize[iBolt_ShaftDiameter] + 3);
					
						 
				translate([	0 - (rpXC_CarriageMount_BaseWidth / 2),
							0 - (rpXC_BeltMount_BoltSpacing / 2), 
							rpXC_BeltMount_BoltOffset])						 
				rotate([0,90,0]) 
					cylinder(	h = rpXC_CarriageMount_BaseWidth,
								d = rpXC_BeltMount_BoltSize[iBolt_ShaftDiameter] + 3,
								$fn = gcFacetMedium);
								
			}
}



// -----------------------------------------------------------------------------

module _XC_CarriageBase_Left() {
	difference() { 
		// main box
		union() { // union()
		
			#union() { // hull()
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


		
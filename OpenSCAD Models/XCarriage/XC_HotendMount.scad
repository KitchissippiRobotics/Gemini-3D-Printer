// *****************************************************************************
// ( )/ )(_  _)(_  _)___(  _ \(  _  )(  _ \(  _  )(_  _)(_  _)/ __)/ __)
//  )  (  _)(_   )( (___))   / )(_)(  ) _ < )(_)(   )(   _)(_( (__ \__ \
// (_)\_)(____) (__)    (_)\_)(_____)(____/(_____) (__) (____)\___)(___/
// *****************************************************************************
// Written by bcantin@kitchissippi-robotics.com
// Copyright (c) 2015 Kitchissippi Robotics
// -----------------------------------------------------------------------------
// Hotend-Assembly Component
// *****************************************************************************

include <XC_Common.scad>

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Default Usage:	
// Part_XC_HotendMount();
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// Determine if MultiPartMode is enabled - if not, render the part automatically
// and enable support material (if it is defined)

if (MultiPartMode == undef) {
	MultiPartMode = false;
	EnableSupport = true;
	
	*Part_HA_CarriageBase();
	Part_XC_HotendMount();
} else {
	EnableSupport = false;
}

// -----------------------------------------------------------------------------
// Put it all together and carve out the hardware clearances
// -----------------------------------------------------------------------------

module Part_XC_HotendMount() {

	yOffset = -6;

	difference() {
		union() {

			_HotendMount_BoltPosts();	
			
			hull() {
			
			translate([-hwHA_Hotend_Spacing /2, -8, hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing - 4])
			rotate([90,0,0])
				cylinder(h = 5, d = 20);
				
			translate([hwHA_Hotend_Spacing /2, -8, hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing - 4])
			rotate([90,0,0])
				cylinder(h = 5, d = 20);
				
				_HotendMount_LinearMount();
			}
			
			
			_HotendMount_Wing();
			mirror([1,0,0])
				_HotendMount_Wing();
				
			_HotendMount_LowerBrace();
			mirror([1,0,0])
				_HotendMount_LowerBrace();
			
			hull() {
				translate([25, -lowerBoltOffset/2 - 3.5, 0])
					_BoltBase(6, 13.5, BBStyle_Round);
		
				translate([18, -lowerBoltOffset/2 +1, 0])
					_BoltBase(8, 13.5, BBStyle_Round);
			}
		
			hull() {
				translate([18, -lowerBoltOffset/2 + 1, 0])
					_BoltBase(8, 13.5, BBStyle_Round);
		
				translate([0, -lowerBoltOffset/2 + 1, 0])
					_BoltBase(8, 13.5, BBStyle_Round);
			}
			
			mirror([1,0,0])
			hull() {
				translate([25, -lowerBoltOffset/2 - 3.5, 0])
					_BoltBase(6, 13.5, BBStyle_Round);
		
				translate([18, -lowerBoltOffset/2 +1, 0])
					_BoltBase(8, 13.5, BBStyle_Round);
			}
			
			mirror([1,0,0])
			hull() {
				translate([18, -lowerBoltOffset/2 + 1, 0])
					_BoltBase(8, 13.5, BBStyle_Round);
		
				translate([0, -lowerBoltOffset/2 + 1, 0])
					_BoltBase(8, 13.5, BBStyle_Round);
			}
			
			
				
			union() {
			
			translate([-hwHA_Hotend_Spacing /2, -1, hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing - 4])
			rotate([90,0,0])
				cylinder(h = 7, d1 = 15, d2 = 20);
				
			
				
			translate([hwHA_Hotend_Spacing /2, -1, hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing - 4])
			rotate([90,0,0])
				cylinder(h = 7, d1 = 15, d2 = 20);
			}
				
		}
		
		// XC Mounting Bolts
		translate([rpXC_UpperMount_BoltSpacing / 2, 0, -38])
			Carve_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, rpXC_BeltMount_BoltLength, 50);
			
		translate([-rpXC_UpperMount_BoltSpacing / 2, 0, -38])
			Carve_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, rpXC_BeltMount_BoltLength, 50);
			
		// XC Mounting Bolts
		translate([rpXC_BeltMount_BoltSpacing / 2, -lowerBoltOffset, -38])
			Carve_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, rpXC_BeltMount_BoltLength);
			
		translate([-rpXC_BeltMount_BoltSpacing / 2, -lowerBoltOffset, -38])
			Carve_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, rpXC_BeltMount_BoltLength);	
			
			
		// hotend upper
		
		translate([0,0,0]) {
			CarveOut();
			mirror([1,0,0]) CarveOut();
		}
		
		// bowden tube carveout
		translate([hwHA_Hotend_Spacing /2, 0, hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing - 4])
		rotate([90,0,0])
		cylinder(h = 20, d = 4.6);
		
		translate([-hwHA_Hotend_Spacing /2, 0, hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing - 4])
		rotate([90,0,0])
		cylinder(h = 20, d = 4.6);
		
		
		// pushfit carveout
		translate([-hwHA_Hotend_Spacing /2, 1, hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing - 4])
		rotate([90,0,0])
		cylinder(h = 10, d = 9);
		
		
		translate([-hwHA_Hotend_Spacing /2, 9, hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing - 4])
		rotate([90,0,0])
		cylinder(h = 10, d = 15);
		
		
		// pushfit carveout
		translate([hwHA_Hotend_Spacing /2, 1, hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing - 4])
		rotate([90,0,0])
		cylinder(h = 10, d = 9);
		
		translate([hwHA_Hotend_Spacing /2, 9, hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing - 4])
		rotate([90,0,0])
		cylinder(h = 10, d = 15);
		
		translate([-50,-50,-20])
		cube([100,100, 20]);
		
		translate([25, -lowerBoltOffset/2 - 3.0, -0.1])
		rotate([0,0,15])
				cylinder(h = 8, d1 = 8, d2 = 6.6, $fn = 6);
	
		translate([25, -lowerBoltOffset/2 - 3.0, 9])
				cylinder(h = 5, d = 3.2);
				
				
		translate([-25, -lowerBoltOffset/2 - 3.0, -0.1])
		rotate([0,0,-15])
				cylinder(h = 8, d1 = 8, d2 = 6.6, $fn = 6);
	
		translate([-25, -lowerBoltOffset/2 - 3.0, 9])
				cylinder(h = 5, d = 3.2);
	}
}

// -----------------------------------------------------------------------------
// Just Draw the bolt posts
// -----------------------------------------------------------------------------

module _HotendMount_BoltPosts() {
	// top left assembly bolt mount base
	translate([-rpXC_UpperMount_BoltSpacing/2, 0, 0])
		cylinder(	h = rpXC_FrontBracketThickness,	
					d1 = hwM4_Bolt_ShaftDiameter + gcMachineOffset + minimumThickness,
					d2 = hwM4_Bolt_ShaftDiameter + gcMachineOffset + minimumThickness + 2,
					$fn = gcFacetLarge);
		
	// top right assembly bolt mount base
	translate([rpXC_UpperMount_BoltSpacing/2, 0, 0])
		cylinder(	h = rpXC_FrontBracketThickness,	
					d1 = hwM4_Bolt_ShaftDiameter + gcMachineOffset + minimumThickness,
					d2 = hwM4_Bolt_ShaftDiameter + gcMachineOffset + minimumThickness + 2,
					$fn = gcFacetLarge);
					
	// bottom left assembly bolt mount base
	translate([-boltSpacing/2, -lowerBoltOffset, 0])
		cylinder(	h = rpXC_FrontBracketThickness,	
					d1 = hwM4_Bolt_ShaftDiameter + gcMachineOffset + minimumThickness,
					d2 = hwM4_Bolt_ShaftDiameter + gcMachineOffset + minimumThickness + 2,
					$fn = gcFacetLarge);
		
	// bottom right assembly bolt mount base
	translate([boltSpacing/2, -lowerBoltOffset, 0])
		cylinder(	h = rpXC_FrontBracketThickness,	
					d1 = hwM4_Bolt_ShaftDiameter + gcMachineOffset + minimumThickness,
					d2 = hwM4_Bolt_ShaftDiameter + gcMachineOffset + minimumThickness + 2,
					$fn = gcFacetLarge);
			
}

// -----------------------------------------------------------------------------
// Linear Mount
// -----------------------------------------------------------------------------

module _HotendMount_LinearMount(_yOffset = -6) {

	// some calculations used in the module
	centerSize = rpXC_CenterModuleDepth / 3;

	// block for bolts to mount through
	hull() {
		translate([8, _yOffset, 0])
			cylinder(h = 10, d1 = 9, d2 = 6, $fn = gcFacetLarge);

		translate([-8, _yOffset, 0])
			cylinder(h = 10, d1 = 9, d2 = 6, $fn = gcFacetLarge);
	}
}

// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------

module _HotendMount_LowerBrace(_yOffset = -6) {
	// -- lower portion of the wing
	hull() {
		translate([-boltSpacing/2, -lowerBoltOffset /2 - 3, 0])
			cylinder(h = rpXC_FrontBracketThickness -1,	d1 = 10, d2 = 8);

		translate([-8, _yOffset, 0])
				cylinder(h = rpXC_FrontBracketThickness, d1 = 9, d2 = 7);
	}

	// -- connect lower portion of the wing to lower bolt
	hull() {
		translate([-boltSpacing/2, -lowerBoltOffset /2 -3, 0])
			cylinder(h = rpXC_FrontBracketThickness -1,	d1 = 10, d2 = 8);

		translate([-boltSpacing/2, -lowerBoltOffset, 0])
				cylinder(h = rpXC_FrontBracketThickness, d = 8);
	}
}

// -----------------------------------------------------------------------------
// Wing to attach the linear carriage mount to the bolt post 
// - left side, mirror to get right side
// -----------------------------------------------------------------------------

module _HotendMount_Wing(_yOffset = -6) {

	// -- base portion of the wing
	hull() {
		translate([-rpXC_UpperMount_BoltSpacing/2, 0, 0])
			cylinder(h = rpXC_FrontBracketThickness,	d1 = 2.5, d2 = 2);

		translate([-8, _yOffset, 0])
				cylinder(h = rpXC_FrontBracketThickness, d1 = 4.5, d2 = 4);
		
		translate([-8, _yOffset  -2, 0])
				cylinder(h = rpXC_FrontBracketThickness / 2, d = 5);
	}		
}

// -----------------------------------------------------------------------------
// Put it all together and carve out the hardware clearances
// -----------------------------------------------------------------------------

module CarveOut() {
	translate([0,-10,-4])
		rotate([0,0,-90])
		union() {
		
		// top of hotend
		translate([hwHA_Hotend_VerticalOffset,
					hwHA_Hotend_Spacing /2,
					hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing])
		rotate([0,90,0])
			cylinder(h = 5,
					 d = 17);
					 
		translate([hwHA_Hotend_VerticalOffset,
					hwHA_Hotend_Spacing /2 - 8.5,
					hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing])
			cube([5, 17, 8.5], center = false);			 
					
		// hotend groovemount
		translate([hwHA_Hotend_VerticalOffset + 4.67,
					hwHA_Hotend_Spacing /2,
					hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing])
		rotate([0,90,0])
			cylinder(h = 4.67,
					 d = 13);
		translate([hwHA_Hotend_VerticalOffset + 4.67,
					hwHA_Hotend_Spacing /2 - 6.5,
					hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing])
			cube([4.67, 13, 6.5], center = false);
			
		// hotend lower
		translate([hwHA_Hotend_VerticalOffset + 2 * 4.67,
					hwHA_Hotend_Spacing /2,
					hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing])
		rotate([0,90,0])
			cylinder(h = 40 - 2 * 4.67,
					 d = 20);
				 
		*rotate([0,-90,0])
			_HA_CB_BoltCarveouts();
			
		*translate([10, -25, -0.1])
		rotate([0,0,15])
				cylinder(h = 8, d1 = 8, d2 = 6.8, $fn = 6);
		}
}

module Part_HA_CarriageBase() {
	difference() {
		union() {	// combine the sub components that make up the parts
			
			_HACB_BoltBases(BBStyle_Taper);
			_HACB_HotendMount();
			//_XCCB_BoltSkeleton(BBStyle_Round);
			
			hull() {
			
			translate([-hwHA_Hotend_Spacing /2, -8, hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing - 4])
			rotate([90,0,0])
				cylinder(h = 5, d = 22);
			
			translate([-hwHA_Hotend_Spacing /2, -1, hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing - 4])
			rotate([90,0,0])
				cylinder(h = 12, d1 = 15, d2 = 22);
				
			translate([hwHA_Hotend_Spacing /2, -8, hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing - 4])
			rotate([90,0,0])
				cylinder(h = 5, d = 22);
				
			translate([hwHA_Hotend_Spacing /2, -1, hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing - 4])
			rotate([90,0,0])
				cylinder(h = 12, d1 = 15, d2 = 22);
			}
			
			// top right brace
	hull() {
		// top left assembly bolt mount base
		translate([boltSpacing/2, 0, 0])
			_BoltBase(0, 4.5, BBStyle_Round);
		
		translate([8, -7, 0])
				_BoltBase(0, 4.5, BBStyle_Round);	
				
		translate([boltSpacing/2, -lowerBoltOffset /2 - 3, 0]) 
			_BoltBase(0, 4.5, BBStyle_Round);	
	}

	// top left brace
	hull() {
		// top left assembly bolt mount base
		translate([-boltSpacing/2, 0, 0])
			_BoltBase(0, 4.5, BBStyle_Round);
		
		translate([-8, -7, 0])
				_BoltBase(0, 4.5, BBStyle_Round);	
			
		translate([-boltSpacing/2, -lowerBoltOffset /2 - 3, 0]) 
			_BoltBase(0, 4.5, BBStyle_Round);	
		
	}
	
	hull() {
		translate([8, -6, 0])
			cylinder(h = 4.5, d = 8);
				
		translate([-8, -6, 0])
			cylinder(h = 4.5, d = 8);
			
		translate([8, -6, 0])
			cylinder(h = 17, d = 6);
				
		translate([-8, -6, 0])
			cylinder(h = 17, d = 6);	

	}
		}
		
		// hotend upper
		
		translate([0,0,0]) {
			CarveOut();
			mirror([1,0,0]) CarveOut();
		}
		
		// bowden tube carveout
		translate([hwHA_Hotend_Spacing /2, 0, hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing - 4])
		rotate([90,0,0])
		cylinder(h = 20, d = 4.6);
		
		translate([-hwHA_Hotend_Spacing /2, 0, hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing - 4])
		rotate([90,0,0])
		cylinder(h = 20, d = 4.6);
		
		
		// pushfit carveout
		translate([-hwHA_Hotend_Spacing /2, 1, hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing - 4])
		rotate([90,0,0])
		cylinder(h = 10, d = 9);
		
		
		translate([-hwHA_Hotend_Spacing /2, 9, hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing - 4])
		rotate([90,0,0])
		cylinder(h = 10, d = 15);
		
		
		// pushfit carveout
		translate([hwHA_Hotend_Spacing /2, 1, hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing - 4])
		rotate([90,0,0])
		cylinder(h = 10, d = 9);
		
		translate([hwHA_Hotend_Spacing /2, 9, hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing - 4])
		rotate([90,0,0])
		cylinder(h = 10, d = 15);
		
		translate([-50,-50,-20])
		cube([100,100, 20]);
		
		translate([25, -lowerBoltOffset/2 - 3.0, -0.1])
		rotate([0,0,15])
				cylinder(h = 8, d1 = 8, d2 = 6.6, $fn = 6);
	
		translate([25, -lowerBoltOffset/2 - 3.0, 9])
				cylinder(h = 5, d = 3.2);
				
				
		translate([-25, -lowerBoltOffset/2 - 3.0, -0.1])
		rotate([0,0,15])
				cylinder(h = 8, d1 = 8, d2 = 6.6, $fn = 6);
	
		translate([-25, -lowerBoltOffset/2 - 3.0, 9])
				cylinder(h = 5, d = 3.2);
	}
}

// -----------------------------------------------------------------------------

module _HACB_BaseLeft() {

	

	difference() {
		union() {
			hull() {
				translate([boltSpacing/2, 0, 0])
					_BoltBase(boltDiameter - 1.5, 5, BBStyle_Round);
					
				translate([boltSpacing/2, -lowerBoltOffset, 0])
					_BoltBase(boltDiameter - 1.5, 5, BBStyle_Round);
			}
			

		
		
			hull() {
				translate([25, -lowerBoltOffset/2 - 3.5, 0])
					_BoltBase(6, 13.5, BBStyle_Round);
		
				translate([18, -lowerBoltOffset/2 +1, 0])
					_BoltBase(8, 13.5, BBStyle_Round);
			}
		
			hull() {
				translate([18, -lowerBoltOffset/2 + 1, 0])
					_BoltBase(8, 13.5, BBStyle_Round);
		
				translate([0, -lowerBoltOffset/2 + 1, 0])
					_BoltBase(8, 13.5, BBStyle_Round);
			}
		
		
		
	}
	

				
			
	
	}
				

}

// -----------------------------------------------------------------------------
// Just Draw the bolt bases
// -----------------------------------------------------------------------------

module _HACB_BoltBases(baseBBStyle) {

	
	mirror([1,0,0]) _HACB_BaseLeft();
	_HACB_BaseLeft();
	
	mirror([1,0,0]) _HACB_HotendMount();
	_HACB_HotendMount();
	

}

module _HACB_HotendMount() {
	// draw a cube to fit in the slots
	*translate([0, -10, 0])
	rotate([90,0,0])
	cube([25, 15, 10]);
}

// -----------------------------------------------------------------------------
// WARNING: Be very careful modifying this - the values are from the original 
// 			version which is all sorts of a different orientation
// -----------------------------------------------------------------------------

module _HA_CB_BoltCarveouts() {



	// [rpXC_BeltMount_BoltDepth - rpXC_BeltMount_BaseOffset, 0 - (rpXC_BeltMount_BoltSpacing / 2), rpXC_BeltMount_BoltOffset]
	translate([-rpXC_BeltMount_BoltDepth + rpXC_BeltMount_BaseOffset - 12,
				0 - (rpXC_BeltMount_BoltSpacing / 2),
				rpXC_BeltMount_BoltOffset])
	rotate([0,90,0])
		Carve_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, rpXC_BeltMount_BoltLength, 10);
				
		
	// [rpXC_BeltMount_BoltDepth - rpXC_BeltMount_BaseOffset, 0 - (rpXC_BeltMount_BoltSpacing / 2), rpXC_BeltMount_BoltOffset]
	translate([-rpXC_BeltMount_BoltDepth + rpXC_BeltMount_BaseOffset - 12,
				0 - (rpXC_BeltMount_BoltSpacing / 2),
				-lowerBoltOffset + 10])
	rotate([0,90,0])
		Carve_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, rpXC_BeltMount_BoltLength, 10);
}

// -----------------------------------------------------------------------------
// Just Draw the skeleton frame between the bolt bases
// -----------------------------------------------------------------------------

/*module _XCCB_BoltSkeleton(baseBBStyle) {

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

	
}*/

// *****************************************************************************
// Old code - Beware, here be dragons
// *****************************************************************************

module _strutBase() {
	a = rpXC_BeltMount_BoltSpacing/2;
	b = rpXC_CarriageMount_LowerClearance + rpXC_CarriageMount_BoltHolderDiameter + rpXC_BeltMount_BoltHolderWidth /2 -1;
	c = sqrt(a * a + b * b) ;
	
	difference() {
		hull() {
			_PostBase(rpXC_BeltMount_BoltHolderWidth, 10, 2);

			translate([-5,0,0])
					cube ([10, c, rpXC_BeltMount_BoltHolderWidth], center = false);

			translate([0,c,0])	
				_PostBase(rpXC_BeltMount_BoltHolderWidth, 10, 2);
		}
		
		translate([-3,0,3])
					#cube ([6, c, rpXC_BeltMount_BoltHolderWidth - 3], center = false);
		
	}
	
	hull() _PostBase(rpXC_BeltMount_BoltHolderWidth, 10, 2);
	hull() translate([0,c,0])	
				_PostBase(rpXC_BeltMount_BoltHolderWidth, 10, 2);
}

module _topStrut() {

/*
	D'oh ... this diagram is upside down... no worries
	
	The purpose is to create a shape which can be rotated into place rather than create
	the shape at an angle to start with.
	This allows for more control over and detail over the initial shape.
	Bear with me for a basic geometry refresher...

			B
		  /	|
  		 /	|
	  c /	|
	   /	|	b
	  /		|	
	 /		|
	/_____90|
	A	a	C
	
	A = atan(a/b)					{ solve for a }
	B = atan(b/a)					{ solve for b }
	C = 90
	
	A + B + C = 180					{ all three angles total 180 degrees }
	
	a = rpXC_BeltMount_BoltSpacing /2
	b = rpXC_CarriageMount_LowerPointSpacing
	c = sqrt(a * a + b * b)			{ solve for length of c, to determine shape size}
		
*/
	
	a = rpXC_BeltMount_BoltSpacing/2;
	b = rpXC_CarriageMount_LowerClearance + rpXC_CarriageMount_BoltHolderDiameter + rpXC_BeltMount_BoltHolderWidth /2 -1;
	c = sqrt(a * a + b * b) ;
	
	A = atan(a/b);
	B = atan(b/a);


	translate([rpXC_CarriageMount_LowerPointSpacing,0,0])
	rotate([0,0,B])
		_strutBase();
	translate([rpXC_CarriageMount_LowerPointSpacing,0,0])
	rotate([0,0,180 - B])
		_strutBase();	
	
	
}



module _HA_Strut() {
	difference() {
		union() { 
			_topStrut();											// union()
			*hull() { 											// hull()
			// top left post location
			translate([	-rpXC_CarriageMount_BaseHeight,
						rpXC_BeltMount_BoltSpacing /2,
						0])
				_PostBase(5, 10, 2);
	
			// bottom post location	
			translate([	rpXC_CarriageMount_LowerPointSpacing +1,
						0,
						0])
				_PostBase(5, 10, 2);
				
			*translate([	-rpXC_CarriageMount_BaseHeight,
					rpXC_BeltMount_BoltSpacing /2 + rpXC_BeltMount_BoltHolderDiameter /4,
					0])
			cylinder( 	h =5,
							d = 3);
						
			*translate([	hwHA_Hotend_VerticalOffset + 4.67 + 4.67 /2,
						rpXC_BeltMount_BoltSpacing /2 + rpXC_BeltMount_BoltHolderDiameter /4,
						0])
					cylinder( 	h =12,
								d = 3);
			}
			
			*hull() {											// hull()
			translate([	hwHA_Hotend_VerticalOffset + 4.67,
						0,
						0])
				cube([4.67, rpXC_BeltMount_BoltSpacing /2 + rpXC_BeltMount_BoltHolderDiameter /2 - 4.67, 12]);
				
			translate([	hwHA_Hotend_VerticalOffset + 4.67 + 4.67 /2,
						rpXC_BeltMount_BoltSpacing /2 + 4.67 /2,
						0])
					cylinder( 	h =12,
								d = 4.67);
			}
			
			hull() {
			
			translate([	-rpXC_CarriageMount_BaseHeight,
						rpXC_BeltMount_BoltSpacing /2 + rpXC_BeltMount_BoltHolderDiameter /4,
						0])
				cylinder( 	h =5,
								d = 3);
						
			translate([	hwHA_Hotend_VerticalOffset + 4.67 + 4.67 /2,
						rpXC_BeltMount_BoltSpacing /2 + rpXC_BeltMount_BoltHolderDiameter /4,
						0])
					cylinder( 	h =12,
								d = 3);
			}
		}													// union()
		
		// hotend upper
		translate([hwHA_Hotend_VerticalOffset,
					hwHA_Hotend_Spacing /2,
					hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing])
		rotate([0,90,0])
			cylinder(h = 4.67,
					 d = 16.2);
		// hotend groovemount
		translate([hwHA_Hotend_VerticalOffset + 4.67,
					hwHA_Hotend_Spacing /2,
					hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing])
		rotate([0,90,0])
			cylinder(h = 4.67,
					 d = 12.2);
				
		// hotend lower
		translate([hwHA_Hotend_VerticalOffset + 2 * 4.67,
					hwHA_Hotend_Spacing /2,
					hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing])
		rotate([0,90,0])
			cylinder(h = 40 - 2 * 4.67,
					 d = 25);
	}
	
	// hotend spacing
	*translate([hwHA_Hotend_VerticalOffset,
				hwHA_Hotend_Spacing /2,
				hwHA_Hotend_Offset - rpXC_CarriageMount_BaseWidth /2 - rpXC_CarriageMount_BaseSpacing])
	rotate([0,90,0])
		cylinder(h = 40,
				 d = 16);
	

}

// -----------------------------------------------------------------------------
module _PostBase(baseHeight, baseDiameter, baseOffset) {
	$fn = gcFacetMedium;
	
	cylinder(		h = baseHeight,
					d = baseDiameter - baseOffset /2);
				
	translate([0,0,0])
		cylinder(	h = baseHeight - baseOffset,
					d = baseDiameter);
}
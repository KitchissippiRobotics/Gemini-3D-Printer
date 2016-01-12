// *****************************************************************************
// ( )/ )(_  _)(_  _)___(  _ \(  _  )(  _ \(  _  )(_  _)(_  _)/ __)/ __)
//  )  (  _)(_   )( (___))   / )(_)(  ) _ < )(_)(   )(   _)(_( (__ \__ \
// (_)\_)(____) (__)    (_)\_)(_____)(____/(_____) (__) (____)\___)(___/
// *****************************************************************************
// Written by bcantin@kitchissippi-robotics.com
// Copyright (c) 2015 Kitchissippi Robotics
// -----------------------------------------------------------------------------
// XC_BlowerCase.scad
// Part No. XB-
// Generates XC_BlowerCase.stl
// *****************************************************************************

include <../Dimensions.scad>
include <XC_Common.scad>


// -----------------------------------------------------------------------------
// Default Usage:	
// Part_XC_BlowerCase();
// -----------------------------------------------------------------------------

// Determine if MultiPartMode is enabled - if not, render the part automatically
// and enable support material (if it is defined)

if (MultiPartMode == undef) {
	MultiPartMode = false;
	EnableSupport = true;
	
	Part_XC_BlowerCase();
} else {
	EnableSupport = false;
}

// -----------------------------------------------------------------------------
// Put it all together and carve out the hardware clearances
// -----------------------------------------------------------------------------

module Part_XC_BlowerCase() {

	yOffsetTemp = 34;
	
	diameterTweak = 6;
	hotendGuideAdjustment = -2;

	difference() {
		union() {
			// start with the base elements
			_BlowerCase_BoltPosts();
			_BlowerCase_MainBox(diameterTweak);
			_BlowerCase_IntakeBulge();
			_BlowerCase_BoltMount(diameterTweak);
			_BlowerCase_OutputCap(diameterTweak);
			_BlowerCase_OutputVents(diameterTweak);
			
			translate([0, hotendGuideAdjustment, 0])
			_BlowerCase_HotendGuide(diameterTweak);
			
		}
			
		// Carve out space for blower and output channels
		translate([0 - BlowerXOffset,yOffsetTemp -1, -4])
			_BlowerCarveout();		
			
		// carve out left bolt hole
		translate([-rpXC_LowerMount_BoltSpacing/2, 0, 0])
			Carve_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, rpXC_BeltMount_BoltLength, 0);
		
		// carve out right bolt hole
		translate([rpXC_LowerMount_BoltSpacing/2, 0, 0])
			Carve_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, rpXC_BeltMount_BoltLength, 0);
			
		// left assembly bolt mount base clearance
		translate([-rpXC_LowerMount_BoltSpacing/2, 0, rpXC_CenterModuleDepth])
			cylinder(h = rpXC_CenterModuleDepth - _baseThickness,	d = hwM4_Bolt_ShaftDiameter + gcMachineOffset + gRender_Clearance + minimumThickness + 2);
			
		// right assembly bolt mount base clearance
		translate([rpXC_LowerMount_BoltSpacing/2, 0, rpXC_CenterModuleDepth])
			cylinder(h = rpXC_CenterModuleDepth - _baseThickness,	d = hwM4_Bolt_ShaftDiameter + gcMachineOffset + gRender_Clearance + minimumThickness + 2);
			
	}
}

// -----------------------------------------------------------------------------
// Bolt Posts
// -----------------------------------------------------------------------------

module _BlowerCase_BoltPosts() {
	// --- posts for bolts
	
	// left assembly bolt 
	translate([-rpXC_LowerMount_BoltSpacing/2, 0, 0])
		cylinder(h = rpXC_CenterModuleDepth,	d = hwM4_Bolt_ShaftDiameter + gcMachineOffset + gRender_Clearance + minimumThickness);
			
	hull() {
		// central bolt post
		translate([rpXC_LowerMount_BoltSpacing/2, 0, 0])
			cylinder(h = rpXC_CenterModuleDepth,	d = hwM4_Bolt_ShaftDiameter + gcMachineOffset + gRender_Clearance + minimumThickness);		
											
		// bulge for support around blower mount bolt			
		translate([rpXC_LowerMount_BoltSpacing/2, 0, _baseThickness])
			cylinder(h = 10,	d2 = hwM4_Bolt_ShaftDiameter + gcMachineOffset + gRender_Clearance + minimumThickness + 4,
								d1 = hwM4_Bolt_ShaftDiameter + gcMachineOffset + gRender_Clearance + minimumThickness + 4);
	}
}

// -----------------------------------------------------------------------------
// Main Box
// -----------------------------------------------------------------------------

module _BlowerCase_MainBox(_boxEdgeDiameter = 6, _boxEdgeExtension = 20) {
	// --- form the box portion around the output hole -----
	hull() {
		
		// bottom front left edge
		translate([-12 - BlowerXOffset,-21,0])
		cylinder(h = 1, d = _boxEdgeDiameter);
		
		// bottom front right edge
		translate([12 + BlowerCaseExtension - BlowerXOffset,-21,0])
		cylinder(h = 1, d = _boxEdgeDiameter);
		
		// bottom rear left edge
		translate([-12 - BlowerXOffset,-4.5,0])
		cylinder(h = 1, d = _boxEdgeDiameter);
		
		// bottom rear right edge
		translate([12 + BlowerCaseExtension - BlowerXOffset,-4.5,0])
		cylinder(h = 1, d = _boxEdgeDiameter);
		
		
		// top front left edge
		translate([-12 - BlowerXOffset,-21,rpXC_CenterModuleDepth - (_boxEdgeDiameter / 2)])
		sphere(d = _boxEdgeDiameter);
		
		// top front right edge
		translate([12 + BlowerCaseExtension - BlowerXOffset,-21,rpXC_CenterModuleDepth  - (_boxEdgeDiameter / 2)])
		sphere(d = _boxEdgeDiameter);
		
		// top rear left edge
		translate([-12 - BlowerXOffset,-4.5,rpXC_CenterModuleDepth - (_boxEdgeDiameter / 2)])
		sphere(d = _boxEdgeDiameter);
		
		// top rear right edge
		translate([12 + BlowerCaseExtension -BlowerXOffset,-4.5,rpXC_CenterModuleDepth  - (_boxEdgeDiameter / 2)])
		sphere(d = _boxEdgeDiameter);
	
	}
}

// -----------------------------------------------------------------------------
// Cap over the blower output
// -----------------------------------------------------------------------------

module _BlowerCase_OutputCap (_boxEdgeDiameter = 6, _boxEdgeExtension = 20) {

	// --- form the box portion around *only* the output hole -----
	hull() {
		
		// bottom front left edge
		translate([-12 - BlowerXOffset,-21,0])
		cylinder(h = 1, d = _boxEdgeDiameter);
		
		// bottom front right edge
		translate([12  - BlowerXOffset,-21,0])
		cylinder(h = 1, d = _boxEdgeDiameter);
		
		// bottom rear left edge
		translate([-12 - BlowerXOffset,-4.5,0])
		cylinder(h = 1, d = _boxEdgeDiameter);
		
		// bottom rear right edge
		translate([12 - BlowerXOffset,-4.5,0])
		cylinder(h = 1, d = _boxEdgeDiameter);
		
		
		// top front left edge
		translate([-12 - BlowerXOffset,-21,rpXC_CenterModuleDepth])
		sphere(d = _boxEdgeDiameter);
		
		// top front right edge
		translate([12 - BlowerXOffset,-21,rpXC_CenterModuleDepth])
		sphere(d = _boxEdgeDiameter);
		
		// top rear left edge
		translate([-12 - BlowerXOffset,-4.5,rpXC_CenterModuleDepth])
		sphere(d = _boxEdgeDiameter);
		
		// top rear right edge
		translate([12 -BlowerXOffset,-4.5,rpXC_CenterModuleDepth])
		sphere(d = _boxEdgeDiameter);
	
	}

}

// -----------------------------------------------------------------------------
// Bulge for air intake clearance
// -----------------------------------------------------------------------------

module _BlowerCase_IntakeBulge() {
	difference() {
		// air intake clearance
		hull() {
			translate([16 -BlowerXOffset,2,-6])
			rotate([90,0,0])
			cylinder(h = 1, d = 36);
	
			translate([16 -BlowerXOffset,-4.5,-2])
			rotate([90,0,0])
			cylinder(h = 1, d = 36);
		}
	
		// bottom flat cut - remove the portion that extends below the print line
			translate([-100,-100,-40])
				cube([200,200,40]);
	}
}

// -----------------------------------------------------------------------------
// Bolt mount for blower fan
// -----------------------------------------------------------------------------

module _BlowerCase_BoltMount(_boxEdgeDiameter = 6) {
	hull() {		
		// attachment bolt point
		translate([36 -BlowerXOffset,-20.5,12])
		rotate([90,0,0])
		_BoltBase(5.0 + rpDefaultBevel, _boxEdgeDiameter, BBStyle_Round);
		
		// top front right edge
		translate([12 + BlowerCaseExtension -BlowerXOffset,-21,rpXC_CenterModuleDepth - (_boxEdgeDiameter / 2)])
		sphere(d = _boxEdgeDiameter);
		
		// bottom front right edge
		translate([12 + BlowerCaseExtension -BlowerXOffset,-21,0])
		cylinder(h = 1, d = _boxEdgeDiameter);
		
		// base of attachement point
		*translate([28 -BlowerXOffset,-21,0])
		cylinder(h = 18, d = _boxEdgeDiameter);
		
	}
}

// -----------------------------------------------------------------------------
// Output Vents
// -----------------------------------------------------------------------------

module _BlowerCase_OutputVents(_boxEdgeDiameter = 6) {

	// hole spacing is centred around the expected 24mm spacing from the initial 
	// design spec - do some mods to adjust for alternative spacing
	
	outOffset = (24 -  hwHA_Hotend_Spacing) /2;

		// left output
	hull() {
		// rounded sections around left output hole
		translate([-2, -26, 22.5])
		sphere(d = 5);
		
		translate([-19 + outOffset, -26, 22.5])
		sphere(d = 5);
		
		// top front left edge
		translate([-12 - BlowerXOffset,-21,rpXC_CenterModuleDepth])
		sphere(d = _boxEdgeDiameter);
		
		translate([-14.5 -BlowerXOffset, -18, 2])
		rotate([90,0,90])
		cylinder(h = 23.5, d = 2);
		
		// top rear left edge
		translate([-12 - BlowerXOffset,-4.5,rpXC_CenterModuleDepth])
		sphere(d = _boxEdgeDiameter);
		
		// top rear right edge
		translate([12 -BlowerXOffset,-4.5,rpXC_CenterModuleDepth])
		sphere(d = _boxEdgeDiameter);
		
	}
		
	// right output
	hull() {
		// 
	
		// rounded sections around right output hole
		translate([2, -26, 22.5])
		sphere(d = 5);
	
		translate([19 - outOffset, -26, 22.5])
		sphere(d = 5);
		
		
		// 
		translate([10 -BlowerXOffset, -18, 2])
		rotate([90,0,90])
		cylinder(h = 23.5, d = 2);
		
		// top rear left edge
		translate([-12 - BlowerXOffset,-4.5,rpXC_CenterModuleDepth])
		sphere(d = _boxEdgeDiameter);
		
		// top rear right edge
		translate([12 -BlowerXOffset,-4.5,rpXC_CenterModuleDepth])
		sphere(d = _boxEdgeDiameter);
		
	}
	

}

// -----------------------------------------------------------------------------
// Hotend Guide
// -----------------------------------------------------------------------------

module _BlowerCase_HotendGuide(_boxEdgeDiameter = 6) {
	// --- guide for lower portion of J-Head PEEK to ensure:
	// - it sits level (primary)
	// - the heating block does not come in contact with the blower outputs (secondary)
	// - direct some airflow (tertiary)
	
	difference() {
		hull() {
			translate([22, -12, 20])
			cylinder(h = 15, d1 = _boxEdgeDiameter, d2 = 4);
		
			translate([-22 , -12, 20])
			cylinder(h = 15, d1 = _boxEdgeDiameter, d2 = 4);
		
			// top rear left edge
			translate([-12 - BlowerXOffset,-4.5,rpXC_CenterModuleDepth  - (_boxEdgeDiameter / 2)])
			sphere(d = _boxEdgeDiameter);
		
			// top rear right edge
			translate([12 + BlowerCaseExtension -BlowerXOffset,-4.5,rpXC_CenterModuleDepth  - (_boxEdgeDiameter / 2)])
			sphere(d = _boxEdgeDiameter);
		}
		
		// this makes the airflow curve to direct air up around the the casing through the x-carriage
		hull() {
			translate([-25, 4, 36])
			rotate([0,90,0])
			cylinder(h= 50, d = 25);
		
			translate([-20, 4, 36])
			rotate([0,90,0])
			cylinder(h= 40, d = 30);
		}
		
		// carve out the hotend channels
		
		translate([hwHA_Hotend_Spacing /2, 0, hwHA_Hotend_Offset + 11])
		rotate([90, 0, 0])
		cylinder(h= 50, d = 17);
		
		translate([-hwHA_Hotend_Spacing /2, 0, hwHA_Hotend_Offset + 11])
		rotate([90, 0, 0])
		cylinder(h= 50, d = 17);
	}
}

// *****************************************************************************
// ( )/ )(_  _)(_  _)___(  _ \(  _  )(  _ \(  _  )(_  _)(_  _)/ __)/ __)
//  )  (  _)(_   )( (___))   / )(_)(  ) _ < )(_)(   )(   _)(_( (__ \__ \
// (_)\_)(____) (__)    (_)\_)(_____)(____/(_____) (__) (____)\___)(___/
// *****************************************************************************
// Written by bcantin@kitchissippi-robotics.com
// Copyright (c) 2015 Kitchissippi Robotics
// -----------------------------------------------------------------------------
// XC_Common.scad
// Code that is reused for several pieces of the XCarriage assembly
// -----------------------------------------------------------------------------
// Note that there is some rotation done in the part module - this part started
// it's design with a different print orientation than it currently has.
// *****************************************************************************

include <../Dimensions.scad>

//$fn = 20;

// -----------------------------------------------------------------------------
// Some internal switch values:
// -----------------------------------------------------------------------------

BBStyle_Simple = 0;
BBStyle_Bevel = 1;
BBStyle_Round = 2;
BBStyle_Taper = 3;

// -----------------------------------------------------------------------------
// Adjustment of the blower casing:
// -----------------------------------------------------------------------------

BlowerXOffset = 10;
BlowerCaseExtension = 20;

// -----------------------------------------------------------------------------
// Some internal used values:
// -----------------------------------------------------------------------------

_baseThickness = rpDefaultBaseThickness + 5 /*+ rpDefaultBevel * 2*/;		// mm
minimumThickness = 4; // mm
boltSpacing = rpXC_BeltMount_BoltSpacing;		// mm
boltDiameter = hwM4_Bolt_ShaftDiameter;
lowerBoltOffset = rpXC_BeltMount_BoltOffset + rpXC_CarriageMount_LowerPointSpacing;	// mm
bevelSize = rpDefaultBevel;	// mm

switchXOffset = rpXC_BeltMount_BoltSpacing / 2 + 3;
switchYOffset = -9.5;

caseRightSide = switchXOffset + hwMicroSwitch_ScrewHeadDiameter;
caseLeftSide = caseRightSide;	// symmetrical sizes
caseTopSide = 20;
caseBottomSide = 20;

caseWallThickness = minimumThickness;
caseHeight = 60;
caseWidth = 2 * (switchXOffset) ;
caseOffset = -20;
caseDepth = 60;

// are these still needed?
	xOffset = 7;
	yOffset = 10;
	zOffset = 17;
	
	switchOffset  = 2;
	
	
	
// -----------------------------------------------------------------------------
// Blower Fan Carvout
// -----------------------------------------------------------------------------

module _BlowerCarveout() {

	// main blower channel
	translate([-12, -53.5, 0])
	cube([20, 16, 25]);
	
	// main blower body
	translate([18,-37.5,-5])
	rotate([90,0,0])
	cylinder(h = 16, d = 57);
	
	// air intake clearance
	hull() {
		translate([16,-33,-5])
		rotate([90,0,0])
		cylinder(h = 10, d = 34);
	
		translate([16,-38,-5])
		rotate([90,0,0])
		cylinder(h = 1, d = 38);
	}
	
	// slot for blower's casing snap
	translate([-12,-45.5,0])
	cylinder(h= 22, d =3.5);
	
	
	// right output channel
	hull() {
		translate([-1, -39, 25])
		rotate([90,0,90])
		cylinder(h = 9, d = 3);
		
		translate([-1, -52, 25])
		rotate([90,0,90])
		cylinder(h = 9, d = 3);
	}
	
	hull() {
		// right output hole
		translate([6 + BlowerXOffset, -61, 28])
		rotate([90,0,90])
		cylinder(h = 12, d = 1.5);
		
		translate([-1, -52, 25])
		rotate([90,0,90])
		cylinder(h = 9, d = 3);
		
		translate([-1, -39, 25])
		rotate([90,0,90])
		cylinder(h = 9, d = 3);
	}
	
	// left output channel
	hull() {
	
		translate([-12, -39, 25])
		rotate([90,0,90])
		cylinder(h = 8, d = 3);
		
		translate([-12, -52, 25])
		rotate([90,0,90])
		cylinder(h = 8, d = 3);
	}
	
	hull() {
		// left output hole
		translate([-18 + BlowerXOffset, -61, 28])
		rotate([90,0,90])
		cylinder(h = 12, d = 1.5);
		
		translate([-12, -54, 25])
		rotate([90,0,90])
		cylinder(h = 8, d = 3);
	}
	
	// bolt hole and nut trap
	
	translate([36,-30,16])
		rotate([90,0,0])
		cylinder(h = 30, d = 4.25);
		
	translate([36,-55.5,16])
		rotate([90,0,0])
		cylinder(h = 5, d = 8.8, $fn = 6);
		
		
	translate([36,-37.5,16])
		rotate([90,0,0])
		cylinder(h = 16, d = 15);
		
	*translate([36,-36,16])
		rotate([90,0,0])
		cylinder(h = 10, d = 4.25);
		
	*translate([36,-20,16])
		rotate([90,0,0])
		cylinder(h = 22, d1 = 9, d2 = 9);
		
	translate([36,-26.5,16])
		rotate([90,0,0])
		cylinder(h = 10, d1 = 9.5, d2 = 9.25);
	
}
	
	

// -----------------------------------------------------------------------------
// Draw the case base outline shape (experimental)
// -----------------------------------------------------------------------------

module _XCCB_OutlineCase(postMod = 0, lowerMod = 0) {
	translate([0, lowerBoltOffset /2, 0])
	hull() {
	
		// top belt clamp area
		
		translate([-18, 6, 0])
			circle(d = 8);
	
		translate([18, 6, 0])
			circle(d = 8);
			
		// top clamp mount right
		
		translate([-boltSpacing/2, 0, 0])
			circle(d = 16 + postMod);
			
		// top clamp mount left
		
		translate([boltSpacing/2, 0, 0])
			circle(d = 16 + postMod);
			
			
		// switch holder
	
		translate([caseWidth/2, - rpXC_BeltMount_BoltOffset + switchYOffset + hwMicroSwitch_HoleSpacing /2 + 3, 0])
			circle(d = 12);
		translate([caseWidth/2, - rpXC_BeltMount_BoltOffset + switchYOffset - hwMicroSwitch_HoleSpacing /2 - 3, 0])
			circle(d = 12);
			
		// mirror of switch holder
		
		translate([-caseWidth/2, - rpXC_BeltMount_BoltOffset + switchYOffset + hwMicroSwitch_HoleSpacing /2 +3, 0])
			circle(d = 10);
		translate([-caseWidth/2, - rpXC_BeltMount_BoltOffset + switchYOffset - hwMicroSwitch_HoleSpacing /2 - 3, 0])
			circle(d = 10);	
			
		// bottom blower range
		
		translate([18, -40, 0])
			circle(d = 10);
			
		translate([-18, -40, 0])
			circle(d = 10);
		
	}
}

module _XCCB_OutlineCase_Base(postMod = 0, lowerMod = 0) {
	$fn = 100;
	translate([0, lowerBoltOffset /2, 0])
	hull() {
		hull() {
	
			// top belt clamp area
		
			translate([-20, 6, 0])
				circle(d = 8);
	
			translate([20, 6, 0])
				circle(d = 8);
			
			// top clamp mount right
		
			translate([-rpXC_BeltMount_BoltSpacing/2, 0, 0])
				circle(d = 16 + postMod);
			
			// top clamp mount left
		
			translate([rpXC_BeltMount_BoltSpacing/2, 0, 0])
				circle(d = 16 + postMod);
			
			
			// bottom blower range
		
			translate([15, -48, 0])
				circle(d = 20);
			
			translate([-15, -48, 0])
				circle(d = 20);
		
		}
	

		hull() {
				// switch holder
	
			translate([caseWidth/2, - rpXC_BeltMount_BoltOffset + switchYOffset + hwMicroSwitch_HoleSpacing /2 + 3, 0])
				circle(d = 12);
			translate([caseWidth/2, - rpXC_BeltMount_BoltOffset + switchYOffset - hwMicroSwitch_HoleSpacing /2 - 3, 0])
				circle(d = 12);
	
			// switch holder
			mirror([1,0,0])
			translate([rpXC_BeltMount_BoltOffset, - rpXC_BeltMount_BoltOffset + switchYOffset + hwMicroSwitch_HoleSpacing /2 + 3, 0])
				circle(d = 12);
			
			mirror([1,0,0])
			translate([rpXC_BeltMount_BoltOffset, - rpXC_BeltMount_BoltOffset + switchYOffset - hwMicroSwitch_HoleSpacing /2 - 3, 0])
				circle(d = 12);
		}
	}
}

module _XCCB_OutlineCase_Upper(postMod = 0, lowerMod = 0) {
	$fn = 100;
	translate([0, lowerBoltOffset /2, 0])
	hull() {
		hull() {
	
			// top belt clamp area
		
			translate([-10, 2, 0])
				circle(d = 8);
	
			translate([10, 2, 0])
				circle(d = 8);
			
			// top clamp mount right
		
			translate([-boltSpacing/2 - 4, 1, 0])
				circle(d = 10);
			
			// top clamp mount left
		
			translate([boltSpacing/2 + 4, 1, 0])
				circle(d = 10);
			
			
			
			// bottom blower range
		
			translate([20, -42, 0])
				circle(d = 15);
			
			translate([-20, -42, 0])
				circle(d = 15);
		
		}
		
		hull() {
				// switch holder
	
			translate([caseWidth/2, - rpXC_BeltMount_BoltOffset + switchYOffset + hwMicroSwitch_HoleSpacing /2 + 3, 0])
				circle(d = 12);
			translate([caseWidth/2, - rpXC_BeltMount_BoltOffset + switchYOffset - hwMicroSwitch_HoleSpacing /2 - 3, 0])
				circle(d = 12);
		}
	
		mirror([1,0,0])

		hull() {
				// switch holder
	
			translate([rpXC_BeltMount_BoltOffset, - rpXC_BeltMount_BoltOffset + switchYOffset + hwMicroSwitch_HoleSpacing /2 + 3, 0])
				circle(d = 12);
			translate([rpXC_BeltMount_BoltOffset, - rpXC_BeltMount_BoltOffset + switchYOffset - hwMicroSwitch_HoleSpacing /2 - 3, 0])
				circle(d = 12);
		}
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



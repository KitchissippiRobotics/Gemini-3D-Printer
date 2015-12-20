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
minimumThickness = 4; // mm
boltSpacing = 40;		// mm
boltDiameter = hwM4_Bolt_ShaftDiameter;
lowerBoltOffset = rpXC_BeltMount_BoltOffset + rpXC_CarriageMount_LowerPointSpacing;	// mm
bevelSize = rpDefaultBevel;	// mm

switchXOffset = 24;
switchYOffset = -10.0;

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
// Draw the case base outline shape (experimental)
// -----------------------------------------------------------------------------

module _XCCB_OutlineCase(postMod = 0) {
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
		
		translate([15, -40, 0])
			circle(d = 20);
			
		translate([-15, -40, 0])
			circle(d = 20);
		
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

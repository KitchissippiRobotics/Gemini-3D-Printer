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

switchXOffset = 25;
switchYOffset = -10;

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

module _XCCB_OutlineCase(outlineThickness = 1) {
	translate([0, lowerBoltOffset /2, 0])
	hull() {
	
		// top belt clamp area
		
		translate([-18, 6, 0])
			circle(d = 8);
	
		translate([18, 6, 0])
			circle(d = 8);
			
		// top clamp mount right
		
		translate([-boltSpacing/2, 0, 0])
			circle(d = 16);
			
		// top clamp mount left
		
		translate([boltSpacing/2, 0, 0])
			circle(d = 16);
			
			
		// switch holder
	
		translate([caseWidth/2, - rpXC_BeltMount_BoltOffset + switchYOffset + hwMicroSwitch_HoleSpacing /2 + 5, 0])
			circle(d = 12);
		translate([caseWidth/2, - rpXC_BeltMount_BoltOffset + switchYOffset - hwMicroSwitch_HoleSpacing /2 - 5, 0])
			circle(d = 12);
			
		// mirror of switch holder
		
		translate([-caseWidth/2, - rpXC_BeltMount_BoltOffset + switchYOffset + hwMicroSwitch_HoleSpacing /2 +5, 0])
			circle(d = 10);
		translate([-caseWidth/2, - rpXC_BeltMount_BoltOffset + switchYOffset - hwMicroSwitch_HoleSpacing /2 - 5, 0])
			circle(d = 10);	
			
		// bottom blower range
		
		translate([15, -40, 0])
			circle(d = 20);
			
		translate([-15, -40, 0])
			circle(d = 20);
		
	}
}

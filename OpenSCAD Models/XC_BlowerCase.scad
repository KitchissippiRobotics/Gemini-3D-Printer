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

include <Dimensions.scad>
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

	difference() {
		union() {
			// start with the base elements
			_BlowerCase_BoltPosts();
			
			*translate([0 - BlowerXOffset,yOffsetTemp,0])
				_XCBC_BlowerCase();
				
			_BlowerCase_MainBox(4);
			_BlowerCase_IntakeBulge();
			_BlowerCase_BoltMount(4);
			_BlowerCase_OutputVents();
			
		}
			
		// Carve out space for blower and output channels
		translate([0 - BlowerXOffset,yOffsetTemp -1,0])
			_BlowerCarveout();
			
		// bottom flat cut
		translate([-100,-100,-36])
			cube([200,200,40]);
			
		// carve out left bolt hole
		translate([-boltSpacing/2, 0, 0])
			Carve_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, rpXC_BeltMount_BoltLength, 0);
		
		// carve out right bolt hole
		translate([boltSpacing/2, 0, 0])
			Carve_hw_Bolt_AllenHead(rpXC_BeltMount_BoltSize, rpXC_BeltMount_BoltLength, 0);
			
		// bottom left assembly bolt mount base clearance
		translate([-boltSpacing/2, 0, 26])
			cylinder(h = 26 - _baseThickness,	d = hwM4_Bolt_ShaftDiameter + gcMachineOffset + gRender_Clearance + minimumThickness + 2);
			
	}
}

// -----------------------------------------------------------------------------
// Bolt Posts
// -----------------------------------------------------------------------------

module _BlowerCase_BoltPosts() {
	// --- posts for bolts
	
	// left assembly bolt 
	translate([-boltSpacing/2, 0, 0])
		cylinder(h = 26,	d = hwM4_Bolt_ShaftDiameter + gcMachineOffset + gRender_Clearance + minimumThickness + 1);
			
	hull() {
		// central bolt post
		translate([boltSpacing/2, 0, 0])
			cylinder(h = 26,	d = hwM4_Bolt_ShaftDiameter + gcMachineOffset + gRender_Clearance + minimumThickness + 1);		
											
		// bulge for support around blower mount bolt			
		translate([boltSpacing/2, 0, _baseThickness + 4])
			cylinder(h = 10,	d2 = hwM4_Bolt_ShaftDiameter + gcMachineOffset + gRender_Clearance + minimumThickness + 3.8,
								d1 = hwM4_Bolt_ShaftDiameter + gcMachineOffset + gRender_Clearance + minimumThickness + 3.8);
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
		cylinder(h = 1, d = _boxEdgeDiameter + 3);
		
		// bottom front right edge
		translate([12 + BlowerCaseExtension - BlowerXOffset,-21,0])
		cylinder(h = 1, d = _boxEdgeDiameter + 3);
		
		// bottom rear left edge
		translate([-12 - BlowerXOffset,-4.5,0])
		cylinder(h = 1, d = _boxEdgeDiameter + 3);
		
		// bottom rear right edge
		translate([12 + BlowerCaseExtension - BlowerXOffset,-4.5,0])
		cylinder(h = 1, d = _boxEdgeDiameter + 3);
		
		
		// top front left edge
		translate([-12 - BlowerXOffset,-21,22])
		sphere(d = _boxEdgeDiameter);
		
		// top front right edge
		translate([12 + BlowerCaseExtension - BlowerXOffset,-21,22])
		sphere(d = _boxEdgeDiameter);
		
		// top rear left edge
		translate([-12 - BlowerXOffset,-4.5,22])
		sphere(d = _boxEdgeDiameter);
		
		// top rear right edge
		translate([12 + BlowerCaseExtension -BlowerXOffset,-4.5,22])
		sphere(d = _boxEdgeDiameter);
	
	}
}

// -----------------------------------------------------------------------------
// Bulge for air intake clearance
// -----------------------------------------------------------------------------

module _BlowerCase_IntakeBulge() {
	// air intake clearance
	hull() {
		translate([16 -BlowerXOffset,2,-5])
		rotate([90,0,0])
		cylinder(h = 1, d = 36);
	
		translate([16 -BlowerXOffset,-4.5,2])
		rotate([90,0,0])
		cylinder(h = 1, d = 36);
	}
}

// -----------------------------------------------------------------------------
// Bolt mount for blower fan
// -----------------------------------------------------------------------------

module _BlowerCase_BoltMount(_boxEdgeDiameter = 6) {
	hull() {		
		// attachment bolt point
		translate([36 -BlowerXOffset,-20.5,16])
		rotate([90,0,0])
		_BoltBase(5.5 + rpDefaultBevel, 6, BBStyle_Round);
		
		// top front right edge
		translate([12 + BlowerCaseExtension -BlowerXOffset,-21,22])
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

module _BlowerCase_OutputVents() {
		// left output
	hull() {
		// rounded sections around left output hole
		translate([-2, -26, 26.5])
		sphere(d = 5);
		
		translate([-18, -26, 26.5])
		sphere(d = 5);
		
		translate([-13 -BlowerXOffset, -18, 25])
		rotate([90,0,90])
		cylinder(h = 22, d = 6.5);
		
		translate([-14.5 -BlowerXOffset, -18, 0])
		rotate([90,0,90])
		cylinder(h = 23.5, d = 2);
		
	}
		
	// right output
	hull() {
		// rounded sections around right output hole
		translate([2, -26, 26.5])
		sphere(d = 5);
	
		translate([18, -26, 26.5])
		sphere(d = 5);
		
		translate([-13 -BlowerXOffset, -18, 25])
		rotate([90,0,90])
		cylinder(h = 22, d = 6.5);
		
		translate([10 -BlowerXOffset, -18, 0])
		rotate([90,0,90])
		cylinder(h = 23.5, d = 2);
		
	}
	
	// right blower cover
	hull() {
		translate([-13 -BlowerXOffset, -18, 25])
		rotate([90,0,90])
		cylinder(h = 13.5, d = 6.5);
		
		translate([-13 -BlowerXOffset, -6, 25])
		rotate([90,0,90])
		cylinder(h = 13.5, d = 6.5);
		
	}
	
	// left blower cover
	hull() {
		translate([-3 -BlowerXOffset, -6, 25])
		rotate([90,0,90])
		cylinder(h = 12.5, d = 6.5);
		
		translate([-3 -BlowerXOffset, -18, 25])
		rotate([90,0,90])
		cylinder(h = 12.5, d = 6.5);
	}
}

// -----------------------------------------------------------------------------
// Blower Fan Case
// -----------------------------------------------------------------------------

module _XCBC_BlowerCase() {

	_boxEdgeDiameter = 6;
	_boxEdgeExtension = 20;
	
	
							

	// --- form the box portion around the output hole -----
	hull() {
		
		// bottom front left edge
		translate([-12,-55,0])
		cylinder(h = 1, d = _boxEdgeDiameter + 3);
		
		// bottom front right edge
		translate([12 + BlowerCaseExtension,-55,0])
		cylinder(h = 1, d = _boxEdgeDiameter + 3);
		
		// bottom rear left edge
		translate([-12,-38.5,0])
		cylinder(h = 1, d = _boxEdgeDiameter + 3);
		
		// bottom rear right edge
		translate([12 + BlowerCaseExtension,-38.5,0])
		cylinder(h = 1, d = _boxEdgeDiameter + 3);
		
		
		// top front left edge
		translate([-12,-55,22])
		sphere(d = _boxEdgeDiameter);
		
		// top front right edge
		translate([12 + BlowerCaseExtension,-55,22])
		sphere(d = _boxEdgeDiameter);
		
		// top rear left edge
		translate([-12,-38.5,22])
		sphere(d = _boxEdgeDiameter);
		
		// top rear right edge
		translate([12 + BlowerCaseExtension,-38.5,22])
		sphere(d = _boxEdgeDiameter);
	
	}
	
	// --- guide for lower portion of J-Head PEEK to ensure:
	// - it sits level (primary)
	// - the heating block does not come in contact with the blower outputs
	// - direct some airflow (tertiary)
	
	*hull() {
		translate([30, -49, 24])
		cylinder(h = 10, d1 = 6, d2 = 4);
		
		translate([-30 + BlowerCaseExtension, -49, 24])
		cylinder(h = 10, d1 = 6, d2 = 4);
	}
	
	// --- bit of a bulge for the airflow
	// air intake clearance
	hull() {
		translate([16,-32,-5])
		rotate([90,0,0])
		cylinder(h = 1, d = 36);
	
		translate([16,-38.5,2])
		rotate([90,0,0])
		cylinder(h = 1, d = 36);
	}
	
	// bolt mount

	hull() {		
		// attachement bolt point
		translate([36,-54.5,16])
		rotate([90,0,0])
		_BoltBase(5.5 + rpDefaultBevel, 6, BBStyle_Round);
		
		// top front right edge
		translate([12 + BlowerCaseExtension,-55,22])
		sphere(d = _boxEdgeDiameter);
		
		// bottom front right edge
		translate([12 + BlowerCaseExtension,-55,0])
		cylinder(h = 1, d = _boxEdgeDiameter);
		
		// base of attachement point
		*translate([28,-55,0])
		cylinder(h = 18, d = _boxEdgeDiameter);
		
	}
	
	// left output
	hull() {
		// rounded sections around left output hole
		translate([-2 + BlowerXOffset, -60, 26.5])
		sphere(d = 5);
		
		translate([-18 + BlowerXOffset, -60, 26.5])
		sphere(d = 5);
		
		translate([-14.5, -52, 25])
		rotate([90,0,90])
		cylinder(h = 23.5, d = 6.5);
		
		translate([-14.5, -52, 0])
		rotate([90,0,90])
		cylinder(h = 23.5, d = 2);
		
		*translate([-14.5, -40, 25])
		rotate([90,0,90])
		cylinder(h = 13.5, d = 6.25);
	}
	
	hull() {
		translate([-14.5, -52, 25])
		rotate([90,0,90])
		cylinder(h = 13.5, d = 6.5);
		
		translate([-14.5, -40, 25])
		rotate([90,0,90])
		cylinder(h = 13.5, d = 6.5);
		
	}
	
	// right output
	hull() {
		// rounded sections around right output hole
		translate([2 + BlowerXOffset, -60, 26.5])
		sphere(d = 5);
	
		translate([18 + BlowerXOffset, -60, 26.5])
		sphere(d = 5);
		
		translate([-2, -52, 25])
		rotate([90,0,90])
		cylinder(h = 23.5, d = 6.5);
		
		translate([10, -52, 0])
		rotate([90,0,90])
		cylinder(h = 23.5, d = 2);
		
		*translate([-2, -40, 25])
		rotate([90,0,90])
		cylinder(h = 12.5, d = 6.5);
	}
		
	hull() {
		translate([-2, -40, 25])
		rotate([90,0,90])
		cylinder(h = 12.5, d = 6.5);
		
		translate([-2, -52, 25])
		rotate([90,0,90])
		cylinder(h = 12.5, d = 6.5);
	}
		
	
		/*translate([-1, -39, 25.5])
		rotate([90,0,90])
		cylinder(h = 14, d = 7);
		
		translate([-12, -55, 22])
		rotate([90,0,90])
		cylinder(h = 24, d = _boxEdgeDiameter);
		
		translate([-12, -55, 0])
		rotate([90,0,90])
		cylinder(h = 24, d = _boxEdgeDiameter);
		
		translate([-12, -38.5, 10])
		rotate([90,0,90])
		cylinder(h = 24, d = _boxEdgeDiameter - 0.5);*/
	
}
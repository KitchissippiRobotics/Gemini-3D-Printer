// *****************************************************************************
// ( )/ )(_  _)(_  _)___(  _ \(  _  )(  _ \(  _  )(_  _)(_  _)/ __)/ __)
//  )  (  _)(_   )( (___))   / )(_)(  ) _ < )(_)(   )(   _)(_( (__ \__ \
// (_)\_)(____) (__)    (_)\_)(_____)(____/(_____) (__) (____)\___)(___/
// *****************************************************************************
// Written by bcantin@kitchissippi-robotics.com
// Copyright (c) 2016 Kitchissippi Robotics
// -----------------------------------------------------------------------------
// ZA_CarriageBase.scad
// Part No. 
// Generates ZA_CarriageBase.stl
// *****************************************************************************

include <../Dimensions.scad>

_drawHardware = false;
//$fn = 200;
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Default Usage:	
// Part_ZA_CarriageBase();
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// Determine if MultiPartMode is enabled - if not, render the part automatically
// and enable support material (if it is defined)

if (MultiPartMode == undef) {
	MultiPartMode = false;
	EnableSupport = true;
	
	Part_ZA_CarriageBase();
} else {
	EnableSupport = false;
}

// draw smooth rods

if (_drawHardware) {
	%translate([hwZA_RodXSpacing / 2, -hwZA_RodYSpacing /2, -hwZA_RodLength / 2])
	cylinder(h = hwZA_RodLength, d = hwZA_RodDiameter);

	%translate([-hwZA_RodXSpacing / 2, -hwZA_RodYSpacing /2, -hwZA_RodLength / 2])
	cylinder(h = hwZA_RodLength, d = hwZA_RodDiameter);

	%translate([hwZA_RodXSpacing / 2, hwZA_RodYSpacing /2, -hwZA_RodLength / 2])
	cylinder(h = hwZA_RodLength, d = hwZA_RodDiameter);

	%translate([-hwZA_RodXSpacing / 2, hwZA_RodYSpacing /2, -hwZA_RodLength / 2])
	cylinder(h = hwZA_RodLength, d = hwZA_RodDiameter);

	%translate([hwZA_RodXSpacing / 2 + hwZA_BearingDiameter /2, - hwZA_BearingDiameter/2 +hwZA_RodYSpacing /2, hwZA_BearingLength])
	import("../Vitamins/LM12UU_Bearing.stl", convexity=3);
	
	%translate([-hwZA_RodXSpacing / 2 + hwZA_BearingDiameter /2, - hwZA_BearingDiameter/2 +hwZA_RodYSpacing /2, hwZA_BearingLength])
	import("../Vitamins/LM12UU_Bearing.stl", convexity=3);
	
	%translate([hwZA_RodXSpacing / 2 + hwZA_BearingDiameter /2, -hwZA_RodYSpacing /2 - hwZA_BearingDiameter/2, hwZA_BearingLength])
	import("../Vitamins/LM12UU_Bearing.stl", convexity=3);
	
	%translate([-hwZA_RodXSpacing / 2 + hwZA_BearingDiameter /2, -hwZA_RodYSpacing /2 - hwZA_BearingDiameter/2, hwZA_BearingLength])
	import("../Vitamins/LM12UU_Bearing.stl", convexity=3);
	
	*translate([hwZA_RodXSpacing / 2 + hwZA_BearingDiameter /2, hwZA_RodYSpacing /2 - hwZA_BearingDiameter/2, hwZA_BearingLength *2 +hwZA_BearingZSpacing])
	import("../Vitamins/LM12UU_Bearing.stl", convexity=3);
	
	*translate([-hwZA_RodXSpacing / 2 + hwZA_BearingDiameter /2, hwZA_RodYSpacing /2 - hwZA_BearingDiameter/2, hwZA_BearingLength *2 + hwZA_BearingZSpacing])
	import("../Vitamins/LM12UU_Bearing.stl", convexity=3);
	
	
	%translate([0,0,hwZA_BushingZOffset])
	import("../Vitamins/leadscrew_bushing.stl", convexity=3);
	
	
	%translate([hwZA_ArmSpacing /2 - hwZA_ArmWidth/2, hwZA_ArmYOffset, hwZA_ArmZOffset])
	cube([hwZA_ArmWidth, hwZA_ArmLength, hwZA_ArmWidth]);
	
	%translate([-hwZA_ArmSpacing /2 - hwZA_ArmWidth/2, hwZA_ArmYOffset, hwZA_ArmZOffset])
	cube([hwZA_ArmWidth, hwZA_ArmLength, hwZA_ArmWidth]);
}


module _Fine_Tuner() {
	// z fine tuning adjuster
	hull() {		
		translate([20, -15, -4])
		cylinder(h = 5, d = 8);
	
		translate([20, -15, -4])
		cylinder(h = 7, d = 6);
	
	
		translate([26.5, 0, -4])
		cylinder(h = 6, d = 12);
	
		translate([26.5, 0, -4])
		cylinder(h = 8, d = 10);
	}
	
	hull() {		
		translate([20, 15, -4])
		cylinder(h = 5, d = 8);
	
		translate([20, 15, -4])
		cylinder(h = 7, d = 6);
	
	
		translate([26.5, 0, -4])
		cylinder(h = 6, d = 12);
	
		translate([26.5, 0, -4])
		cylinder(h = 8, d = 10);
	}
	
	hull() {		
		translate([40, 0, -4])
		cylinder(h = 5, d = 8);
	
		translate([40, 0, -4])
		cylinder(h = 7, d = 6);
	
	
		translate([26.5, 0, -4])
		cylinder(h = 6, d = 12);
	
		translate([26.5, 0, -4])
		cylinder(h = 8, d = 10);
	}
}

// -----------------------------------------------------------------------------
// Put it all together and carve out the hardware clearances
// -----------------------------------------------------------------------------

module Part_ZA_CarriageBase() {
	difference() {
		union() {
		
			// central portion and arm boxes
			_ZAxisArmTest();
			mirror([1,0,0])
				_ZAxisArmTest();
			
			
			// draw bearing holders	
			translate([hwZA_RodXSpacing /2, 0, -4]) {
			_Base_BearingCapHalf();
			mirror([0,1,0])
				_Base_BearingCapHalf();
			}
			
			translate([-hwZA_RodXSpacing /2, 0, -4]) 
			mirror([1,0,0]) {
			_Base_BearingCapHalf();
			mirror([0,1,0])
				_Base_BearingCapHalf();
			}
			
			_Fine_Tuner();
				
		}
		
		translate([26.5, 0, -5.1])
				cylinder(h = 5, d1 = 8.6, d2 = 8.6, $fn = 6);
				
		translate([26.5, 0, 2.0])
			cylinder(h = 5, d = 11);
		
		translate([26.5, 0, 0.0])
			cylinder(h = 10, d = 5);	
			
		
		translate([hwZA_RodXSpacing /2,-50, -5])
		cube([60,100,100]);
		translate([-hwZA_RodXSpacing /2 -60,-50, -5])
		cube([60,100,100]);

		// carve out drive rod
		translate([0,0, - 20])
		cylinder(h = 100, d = hwZA_DriveRodDiameter + 0.5);
		
		// carve out rear bearings
		/*translate([hwZA_RodXSpacing /2, -hwZA_RodYSpacing /2, 0])
		cylinder(h = hwZA_BearingLength + 20, d = hwZA_BearingDiameter + 0.6);
		
		translate([-hwZA_RodXSpacing /2, -hwZA_RodYSpacing /2, 0])
		cylinder(h = hwZA_BearingLength + 20, d = hwZA_BearingDiameter + 0.6);*/
		
		// carve out front bearings
		/*hull() {
			#translate([hwZA_RodXSpacing /2, hwZA_RodYSpacing /2, 0])
			cylinder(h = hwZA_BearingLength + 1, d = hwZA_BearingDiameter + 0.6);
			
			translate([hwZA_RodXSpacing /2, hwZA_RodYSpacing /2, 0])
			cylinder(h = hwZA_BearingLength + 4, d = hwZA_BearingDiameter + 0.6 - 4);
		}*/
		
		translate([hwZA_RodXSpacing /2, hwZA_RodYSpacing /2, 0])
		_BearingCarveOut();
		
		translate([-hwZA_RodXSpacing /2, hwZA_RodYSpacing /2, 0])
		_BearingCarveOut();
		
		translate([hwZA_RodXSpacing /2, -hwZA_RodYSpacing /2, 0])
		_BearingCarveOut();
		
		translate([-hwZA_RodXSpacing /2, -hwZA_RodYSpacing /2, 0])
		_BearingCarveOut();
		
		/*translate([-hwZA_RodXSpacing /2, hwZA_RodYSpacing /2, 0])
		cylinder(h = hwZA_BearingLength + 20, d = hwZA_BearingDiameter + 0.6);*/
		
		// carve out doubled front bearings
		/*translate([hwZA_RodXSpacing /2, hwZA_RodYSpacing /2, hwZA_BearingLength + hwZA_BearingZSpacing])
		cylinder(h = hwZA_BearingLength, d = hwZA_BearingDiameter);
		
		translate([-hwZA_RodXSpacing /2, hwZA_RodYSpacing /2, hwZA_BearingLength + hwZA_BearingZSpacing])
		cylinder(h = hwZA_BearingLength, d = hwZA_BearingDiameter);*/
		
		// carve center out bushing
		translate([0,0,hwZA_BushingZOffset])
		cylinder(h = hwZA_BushingHeight, d = hwZA_BushingDiameter + 0.6);
		
		translate([0,0, hwZA_BushingZOffset])
		cylinder(h = hwZA_BushingLipHeight, d = hwZA_BushingLipDiameter);
		
		// carve out arms
		translate([hwZA_ArmSpacing /2 - hwZA_ArmWidth/2 - 0.3, hwZA_ArmYOffset, hwZA_ArmZOffset])
		cube([hwZA_ArmWidth + 0.6, hwZA_ArmLength , hwZA_ArmWidth * 2 ]);
	
		translate([-hwZA_ArmSpacing /2 - hwZA_ArmWidth/2 - 0.3, hwZA_ArmYOffset, hwZA_ArmZOffset])
		cube([hwZA_ArmWidth + 0.6, hwZA_ArmLength, hwZA_ArmWidth * 2]);
		
		// carve out rods
		
		translate([hwZA_RodXSpacing / 2, -hwZA_RodYSpacing /2, -hwZA_RodLength / 2])
		cylinder(h = hwZA_RodLength, d = hwZA_RodDiameter + 2);

		translate([-hwZA_RodXSpacing / 2, -hwZA_RodYSpacing /2, -hwZA_RodLength / 2])
		cylinder(h = hwZA_RodLength, d = hwZA_RodDiameter +2);

		translate([hwZA_RodXSpacing / 2, hwZA_RodYSpacing /2, -hwZA_RodLength / 2])
		cylinder(h = hwZA_RodLength, d = hwZA_RodDiameter +2);

		translate([-hwZA_RodXSpacing / 2, hwZA_RodYSpacing /2, -hwZA_RodLength / 2])
		cylinder(h = hwZA_RodLength, d = hwZA_RodDiameter +2);
		
		// center right arm bolt
		translate([28, 0, hwZA_ArmWidth /2])
		rotate([0,90,0])
			Carve_hw_Bolt_AllenHead(hwM4_Bolt_AllenHeadSize, 40, 10);
			
		translate([28, 35, hwZA_ArmWidth /2])
		rotate([0,90,0])
			Carve_hw_Bolt_AllenHead(hwM4_Bolt_AllenHeadSize, 40, 10);
			
		translate([28, -35, hwZA_ArmWidth /2])
		rotate([0,90,0])
			Carve_hw_Bolt_AllenHead(hwM4_Bolt_AllenHeadSize, 40, 10);
			
			
		translate([32, 0, hwZA_ArmWidth /2])
			rotate([0,90,0])
				cylinder(h = 5, d1 = 8.6, d2 = 8.6, $fn = 6);
				
		translate([32, 35, hwZA_ArmWidth /2])
			rotate([0,90,0])
				cylinder(h = 5, d1 = 8.6, d2 = 8.6, $fn = 6);
				
		translate([32, -35, hwZA_ArmWidth /2])
			rotate([0,90,0])
				cylinder(h = 5, d1 = 8.6, d2 = 8.6, $fn = 6);
			
		// center left arm bolt
		translate([-28, 0, hwZA_ArmWidth /2])
		rotate([0,-90,0])
			Carve_hw_Bolt_AllenHead(hwM4_Bolt_AllenHeadSize, 40, 10);
			
		translate([-28, 35, hwZA_ArmWidth /2])
		rotate([0,-90,0])
			Carve_hw_Bolt_AllenHead(hwM4_Bolt_AllenHeadSize, 40, 10);
			
		translate([-28, -35, hwZA_ArmWidth /2])
		rotate([0,-90,0])
			Carve_hw_Bolt_AllenHead(hwM4_Bolt_AllenHeadSize, 40, 10);
			
			
		translate([-37, 0, hwZA_ArmWidth /2])
			rotate([0,90,0])
				cylinder(h = 5, d1 = 8.6, d2 = 8.6, $fn = 6);
				
		translate([-37, 35, hwZA_ArmWidth /2])
			rotate([0,90,0])
				cylinder(h = 5, d1 = 8.6, d2 = 8.6, $fn = 6);
				
		translate([-37, -35, hwZA_ArmWidth /2])
			rotate([0,90,0])
				cylinder(h = 5, d1 = 8.6, d2 = 8.6, $fn = 6);	
		
		rotate([0,0,120])
		translate([0,9.5, 12])
		rotate([0, 180, 0])
		Carve_hw_Bolt_AllenHead(hwM3_Bolt_AllenHeadSize, 20, 10);
		
		rotate([0,0,-120])
		translate([0,9.5, 12])
		rotate([0, 180, 0])
		Carve_hw_Bolt_AllenHead(hwM3_Bolt_AllenHeadSize, 20, 10);
		
		translate([0,9.5, 12])
		rotate([0, 180, 0])
		Carve_hw_Bolt_AllenHead(hwM3_Bolt_AllenHeadSize, 20, 10);
		
		translate([0,9.5, 6.5])
		rotate([0,0,0])
				cylinder(h = 8, d1 = 6.6, d2 = 6.6, $fn = 6);
		
		rotate([0,0,120])		
		translate([0,9.5, 6.5])
		rotate([0,0,0])
				cylinder(h = 8, d1 = 6.6, d2 = 6.6, $fn = 6);
				
		rotate([0,0,-120])		
		translate([0,9.5, 6.5])
		rotate([0,0,0])
				cylinder(h = 8, d1 = 6.6, d2 = 6.6, $fn = 6);
				

		_ZAxis_BearingMounts();
		
		mirror([1,0,0])
		_ZAxis_BearingMounts();
		
		
		translate([hwZA_ArmSpacing /2, 17.5 , -19.1])
		Carve_hw_Bolt_AllenHead(hwM4_Bolt_AllenHeadSize, 40, 10);
		
		translate([hwZA_ArmSpacing /2, -17.5 , -19.1])
		Carve_hw_Bolt_AllenHead(hwM4_Bolt_AllenHeadSize, 40, 10);
		
		translate([-hwZA_ArmSpacing /2, 17.5 , -19.1])
		Carve_hw_Bolt_AllenHead(hwM4_Bolt_AllenHeadSize, 40, 10);
		
		translate([-hwZA_ArmSpacing /2, -17.5 , -19.1])
		Carve_hw_Bolt_AllenHead(hwM4_Bolt_AllenHeadSize, 40, 10);
	}
	

}

module _ZAxis_BearingMounts() {
		// M3 bolts to attach bearings - center
	
		translate([59, 0, hwZA_ArmWidth + 6])
		rotate([0,90,0])
			Carve_hw_Bolt_AllenHead(hwM3_Bolt_AllenHeadSize, 20, 10);
					
		translate([56,0, 0])
		rotate([0,90,0])
				cylinder(h = 12, d1 = 6.6, d2 = 6.6, $fn = 6);
				
		translate([56,0, hwZA_ArmWidth + 6])
		rotate([0,90,0])
				cylinder(h = 12, d1 = 6.6, d2 = 6.6, $fn = 6);
			
		translate([59, 0, 0])
		rotate([0,90,0])
			Carve_hw_Bolt_AllenHead(hwM3_Bolt_AllenHeadSize, 20, 10);
			
		// M3 bolts to attach bearings - front
	
		translate([59, 35, hwZA_ArmWidth + 6])
		rotate([0,90,0])
			Carve_hw_Bolt_AllenHead(hwM3_Bolt_AllenHeadSize, 20, 10);
					
		translate([56,35, 0])
		rotate([0,90,0])
				cylinder(h = 12, d1 = 6.6, d2 = 6.6, $fn = 6);
				
		translate([56,35, hwZA_ArmWidth + 6])
		rotate([0,90,0])
				cylinder(h = 12, d1 = 6.6, d2 = 6.6, $fn = 6);
			
		translate([59, 35, 0])
		rotate([0,90,0])
			Carve_hw_Bolt_AllenHead(hwM3_Bolt_AllenHeadSize, 20, 10);
			
			
		// M3 bolts to attach bearings - front
	
		translate([59, -35, hwZA_ArmWidth + 6])
		rotate([0,90,0])
			Carve_hw_Bolt_AllenHead(hwM3_Bolt_AllenHeadSize, 20, 10);
					
		translate([56,-35, 0])
		rotate([0,90,0])
				cylinder(h = 12, d1 = 6.6, d2 = 6.6, $fn = 6);
				
		translate([56,-35, hwZA_ArmWidth + 6])
		rotate([0,90,0])
				cylinder(h = 12, d1 = 6.6, d2 = 6.6, $fn = 6);
			
		translate([59, -35, 0])
		rotate([0,90,0])
			Carve_hw_Bolt_AllenHead(hwM3_Bolt_AllenHeadSize, 20, 10);
}

module _ZAxisArmTest() {
	_partThickness = 8;
	_baseThickness = 4;
	
	hull () {
		translate([0,0,-_baseThickness])
			cylinder(h = 10, d = hwZA_BushingLipDiameter + 4);
		translate([0,0,-_baseThickness])
			cylinder(h = hwZA_BushingHeight- hwZA_BushingLipHeight, d = hwZA_BushingDiameter + 2);
	}
	
	hull() {
	translate([hwZA_ArmSpacing/2 - hwZA_ArmWidth/2,hwZA_ArmYOffset,-_baseThickness])
		cylinder(h = _baseThickness + hwZA_ArmWidth, d = _partThickness);
	
	translate([hwZA_ArmSpacing/2 - hwZA_ArmWidth/2,-hwZA_ArmYOffset,-_baseThickness])
		cylinder(h = _baseThickness + hwZA_ArmWidth, d = _partThickness);
		
	translate([hwZA_ArmSpacing/2 - hwZA_ArmWidth/2 +2, 0, hwZA_ArmWidth /6])
		cylinder(h = hwZA_ArmWidth / 1.5, d = _partThickness *2);
	//}
	
	//hull() {
	translate([hwZA_ArmSpacing/2 - hwZA_ArmWidth/2,hwZA_ArmYOffset,-_baseThickness])
		cylinder(h = _baseThickness + hwZA_ArmWidth, d = _partThickness);
	
	translate([hwZA_ArmSpacing/2 - hwZA_ArmWidth/2,-hwZA_ArmYOffset,-_baseThickness])
		cylinder(h = _baseThickness + hwZA_ArmWidth, d = _partThickness);
		
	translate([hwZA_ArmSpacing/2 - hwZA_ArmWidth/2 + 2,35, hwZA_ArmWidth /6])
		cylinder(h = hwZA_ArmWidth /1.5, d = _partThickness *2);
	//}
	
	//hull() {
	translate([hwZA_ArmSpacing/2 - hwZA_ArmWidth/2,hwZA_ArmYOffset,-_baseThickness])
		cylinder(h = _baseThickness + hwZA_ArmWidth, d = _partThickness);
	
	translate([hwZA_ArmSpacing/2 - hwZA_ArmWidth/2,-hwZA_ArmYOffset,-_baseThickness])
		cylinder(h = _baseThickness + hwZA_ArmWidth, d = _partThickness);
		
	translate([hwZA_ArmSpacing/2 - hwZA_ArmWidth/2 + 2,-35, hwZA_ArmWidth /6])
		cylinder(h = hwZA_ArmWidth /1.5, d = _partThickness *2);
	}

	// box around arm
	hull() {
		translate([hwZA_ArmSpacing/2 + hwZA_ArmWidth/2,hwZA_ArmYOffset,-_baseThickness])
		cylinder(h = _baseThickness + hwZA_ArmWidth, d = _partThickness);
	
		translate([hwZA_ArmSpacing/2 - hwZA_ArmWidth/2,hwZA_ArmYOffset,-_baseThickness])
		cylinder(h = _baseThickness + hwZA_ArmWidth, d = _partThickness);
		
		translate([hwZA_ArmSpacing/2 + hwZA_ArmWidth/2,-hwZA_ArmYOffset,-_baseThickness])
		cylinder(h = _baseThickness + hwZA_ArmWidth, d = _partThickness);
	
		translate([hwZA_ArmSpacing/2 - hwZA_ArmWidth/2,-hwZA_ArmYOffset,-_baseThickness])
		cylinder(h = _baseThickness + hwZA_ArmWidth, d = _partThickness);
	}
	
	// rear support
	hull() {
		translate([hwZA_ArmSpacing/2 + hwZA_ArmWidth/2,hwZA_ArmYOffset + 2,0])
		cylinder(h = _baseThickness, d = _partThickness);
	
		translate([hwZA_ArmSpacing/2 + hwZA_ArmWidth/2,hwZA_ArmYOffset,-_baseThickness])
		cylinder(h = _baseThickness + hwZA_ArmWidth, d = _partThickness);
		
		translate([0,-4,-_baseThickness])
		cylinder(h = hwZA_BushingHeight - hwZA_BushingLipHeight- _baseThickness, d = hwZA_BushingDiameter + 2);
	}
	
	// front support
	hull() {
		translate([hwZA_ArmSpacing/2 + hwZA_ArmWidth/2,- hwZA_ArmYOffset - 2,0])
		cylinder(h = _baseThickness, d = _partThickness);
	
		translate([hwZA_ArmSpacing/2 + hwZA_ArmWidth/2,-hwZA_ArmYOffset,-_baseThickness])
		cylinder(h = _baseThickness + hwZA_ArmWidth, d = _partThickness);
		
		translate([0,0,-_baseThickness])
		cylinder(h = hwZA_BushingHeight - hwZA_BushingLipHeight - _baseThickness, d = hwZA_BushingDiameter);
	}
	
	// bearing holder
	/*difference() {
		hull() {
		
		// match up with cover piece - rear
		translate([hwZA_RodXSpacing/2 , -hwZA_RodYSpacing /2 - 12.5, -4])
		cylinder(h = hwZA_BearingLength + 8 , d = 16);
		
		translate([hwZA_RodXSpacing/2 , -hwZA_RodYSpacing /2 - 12.5, -2])
		cylinder(h = hwZA_BearingLength + 4 , d = 18);
		
		// match up with cover piece - front
		translate([hwZA_RodXSpacing/2 , hwZA_RodYSpacing /2 + 12.5, -4])
		cylinder(h = hwZA_BearingLength + 8 , d = 16);
		
		translate([hwZA_RodXSpacing/2 , hwZA_RodYSpacing /2 + 12.5, -2])
		cylinder(h = hwZA_BearingLength + 4 , d = 18);
		
		
		// rear of part
		translate([hwZA_ArmSpacing/2 + hwZA_ArmWidth/2,hwZA_ArmYOffset,-_baseThickness])
			cylinder(h = _baseThickness + hwZA_ArmWidth, d = _partThickness);
	
		// front of part
		translate([hwZA_ArmSpacing/2 + hwZA_ArmWidth/2,-hwZA_ArmYOffset,-_baseThickness])
			cylinder(h = _baseThickness + hwZA_ArmWidth, d = _partThickness);
	
		translate([hwZA_RodXSpacing / 2, -hwZA_RodYSpacing /2, -_baseThickness])
		cylinder(h = hwZA_ArmWidth + _baseThickness, d = hwZA_BearingDiameter + _partThickness * 2);
	
		translate([hwZA_RodXSpacing / 2, hwZA_RodYSpacing /2, -_baseThickness])
		cylinder(h = hwZA_ArmWidth + _baseThickness, d = hwZA_BearingDiameter + _partThickness * 2);
		
		translate([hwZA_RodXSpacing / 2, -hwZA_RodYSpacing /2, -_baseThickness])
		cylinder(h = hwZA_BearingLength + _baseThickness, d = hwZA_BearingDiameter + _partThickness * 2);
	
		translate([hwZA_RodXSpacing / 2, hwZA_RodYSpacing /2, -_baseThickness])
		cylinder(h = hwZA_BearingLength + _baseThickness, d = hwZA_BearingDiameter + _partThickness * 2);
		}
		
		translate([hwZA_RodXSpacing / 2, -50, - _baseThickness -1])
		cube([50, 100, _baseThickness + hwZA_ArmWidth + 20]);
	}*/
}


module _Base_BearingCapHalf() {
	
	hull() {
		// tapered larger section around bearings
		translate([0, -hwZA_RodYSpacing /2, 2.5])
			cylinder(h = hwZA_BearingLength +3 , d = hwZA_BearingDiameter + 6);
		
		translate([0, -hwZA_RodYSpacing /2, 0])
			cylinder(h = hwZA_BearingLength + 8 , d = hwZA_BearingDiameter + 4);
		
		// tapered smaller section at ends
		translate([0, -hwZA_RodYSpacing /2 - 12.5, 0])
			cylinder(h = hwZA_BearingLength + 8 , d = 16);
			
		translate([-4, -hwZA_RodYSpacing /2 - 12.5, 0])
			cylinder(h = hwZA_BearingLength + 7.5 , d = 19);
		
		translate([0, -hwZA_RodYSpacing /2 - 12.5, 2])
			cylinder(h = hwZA_BearingLength + 4 , d = 17);
			
		translate([-4, -hwZA_RodYSpacing /2 - 12.5, 2])
			cylinder(h = hwZA_BearingLength + 4 , d = 20);
		
		// cross joining bit to make it solid - matches above
		translate([0, hwZA_RodYSpacing /2 + 12.5, 0])
			cylinder(h = hwZA_BearingLength + 8 , d = 16);
	}
	
}

module _BearingCarveOut() {
	cylinder(h = hwZA_BearingLength +1, d = hwZA_BearingDiameter + 0.6);
	
	hull() {
		cylinder(h = hwZA_BearingLength +1, d = hwZA_BearingDiameter + 0.4);
		cylinder(h = hwZA_BearingLength + 4.75, d = hwZA_BearingDiameter + 0.6 - 4);
	}
	
	cylinder(h = hwZA_BearingLength + 6, d = hwZA_BearingDiameter + 0.6 - 4);
}



module _ZAxis_Center() {
	/*translate([-hwZA_RodXSpacing/2, hwZA_ArmYOffset /2, -2])
	cube([hwZA_RodXSpacing, hwZA_RodYSpacing, 2]);*/
	
	hull() {
		translate([-hwZA_RodXSpacing/2 + 5, hwZA_RodYSpacing/ 2 + hwZA_BearingDiameter /2 + 5, -2])
		cylinder(h= hwZA_BearingLength + 2, d = 10);
	
		translate([-hwZA_RodXSpacing/2 + 5, -hwZA_RodYSpacing/ 2 - hwZA_BearingDiameter /2 - 5, -2])
		cylinder(h= hwZA_BearingLength + 2, d = 10);
		
		translate([-hwZA_ArmSpacing/2 - hwZA_ArmWidth + 5, hwZA_ArmYOffset +3, -2])
		cylinder(h= hwZA_ArmWidth + 2, d = 10);
		
		translate([-hwZA_ArmSpacing/2 - hwZA_ArmWidth + 5, -hwZA_ArmYOffset -3, -2])
		cylinder(h= hwZA_ArmWidth + 2, d = 10);
	}
	
	hull() {
		translate([-hwZA_ArmSpacing/2 - hwZA_ArmWidth + 5, hwZA_ArmYOffset +3, -2])
		cylinder(h= hwZA_ArmWidth + 2, d = 10);
		
		translate([-hwZA_ArmSpacing/2 - hwZA_ArmWidth + 5, -hwZA_ArmYOffset -3, -2])
		cylinder(h= hwZA_ArmWidth + 2, d = 10);
		
		translate([-hwZA_ArmSpacing/2 + 10, hwZA_ArmYOffset +3, -2])
		cylinder(h= hwZA_ArmWidth + 2, d = 10);
		
		translate([-hwZA_ArmSpacing/2 + 10, -hwZA_ArmYOffset -3, -2])
		cylinder(h= hwZA_ArmWidth + 2, d = 10);
	}
	
	hull() {
		translate([-hwZA_RodXSpacing/2 + 5, hwZA_RodYSpacing/ 2 + hwZA_BearingDiameter /2 + 5, hwZA_BearingLength])
		cylinder(h= hwZA_BearingLength + 2, d = 10);
	
		translate([-hwZA_RodXSpacing/2 + 5, 0, hwZA_BearingLength])
		cylinder(h= hwZA_BearingLength + 2, d = 10);
		
		translate([-hwZA_ArmSpacing/2 - hwZA_ArmWidth + 5, 0, hwZA_BearingLength - 12])
		cylinder(h= hwZA_ArmWidth + 2 + 12, d = 10);
		
		translate([-hwZA_ArmSpacing/2 - hwZA_ArmWidth + 5, -hwZA_ArmYOffset -3, hwZA_BearingLength - 12])
		cylinder(h= hwZA_ArmWidth + 2 + 12, d = 10);
	}
	
	
}
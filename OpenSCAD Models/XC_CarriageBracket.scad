// *****************************************************************************
// ( )/ )(_  _)(_  _)___(  _ \(  _  )(  _ \(  _  )(_  _)(_  _)/ __)/ __)
//  )  (  _)(_   )( (___))   / )(_)(  ) _ < )(_)(   )(   _)(_( (__ \__ \
// (_)\_)(____) (__)    (_)\_)(_____)(____/(_____) (__) (____)\___)(___/
// *****************************************************************************
// Written by bcantin@kitchissippi-robotics.com
// Copyright (c) 2015 Kitchissippi Robotics
// -----------------------------------------------------------------------------
// XC_CarriageBracket.scad
// Part No. XB-CB-ABS03 & XB-CB-ABS04
// Generates XC_CarriageBracket_Front.stl & XC_CarriageBracket_Rear.stl
// *****************************************************************************

// include <Dimensions.scad> - included from XC_Common.scad
include <XC_Common.scad>

// -----------------------------------------------------------------------------
// Default Usage:	
// Part_XC_CarriageBracket_Front();

// Determine if MultiPartMode is enabled - if not, render the part automatically
// and enable support material (if it is defined)

if (MultiPartMode == undef) {
	MultiPartMode = false;
	EnableSupport = true;
	
	Part_XC_CarriageBracket_Rear();
	
	/*translate([0,0, 26])
		Part_XC_CarriageBracket_Rear();*/
} else {
	EnableSupport = false;
}

// -----------------------------------------------------------------------------
// Just Draw the bolt bases
// -----------------------------------------------------------------------------

module _BracketBase(_baseDiameter = 12) {
	*difference() {
		union() {
			// top left assembly bolt mount base
			translate([-boltSpacing/2, 0, 2])
				cylinder(h = 4, d1 = _baseDiameter + 6, d2 = _baseDiameter + 5);
			translate([-boltSpacing/2, 0, 0])
				cylinder(h = 2, d1 = _baseDiameter + 5, d2 = _baseDiameter + 6);
				
			// bottom left assembly bolt mount base
			translate([-boltSpacing/2, -lowerBoltOffset, 2]) 
				cylinder(h = 4, d1 = _baseDiameter + 6, d2 = _baseDiameter + 5);
			translate([-boltSpacing/2, -lowerBoltOffset, 0]) 
				cylinder(h = 2, d1 = _baseDiameter + 5, d2 = _baseDiameter + 6);
	
			// top right assembly bolt mount base
			translate([boltSpacing/2, 0, 2]) 
				cylinder(h = 4, d1 = _baseDiameter + 6, d2 = _baseDiameter + 5);
			translate([boltSpacing/2, 0, 0]) 
				cylinder(h = 2, d1 = _baseDiameter + 5, d2 = _baseDiameter + 6);
	
			// bottom right assembly bolt mount base
			translate([boltSpacing/2, -lowerBoltOffset, 2]) 
				cylinder(h = 4, d1 = _baseDiameter + 6, d2 = _baseDiameter + 5);
			translate([boltSpacing/2, -lowerBoltOffset, 0]) 
				cylinder(h = 2, d1 = _baseDiameter + 5, d2 = _baseDiameter + 6);
		}
		
		hull() {
			// top left assembly bolt mount base
			translate([-boltSpacing/2, 0, 5])
				cylinder(h = 5, d = _baseDiameter + 1);
		
			// top right assembly bolt mount base
			translate([boltSpacing/2, 0, 5]) 
				cylinder(h = 5, d = _baseDiameter + 1);
			
			// bottom left assembly bolt mount base
			translate([-boltSpacing/2, -lowerBoltOffset, 5]) 
				cylinder(h = 5, d = _baseDiameter + 1);
			
			// bottom right assembly bolt mount base
			translate([boltSpacing/2, -lowerBoltOffset, 5]) 
				cylinder(h = 5, d = _baseDiameter + 1);
		}
		
		*hull() {
			// top left assembly bolt mount base
			translate([-boltSpacing/2, 0, 0])
				cylinder(h = 5, d = _baseDiameter);
		
			// top right assembly bolt mount base
			translate([boltSpacing/2, 0, 0]) 
				cylinder(h = 5, d = _baseDiameter);
			
			// bottom left assembly bolt mount base
			translate([-boltSpacing/2, -lowerBoltOffset, 0]) 
				cylinder(h = 5, d = _baseDiameter);
			
			// bottom right assembly bolt mount base
			translate([boltSpacing/2, -lowerBoltOffset, 0]) 
				cylinder(h = 5, d = _baseDiameter);
		}
		
	}

	// top left assembly bolt mount base
	translate([-boltSpacing/2, 0, 0])
		cylinder(h = 5, d1 = _baseDiameter + 1, d2 = _baseDiameter);
	
	// bottom left assembly bolt mount base
	translate([-boltSpacing/2, -lowerBoltOffset, 0]) 
		cylinder(h = 5, d = _baseDiameter);
	
	// top right assembly bolt mount base
	translate([boltSpacing/2, 0, 0]) 
		cylinder(h = 5, d1 = _baseDiameter + 1, d2 = _baseDiameter);
	
	// bottom right assembly bolt mount base
	translate([boltSpacing/2, -lowerBoltOffset, 0]) 
		cylinder(h = 5, d = _baseDiameter);
}

module _BracketSkeleton(_baseDiameter = 12) {
	*hull() {
		// top left assembly bolt mount base
		translate([-boltSpacing/2, -20, 0])
			_BoltBase(0, 4, BBStyle_Round);
			
		// bottom left assembly bolt mount base
		translate([-boltSpacing/2, -lowerBoltOffset + 2, 0]) 
			_BoltBase(0, 4, BBStyle_Round);
			
		// top right assembly bolt mount base
		translate([boltSpacing/2, -20, 0]) 
			_BoltBase(0, 4, BBStyle_Round);
			
		// bottom right assembly bolt mount base
		translate([boltSpacing/2, -lowerBoltOffset +2, 0]) 
			_BoltBase(0, 4, BBStyle_Round);
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
		// bottom left assembly bolt mount base
		translate([boltSpacing/2, -6, 0]) 
			_BoltBase(0.75, 4.5, BBStyle_Round);
			
		// bottom left assembly bolt mount base
		translate([-boltSpacing/2, -6, 0]) 
			_BoltBase(0.75, 4.5, BBStyle_Round);
		
	}
	
	*hull() {
		translate([8, -7, 0])
				_BoltBase(0, 2, BBStyle_Round);
				
		// bottom left assembly bolt mount base
		translate([boltSpacing/2, -lowerBoltOffset /2 - 3, 0]) 
			_BoltBase(0, 2, BBStyle_Round);
			
		translate([boltSpacing/2, -lowerBoltOffset, 0]) 
			_BoltBase(4, 2, BBStyle_Round);
	}
	
	
	*hull() {
		translate([-8, -7, 0])
				_BoltBase(0, 4.5, BBStyle_Round);
			
		// bottom left assembly bolt mount base
		translate([-boltSpacing/2, -lowerBoltOffset /2 - 3, 0]) 
			_BoltBase(0, 4.5, BBStyle_Round);
	}
	
	*hull() {
		translate([8, -7, 0])
				_BoltBase(0, 4.5, BBStyle_Round);
			
		// bottom left assembly bolt mount base
		translate([boltSpacing/2, -lowerBoltOffset /2 - 3, 0]) 
			_BoltBase(0, 4.5, BBStyle_Round);
	}
	
	hull() {
		translate([8, -6, 0])
			cylinder(h = 4.5, d = 8);
				
		translate([-8, -6, 0])
			cylinder(h = 4.5, d = 8);
				
		/*translate([10, -12, 0])
				_BoltBase(2.5, 2, BBStyle_Round);
		translate([-10, -12, 0])
				_BoltBase(2.5, 2, BBStyle_Round);*/
	}
	// right side vertical brace
	hull() {
	
		// top right assembly bolt mount base
		translate([boltSpacing/2, 0, 0]) 
			_BoltBase(4, 4.5, BBStyle_Round);
			
		// bottom right assembly bolt mount base
		translate([boltSpacing/2, -lowerBoltOffset, 0]) 
			_BoltBase(4, 4.5, BBStyle_Round);
	}
	
	// left side vertical brace
	hull() {
	
		// top right assembly bolt mount base
		translate([-boltSpacing/2, 0, 0]) 
			_BoltBase(4, 4.5, BBStyle_Round);
			
		// bottom right assembly bolt mount base
		translate([-boltSpacing/2, -lowerBoltOffset, 0]) 
			_BoltBase(4, 4.5, BBStyle_Round);
	}
	
	// bottom side vertical brace
	hull() {
	
		// bottom right assembly bolt mount base
		translate([boltSpacing/2, -lowerBoltOffset - 1, 0]) 
			_BoltBase(2, 4.5, BBStyle_Round);
			
		// bottom right assembly bolt mount base
		translate([-boltSpacing/2, -lowerBoltOffset - 1, 0]) 
			_BoltBase(2, 4.5, BBStyle_Round);
	}
}

module _BracketSwitchMount(_baseDiameter = 10) {
	// switch holder lower screw base

	
	hull() {
	
		// make a rectangular-ish space
		// lower
		translate([switchXOffset + 3, - rpXC_BeltMount_BoltOffset + switchYOffset - hwMicroSwitch_HoleSpacing /2 - 3, 0])
			_BoltBase(1, 5 - 0.5, BBStyle_Round);
		translate([switchXOffset - 3, - rpXC_BeltMount_BoltOffset + switchYOffset - hwMicroSwitch_HoleSpacing /2 - 3, 0])
			_BoltBase(1, 5 - 0.5, BBStyle_Round);
		// upper
		translate([switchXOffset + 3, - rpXC_BeltMount_BoltOffset + switchYOffset + hwMicroSwitch_HoleSpacing /2 + 3, 0])
			_BoltBase(1, 5 - 0.5, BBStyle_Round);
		translate([switchXOffset - 3, - rpXC_BeltMount_BoltOffset + switchYOffset + hwMicroSwitch_HoleSpacing /2 + 3, 0])
			_BoltBase(1, 5 - 0.5, BBStyle_Round);
	
		// switch holder lower screw base
		translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset - hwMicroSwitch_HoleSpacing /2, 0])
			_BoltBase(hwMicroSwitch_ScrewHeadDiameter - 0.5, 5, BBStyle_Round);
	
		// switch holder upper screw base
		translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset + hwMicroSwitch_HoleSpacing /2, 0])
			_BoltBase(hwMicroSwitch_ScrewHeadDiameter - 0.5, 5, BBStyle_Round);
	}
	
}

module _Bracket_BoltCarveouts() {
	_boltDiameter = 4.6;
	
	// top left assembly bolt mount base
	translate([-boltSpacing/2, 0, 0])
		cylinder(h = 6, d = _boltDiameter);
	
	// bottom left assembly bolt mount base
	translate([-boltSpacing/2, -lowerBoltOffset, 0]) 
		cylinder(h = 6, d = _boltDiameter);
	
	// top right assembly bolt mount base
	translate([boltSpacing/2, 0, 0]) 
		cylinder(h = 6, d = _boltDiameter);
	
	// bottom right assembly bolt mount base
	translate([boltSpacing/2, -lowerBoltOffset, 0]) 
		cylinder(h = 6, d = _boltDiameter);
		
	/*translate([boltSpacing/2, -lowerBoltOffset, 3]) 
		cylinder(h = 5, d = 9.5, $fn = 6);*/
		
	// switch screw carve out
			translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset - hwMicroSwitch_HoleSpacing /2, 0])
				cylinder(h=10, d= 3.2);
			translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset + hwMicroSwitch_HoleSpacing /2, 0])
				cylinder(h=10, d= 3.2);
				
				
// switch screw access carve out
			hull() {
				translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset - hwMicroSwitch_HoleSpacing /2, 2])
				cylinder(h=30, d= 1);
			
			
				translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset - hwMicroSwitch_HoleSpacing /2, 2])
				cylinder(h=5, d= 8.5);
			}
			
			hull() {
				translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset + hwMicroSwitch_HoleSpacing /2, 2])
				cylinder(h=30, d= 1);
			
			
				translate([switchXOffset, - rpXC_BeltMount_BoltOffset + switchYOffset + hwMicroSwitch_HoleSpacing /2, 2])
				cylinder(h=5, d= 8.5);
			}
}

module Part_XC_CarriageBracket_Front() {
		//_BracketBase(9);
		
}

module Part_XC_CarriageBracket_Rear() {
	difference() {
		union() {
			_BracketBase(9.75);
			_BracketSkeleton(2);
			_BracketSwitchMount(8);
		}
		
		_Bracket_BoltCarveouts();
		
		translate([-BlowerXOffset, -1, 0])
		_BlowerCarveout();
		
		// wiring channel
		hull() {
			translate([0,0,-1])
				sphere(d = 6);
				
			translate([3,-12,0])
				sphere(d = 4);
				
			translate([-3,-12,0])
				sphere(d = 4);
			}
		
		*translate([-22,-58.5,-10])
		cube([60,20, 60]);
		
		*translate([-26,-58.5,5])
		cube([60,20, 60]);
	}
}
// *****************************************************************************
// ( )/ )(_  _)(_  _)___(  _ \(  _  )(  _ \(  _  )(_  _)(_  _)/ __)/ __)
//  )  (  _)(_   )( (___))   / )(_)(  ) _ < )(_)(   )(   _)(_( (__ \__ \
// (_)\_)(____) (__)    (_)\_)(_____)(____/(_____) (__) (____)\___)(___/
// *****************************************************************************
// Written by bcantin@kitchissippi-robotics.com
// Copyright (c) 2015 Kitchissippi Robotics
// -----------------------------------------------------------------------------
// XC_BeltCover.scad
// Part No. XB-CB-ABS02
// Generates XC_BeltCover.stl
// *****************************************************************************

include <../Dimensions.scad>
include <XC_Common.scad>

// -----------------------------------------------------------------------------

// Default Usage:	
// Part_XC_BeltCover();

// Determine if MultiPartMode is enabled - if not, render the part automatically
// and enable support material (if it is defined)

if (MultiPartMode == undef) {
	MultiPartMode = false;
	EnableSupport = true;
	
	Part_XC_BeltCover();
} else {
	EnableSupport = false;
}

// -----------------------------------------------------------------------------
// Part Rendering
// -----------------------------------------------------------------------------

module Part_XC_BeltCover() {
	// some simple translation to align the part with origin point
	// TODO: Clean up metrics
	
	translate([-13,0,11])
	rotate([0,180,0]) {
		difference() {
			union() {
				// upper tab
				hull() {
					translate([-8, 8.6, 0])
						cylinder(h = 10, d = 1.0);
					translate([-18, 8.6, 0])
						cylinder(h = 10, d = 1.0);
			
					translate([-8, 11.25, 0])
						cylinder(h = 10, d = 1.0);
					translate([-18, 11.25, 0])
						cylinder(h = 10, d = 1.0);
			
			
					translate([-8, 9.0, 2])
						cylinder(h = 6, d = 1.6);
					translate([-18, 9.0, 2])
						cylinder(h = 6, d = 1.6);
			
					translate([-8, 11.25, 2])
						cylinder(h = 6, d = 1.6);
					translate([-18, 11.25, 2])
						cylinder(h = 6, d = 1.6);
				}
	
				// lower tab
				hull() {
					translate([-8, -8.6, 0])
						cylinder(h = 11, d = 1.0);
					translate([-18, -8.6, 0])
						cylinder(h = 11, d = 1.0);
			
					translate([-8, -11.25, 0])
						cylinder(h = 11, d = 1.0);
					translate([-18, -11.25, 0])
						cylinder(h = 11, d = 1.0);
			
			
					translate([-8, -9.0, 2])
						cylinder(h = 6, d = 1.6);
					translate([-18, -9.0, 2])
						cylinder(h = 6, d = 1.6);
			
					translate([-8, -11.25, 2])
						cylinder(h = 6, d = 1.6);
					translate([-18, -11.25, 2])
						cylinder(h = 6, d = 1.6);
				}
	
	
				// main cover	
				hull() {

			
					translate([-8, 11.25, 8])
						cylinder(h = 1, d = 1.6);
					translate([-18, 11.25, 8])
						cylinder(h = 1, d = 1.6);
			
			
					translate([-8, -11.25, 8])
						cylinder(h = 1, d = 1.6);
					translate([-18, -11.25, 8])
						cylinder(h = 1, d = 1.6);
			
					translate([-8, 11.25, 9])
						cylinder(h = 2, d = 1);
					translate([-18, 11.25, 9])
						cylinder(h = 2, d = 1);
			
			
					translate([-8, -11.25, 9])
						cylinder(h = 2, d = 1);
					translate([-18, -11.25, 9])
						cylinder(h = 2, d = 1);

				}
			}
		
			translate([-19,-2.2,6])
			cube([12,4.4,2]);
		
			translate([-19,-8.1,6.5])
			cube([12,6.1,2]);
		
			translate([-19,2.0,6.5])
			cube([12,6.1,2]);
			
			// bolt hole
			translate([-13, 0,0])
			cylinder(d = 4, h = 20);
		}
	
		// raised bit to press on belt upper
		hull() {
			translate([-17, -6.5, 9]) 
				sphere(h= 4);
			
			translate([-9, -6.5, 9]) 
				sphere(h= 4);
			
			translate([-17, -3.5, 9]) 
				sphere(h= 4);
			
			translate([-9, -3.5, 9]) 
				sphere(h= 4);
		}
	
		// raised bit to press on belt lower
		hull() {
			translate([-17, 6.5, 9.0]) 
				sphere(h= 4);
			
			translate([-9, 6.5, 9.0]) 
				sphere(h= 4);
			
			translate([-17, 3.5, 9.0]) 
				sphere(h= 4);
			
			translate([-9, 3.5, 9.0]) 
				sphere(h= 4);
		}
	}
}
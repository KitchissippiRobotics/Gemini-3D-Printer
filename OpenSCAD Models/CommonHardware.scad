// *****************************************************************************
// ( )/ )(_  _)(_  _)___(  _ \(  _  )(  _ \(  _  )(_  _)(_  _)/ __)/ __)
//  )  (  _)(_   )( (___))   / )(_)(  ) _ < )(_)(   )(   _)(_( (__ \__ \
// (_)\_)(____) (__)    (_)\_)(_____)(____/(_____) (__) (____)\___)(___/
// *****************************************************************************
// Written by bcantin@kitchissippi-robotics.com
// Copyright (c) 2015 Kitchissippi Robotics
// -----------------------------------------------------------------------------
// Common Hardware
// *****************************************************************************

include <GlobalSettings.scad>

// Metric Bolt Hardware

// Vector Style Sizing for Bolts: [HeadDiameter, HeadHeight, ShaftDiameter]
iBolt_HeadDiameter = 0;
iBolt_HeadHeight = 1;
iBolt_ShaftDiameter = 2;

// M3 Bolt
// -----------------------------------------------------------------------------

hwM3_Bolt_ShaftDiameter = 3;

// Allen Key style head
hwM3_Bolt_AllenHeadDiameter = 5.4;
hwM3_Bolt_AllenHeadHeight = 2.8;

 
hwM3_Bolt_AllenHeadSize = [5.4, 2.8, 3];	// [HeadDiameter, HeadHeight, ShaftDiameter]


// M4 Bolt
// -----------------------------------------------------------------------------

hwM4_Bolt_ShaftDiameter = 4;

// Allen Key style head
hwM4_Bolt_AllenHeadDiameter = 6.8;
hwM4_Bolt_AllenHeadHeight = 4.3;

hwM4_Bolt_AllenHeadSize = [6.8, 4.3, 4]; 	// [HeadDiameter, HeadHeight, ShaftDiameter]

// Hex Wrench style head
hwM4_Bolt_HexHeadDiameter = 7.8;	
hwM4_Bolt_HexHeadHeight = 2.8;




// *****************************************************************************
// Hardware Drawing For Reference
// *****************************************************************************




module Draw_hw_Bolt_AllenHead(_boltSize, _boltLength)
{
	if (gRender_Hardware == true) {
		// bolt shaft
		color([0.5, 0.5, 0.5])
		cylinder(h = _boltLength, d = _boltSize[iBolt_ShaftDiameter], $fn=gcFacetSmall, center = false);
		
		color([0.5, 0.5, 0.5])
	
		// bolt head - Allen Key type
		difference() {
			translate([0,0,_boltLength])
				cylinder(h = _boltSize[iBolt_HeadHeight], d = _boltSize[iBolt_HeadDiameter], $fn=gcFacetSmall, center = false);
			translate([0,0,_boltLength  + 1])
				cylinder(h = _boltSize[iBolt_HeadHeight], d = _boltSize[iBolt_HeadDiameter] / 2, $fn=6, center = false);
		}
	}
	
}

module Carve_hw_Bolt_AllenHead(_boltSize, _boltLength, _headClearance = 0) {
	// hole for bolt shaft
	cylinder(h = _boltLength, d = _boltSize[iBolt_ShaftDiameter] + gcMachineOffset, $fn=gcFacetSmall, center = false);
	translate([0,0,_boltLength])
		cylinder(h = _boltSize[iBolt_HeadHeight] + _headClearance, d = _boltSize[iBolt_HeadDiameter] + gcMachineOffset, $fn=gcFacetSmall, center = false);
}


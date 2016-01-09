// *****************************************************************************
// ( )/ )(_  _)(_  _)___(  _ \(  _  )(  _ \(  _  )(_  _)(_  _)/ __)/ __)
//  )  (  _)(_   )( (___))   / )(_)(  ) _ < )(_)(   )(   _)(_( (__ \__ \
// (_)\_)(____) (__)    (_)\_)(_____)(____/(_____) (__) (____)\___)(___/
// *****************************************************************************
// Written by bcantin@kitchissippi-robotics.com
// Copyright (c) 2015 Kitchissippi Robotics
// -----------------------------------------------------------------------------
// GlobalSettings.scad
//
// This file contains settings that affect how the functions will generate parts 
// in both CommonHardware.scad as well as other parts within the project.
// *****************************************************************************


// Global Settings - Edit These
// =============================================================================

gRender_Resolution = 1;		// resolution of curves 		- default = 1
gRender_Clearance = 0.2;	// mm of clearance around bolts - default = 0.2

gNozzle_Size = 0.5;			// nozzle size the parts will be printed on



// Global Calculations - Do NOT Edit These
// =============================================================================
// These variables are calculated based on the global settings before them.
// The math is being tested as well as possible to get the compensation values to 
// be correct for a reasonably well tuned home 3D printer.
// It is not recommended for novice users to modify these formulas. 
// Beware, there be dragons.
// -----------------------------------------------------------------------------

// Offset of dimensions for creating the plastic printable parts - this allows 
// for direct metric values within the design and automatic material compensation.
// This formula may be expanded upon and made more elaborate
// if necessary.
// Initial design uses 60% of the nozzle size.

gcMachineOffset = gNozzle_Size * 0.75;	

// Calculate the number of facets per curve for small, medium and large curves.

gcFacetSmall = 16 * gRender_Resolution;
gcFacetMedium = 32 * gRender_Resolution;
gcFacetLarge = 64 * gRender_Resolution;

$fn = gcFacetMedium;	// default?
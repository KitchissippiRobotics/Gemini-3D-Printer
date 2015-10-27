// *****************************************************************************
// ( )/ )(_  _)(_  _)___(  _ \(  _  )(  _ \(  _  )(_  _)(_  _)/ __)/ __)
//  )  (  _)(_   )( (___))   / )(_)(  ) _ < )(_)(   )(   _)(_( (__ \__ \
// (_)\_)(____) (__)    (_)\_)(_____)(____/(_____) (__) (____)\___)(___/
// *****************************************************************************
// Written by bcantin@kitchissippi-robotics.com
// Copyright (c) 2015 Kitchissippi Robotics
// -----------------------------------------------------------------------------
// Gemini 3D Printer - Dimensions
// *****************************************************************************


// =============================================================================
// Global Settings - Edit These
// =============================================================================

gRender_Hardware = false;	// render the hardware within the OpenSCAD model
gRender_Resolution = 1;		// resolution of curves - 1 is default


gNozzle_Size = 0.4;			// nozzle size the parts will be printed on


// =============================================================================
// Global Calculations - Do NOT Edit These
// =============================================================================

// Offset of dimensions for creating the plastic printable parts - this allows 
// for direct metric values within the design and automatic material compensation.
// This formula may be expanded upon and made more elaborate
// if necessary.
// Initial design uses 60% of the nozzle size.

gcMachineOffset = gNozzle_Size * 0.60;	

// Calculate the number of facets per curve for small, medium and large curves.

gcFacetSmall = 16 * gRender_Resolution;
gcFacetMedium = 32 * gRender_Resolution;
gcFacetLarge = 64 * gRender_Resolution;
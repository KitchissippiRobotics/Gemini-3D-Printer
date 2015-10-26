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

// Include common assembly hardware dimensions
include <CommonHardware.scad>

// *****************************************************************************
// Suffix Concepts - In Development
// baseCOMPONENT_Part_Description = value in millimetres;

// Base Suffix:
// -----------------------------------------------------------------------------
// hw : Hardware - pieces that are not printable
// rp : Reproducible Part - pieces that are 3D printable

// Hardware Component Suffix:
// -----------------------------------------------------------------------------
// LR : Linear Rail
// M3 : M3 assembly hardware (see CommonHardware.scad)
// M4 : M4 assembly hardware (see CommonHardware.scad)

// Assembly Components
// -----------------------------------------------------------------------------
// XC : X-Carriage
// YC : Y-Carriage
// HA : Hotend-Assembly
// CM : CoreXY Mechanism

// *****************************************************************************


// HiWin Style Linear Rail Dimensions [LR]
// =============================================================================

// Linear Rail Diagram - Top View
//		
//		   Length
//		*************						W
// 	----* 	o	o	*----------------		i
//		*			*	( )		( )			d
//  ----* 	o	o	*----------------		t
//		*************						h
//

// Related Carriage Bolt Dimensions - This is the interface for attaching things
// to the linear slide on the HiWin style rail system

hwLR_Carriage_BoltWidth = 10.0			// see above reference diagram
hwLR_Carriage_BoltLength = 15.0			// see above reference diagram
hwLR_Carriage_BoltDepth = 3.5			// depth the bolt screws within the carriage
hwLR_Carriage_BoltDiameter = hwM3_Bolt_ShaftDiameter;

hwLR_Guide_BoltSpacing = 20;			// spacing between guide rail mounting holes
hwLR_Guide_BoltDiameter = hwM3_Bolt_ShaftDiameter;



// X-Carriage and Hotend-Assembly Related Dimensions
// =============================================================================

// The belt mounting portion of the X-Carriage
// Spacing between the two bolts and vertical offset relative to the top face of the hwLR_Carriage
// These measurements are taken from the Rv2 SketchUp design document

rpXC_BeltMount_BoltSpacing = 38.3;		// as measured Rv2
rpXC_BeltMount_BoltOffset  = 10.1;		// as measured Rv2

// Global Constants
// =============================================================================
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

hwLR_Carriage_BoltWidth = 10.0;			// see above reference diagram
hwLR_Carriage_BoltLength = 15.0;			// see above reference diagram
hwLR_Carriage_BoltDepth = 3.5;			// depth the bolt screws within the carriage
hwLR_Carriage_BoltDiameter = hwM3_Bolt_ShaftDiameter;

hwLR_Guide_BoltSpacing = 20;			// spacing between guide rail mounting holes
hwLR_Guide_BoltDiameter = hwM3_Bolt_ShaftDiameter;



// X-Carriage and Hotend-Assembly Related Dimensions
// =============================================================================

// The belt mounting portion of the X-Carriage
// Spacing between the two bolts and vertical offset relative to the top face of the hwLR_Carriage
// These measurements are taken from the Rv2 SketchUp design document

// Belt Clamp Bolts

rpXC_BeltMount_BoltSpacing = 38.3;		// as measured Rv2
rpXC_BeltMount_BoltOffset  = 10.1;		// as measured Rv2
rpXC_BeltMount_BoltDepth = -11.2;
rpXC_BeltMount_BoltSize = hwM3_Bolt_AllenHeadSize;
rpXC_BeltMount_BoltLength = 10;

rpXC_BeltMount_BoltHolderDiameter = 13; 	// Rv2

rpXC_BeltMount_BaseThickness = 4;			// Rv2
rpXC_BeltMount_BaseWidth = 20.2;			// Rv2
// rpXC_BeltMount_BaseLength = 30; 			// Rv2
rpXC_BeltMount_BaseLength = 39.0; 			// new
rpXC_BeltMount_BaseOffset = 17.2;			// Rv2

rpXC_BeltMount_ChannelEdgeHeight = 6;		// Rv2
rpXC_BeltMount_ChannelEdgeWidth = 2;		// Rv2
rpXC_BeltMount_ChannelEdgeLength = rpXC_BeltMount_BaseLength;

rpXC_BeltMount_ChannelCenterHeight = 8;		// Rv2
rpXC_BeltMount_ChannelCenterWidth = 4.2;	// Rv2
rpXC_BeltMount_ChannelCenterLength = 30;	// Rv2

rpXC_BeltMount_ClampBoltSpacing = 16;		// Rv2
rpXC_BeltMount_ClampBoltDepth = -rpXC_BeltMount_BaseOffset;
rpXC_BeltMount_ClampBoltOffset = rpXC_BeltMount_BoltOffset; // Rv2
rpXC_BeltMount_ClampBoltLength = 10;		// Rv2
rpXC_BeltMount_ClampBoltSize = hwM3_Bolt_AllenHeadSize;

// Carriage Mounting Bolts

rpXC_CarriageMount_BoltLength = 10;		// M3x10 mounting bolts
rpXC_CarriageMount_BoltSize = hwM3_Bolt_AllenHeadSize;

// Carriage Mounting Base

rpXC_CarriageMount_BaseHeight = 9.5;		// Rv2
rpXC_CarriageMount_BaseLength = 39.0;		// Rv2
rpXC_CarriageMount_BaseWidth = 20.8;		// Rv2
rpXC_CarriageMount_BaseOffset = 17.2;

rpXC_CarriageMount_BaseBevelDepth = 3;
rpXC_CarriageMount_BaseBevelHeight = 3;


// Global Constants
// =============================================================================
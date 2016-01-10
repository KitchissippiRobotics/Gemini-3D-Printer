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

hwLR_Carriage_BoltWidth = 15.0;			// see above reference diagram
hwLR_Carriage_BoltLength = 10.0;			// see above reference diagram
hwLR_Carriage_BoltDepth = 3.5;			// depth the bolt screws within the carriage
hwLR_Carriage_BoltDiameter = hwM3_Bolt_ShaftDiameter;

hwLR_Guide_BoltSpacing = 20;			// spacing between guide rail mounting holes
hwLR_Guide_BoltDiameter = hwM3_Bolt_ShaftDiameter;



// X-Carriage and Hotend-Assembly Related Dimensions
// =============================================================================

// The belt mounting portion of the X-Carriage
// Spacing between the two bolts and vertical offset relative to the top face of the hwLR_Carriage
// These measurements are taken from the Rv2 SketchUp design document

// XC_CarriageBase ~~~ Part No. XB-CB-ABS01
// -----------------------------------------------------------------------------

// Carriage Mounting Bolts

rpXC_CarriageMount_BoltLength = 10;		// M3x10 mounting bolts
rpXC_CarriageMount_BoltSize = hwM3_Bolt_AllenHeadSize;

// Carriage Mounting Base

rpXC_CarriageMount_BaseHeight = 9.5;		// Rv2
rpXC_CarriageMount_BaseLength = 30;			// Rv2 = 39.0
rpXC_CarriageMount_BaseWidth = 22;		// Rv2 = 28.5
rpXC_CarriageMount_BaseOffset = 17.2;

rpXC_CarriageMount_BaseSpacing = 1;		// extra width for HA attachement to clear the LR

// Bevel design on mounting base

rpXC_CarriageMount_BaseBevelDepth = 3;
rpXC_CarriageMount_BaseBevelHeight = 3;

rpXC_CarriageMount_BoltHolderDiameter = 12;

// Measurement of vertical clearance required for the X-Carriage to travel 
// safely along the Y axis.
// This measurement is taken from the top face of the HiWin carriage to a few mm
// below the M3 bolt protruding from the bottom of the Y axis brace.

rpXC_CarriageMount_LowerClearance = 18;

// The lower mount point on the X-Carriage must clear the bolt tip described above

rpXC_CarriageMount_LowerPointSpacing = rpXC_CarriageMount_LowerClearance + rpXC_CarriageMount_BoltHolderDiameter / 2;


// XC_BeltClamp ~~~ Part No. XB-CB-ABS02
// -----------------------------------------------------------------------------

// Experimental: BeltClamp matches in size and shape to cover part?

rpXC_BeltMount_CoverOffset = 0;	// 3mm thick cover?

// Bolts for attaching XC_BeltClamp to XC_CarriageBase

rpXC_BeltMount_BoltSpacing = 52;		// Rv2 = 38.3
rpXC_BeltMount_BoltOffset  = 10.1;		// Rv2 = 10.1
rpXC_BeltMount_BoltDepth = 38;
rpXC_BeltMount_BoltSize = hwM4_Bolt_AllenHeadSize;
rpXC_BeltMount_BoltLength = 40;

// Holder Points for attaching XC_CarriageBase

rpXC_BeltMount_BoltHolderWidth = 5;
rpXC_BeltMount_BoltHolderOffset = 5;
rpXC_BeltMount_BoltHolderDiameter = rpXC_CarriageMount_BoltHolderDiameter; // Rv2 = 13
rpXC_BeltMount_InnerBoltHolderDiameter = 8;

// Belt Mount Piece Base Dimensions

rpXC_BeltMount_BaseThickness = 6;			// Rv2 = 6
rpXC_BeltMount_BaseWidth = 20;			// Rv2 = 20.2
rpXC_BeltMount_BaseLength = rpXC_BeltMount_BoltSpacing; 			// Rv2 = 30
rpXC_BeltMount_BaseOffset = 16.0;			// Rv2 = 17.2

// Channels For GT2 timing belt

rpXC_BeltMount_ChannelEdgeHeight = 9;		// Rv2 = 8
rpXC_BeltMount_ChannelEdgeWidth = 2;		// Rv2
rpXC_BeltMount_ChannelEdgeLength = rpXC_BeltMount_BaseLength;

rpXC_BeltMount_ChannelCenterHeight = 9.5;		// Rv2 = 8
rpXC_BeltMount_ChannelCenterWidth = 4.2;	// Rv2 = 4.2
rpXC_BeltMount_ChannelCenterLength = rpXC_BeltMount_BoltSpacing + (rpXC_BeltMount_BoltHolderDiameter / 2);	// Rv2 = 30

// Attachment bolts for outer clamp portion

rpXC_BeltMount_ClampBoltSpacing = 25;		// Rv2
rpXC_BeltMount_ClampBoltDepth = -rpXC_BeltMount_BaseOffset - rpXC_BeltMount_BoltHolderWidth;
rpXC_BeltMount_ClampBoltOffset = rpXC_BeltMount_BoltOffset; // Rv2
rpXC_BeltMount_ClampBoltLength = 10;		// Rv2
rpXC_BeltMount_ClampBoltSize = hwM3_Bolt_AllenHeadSize;


// Values for the blower case
// -----------------------------------------------------------------------------

rpXC_CenterModuleDepth = 22;
rpXC_FrontBracketThickness = 4;
rpXC_RearBracketThickness = 4.5;

// =============================================================================

// HA_Hotend
// -----------------------------------------------------------------------------

// spacing for the hotends
hwHA_Hotend_Spacing = 24;	// Rv2 = 25

// forward offset from zero point on X-Carriage
hwHA_Hotend_Offset = 24;	// Rv2 = 27.4
hwHA_Hotend_VerticalOffset = 3.0;

hwHA_Fan_Offset = 40;		// Rv2 = 45
hwHA_Fan_VertOffset = 0;

// =============================================================================

// Maths for the XC_CarriageBase Struts
// This uses some basic trig to figure out what length and angle that the
// struts for the triangular 3-point bolt mount should be at, given the spacing 
// of the bolts

calc_boltSpacing = rpXC_BeltMount_BoltSpacing /2;
calc_boltHeight = rpXC_CarriageMount_LowerClearance + rpXC_BeltMount_BoltOffset + (rpXC_BeltMount_BoltHolderDiameter / 2);

rpXC_CarriageBase_StrutLength = sqrt(calc_boltSpacing * calc_boltSpacing + calc_boltHeight * calc_boltHeight) ;
rpXC_CarriageBase_StrutAngle = atan(calc_boltHeight / calc_boltSpacing);

rpDefaultBevel = 1;
rpDefaultWallThickness = rpDefaultBevel + 2;
rpDefaultBaseThickness = 2;

// Global Constants
// =============================================================================


hwMicroSwitch_Length = 20;
hwMicroSwitch_Width = 10;
hwMicroSwitch_Depth = 6;
hwMicroSwitch_HoleSpacing = 9.5;
hwMicroSwitch_HoleSize = 3;
hwMicroSwitch_HoleOffset = 7;
hwMicroSwitch_ScrewHeadDiameter = 6.8;	// mm

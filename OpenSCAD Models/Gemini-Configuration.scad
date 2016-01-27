// *****************************************************************************
// ( )/ )(_  _)(_  _)___(  _ \(  _  )(  _ \(  _  )(_  _)(_  _)/ __)/ __)
//  )  (  _)(_   )( (___))   / )(_)(  ) _ < )(_)(   )(   _)(_( (__ \__ \
// (_)\_)(____) (__)    (_)\_)(_____)(____/(_____) (__) (____)\___)(___/
// *****************************************************************************
// Written by bcantin@kitchissippi-robotics.com
// Copyright (c) 2015 Kitchissippi Robotics
// -----------------------------------------------------------------------------
// Master Customization File for the Gemini 3D Printer
// *****************************************************************************

include <GlobalConstants.scad>

// -----------------------------------------------------------------------------
// X Carriage Settings
// -----------------------------------------------------------------------------

// --- Linear Rail Settings

LR_CarriageBolt_Width = 0;
LR_CarriageBolt_Depth = 0;

// Aluminum Extrusion Frame Options

HW_FrameStyle = GCFrame_TNutProfile;	// Square Nut Extrusion Profile
HW_FrameSize = 20;						// 20mm x 20mm square
HW_FrameLength = 500;					// Default Tube Length
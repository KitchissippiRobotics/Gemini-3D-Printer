# Gemini-3D-Printer
<h1>CoreXY RepRap Style 3D Printer</h1>

This is a dual material large format FFF (layered filament) 3D Printer.
The targeted minimal print area is 300mm x 300mm x 400mm which can be utilized by both nozzles.

<h2>Project Status and Description</h2>

This is an in-progress design for the machine - the source may change frequently and is not currently stable.
Any questions can be directed to novakane on the freenode IRC channel #reprap

This is the third revision of the prototype.
Successful high-quality single-nozzle prints were made with the Revision 1 prototype.
No prints were done with the Revision 2 prototype - this design was intended to experiment with various aspects of the design to create a more robust machine.
This is Revision 3 - aimed at creating a more stream-lined version of Revision 2 leveraging OpenSCAD and project management tools

It is not recommended to attempt to build this printer until it is fully operational and tested.


<h2>OpenSCAD Notes</h2>

Critical component dimensions are stored in the global file /OpenSCAD Models/Dimensions.scad
- Hardware dimensions will start with the suffix "hw"
- Linear Rail Dimensions will start with the suffix "LR" - this becomes "hwLR_"


<h2>Incomplete BOM</h2>

<h3>Hardware and Electronics</h3>

<h2>Incomplete/Innacurate BOM</h2>

- (5) 20mm X 20mm x 500mm aluminum slotted extrusions (20x20 at half meter lengths) for horizontal dimensions
- (4) 1000mm for vertical segments {(4) 250mm length cut from ends to form part of the base
- (16) F694ZZ bearings for idlers
- (2) GT2-20 pulleys for drive motors
- (2) 50:1 geared NEMA17 motors for extruder pusher
- (2) 8mm ID x 13mm OD hobbed pulley with groove
- (4) Pneumatic pushfit connectors
- (2) ?? length of PTFE Tube 2mm ID x 4mm OD for bowden drive
- (4) 12mm x 500mm hardened steel rod for Z axis linear guide
- (4) LM12UU bearings for Z axis linear guide
_ (150?) M4x10mm allen head steel bolts
- (100?) M3x10mm allen head steel bolts
- (2) M4x?? hex head bolts for Y axis idlers
- (2) M4x?? hex head bolts for Y axis idlers
- (4) M4x50mm allen head steel bolts for Hotend Assembly mount to X Carriage
- (3) MGR9 x 500mm linear rails for CoreXY linear guides
- (3) micro switches for endstops
- (1) 24v 15A 360W power supply
- (1) Smoothieboard for controller
- (2) 12v 0.1A 25mm DC fan for bent cooling on hotends
- (2) jhead hotends 0.4mm nozzle
- (1) 12v 0.06A blower fan




# Gemini-3D-Printer
<h1>CoreXY RepRap Style 3D Printer</h1>

This is a large format FFF (layered filament) 3D Printer.
Many iterations and experiments performed have changed the shape of this machine over it's development phases.
This is version 5.0.x which is a complete redesign using Autodesk Fusion 360.

<h2>Version 5.0.x Redesign Notes</h2>

This iteration of the Gemini-3D printer aims to create a more robust version of the design leveraging new parts sources and better CAD software.
Rigidness, strength and compactness will be the focus of version 5.

<h3>Z Axis Improvements</h3>

Starting from the ground-up this version aims to resolve the previous issues with the Z axis bed platform.
This version will stiffen the platform using cut MDF and securely bolted double LM12UU groups per rod, mounted on four 12mm steel rods.
Both Z axis drive motors will be securely mounted and the screw will be held straight using a 608zz bearing at either end.

Also in consideration is replacing the standard RepRap 200mm x 200mm heated bed with an imported 300mm x 300mm version which was not available at the time this project was started.
Doing so would eliminate the need for the heat spreader and a number of mounting bolts. A build surface could be taped directly to the heated bed or a glass sheet could still be used if the heater is not entirely flat.

<h3>X and Y Axis Improvements</h3>

The 9mm linear rails presented binding issues on the Y axis requiring careful alignment.
Additionally, they provided little rigidity for the X axis requiring additional support.

Version 5 will explore the possibilty of using 12mm steel rods for *all* of the axis linear guides.

<h3>Extruder Changes</h3>

Version 5 will could use a few possible extruder permutations, depending on space
- Single NEMA17 direct-drive extruder on the effector
- Single Geared NEMA17 extruder on the effector
- Single NEMA11 direct-drive extruder on the effector
- Dual NEMA11 direct-drive extruders, pushing down a custom made Y splitter into a single hot-end

<h2>Project Status and Description</h2>

This is an in-progress design for the machine - the source may change frequently and is not currently stable.
Any questions can be directed to novakane on the freenode IRC channel #reprap

This is the fifth major revision of the prototype.
Successful high-quality single-nozzle prints were made with several of the previous prototypes.

It is not recommended to attempt to build this printer until it is fully operational and tested.




<h2>Incomplete BOM</h2>

<h3>Hardware and Electronics</h3>

- (1) Smoothieboard X5
- (2) NEMA17 stepper motors
- (2) NEMA17 stepper motors with integrated leadscrew

<h2>Incomplete/Innacurate/Outdated BOM</h2>

- (5) 20mm X 20mm x 500mm aluminum slotted extrusions (20x20 at half meter lengths) for horizontal dimensions
- (4) 1000mm for vertical segments
- (4) 250mm length cut from ends to form part of the base
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

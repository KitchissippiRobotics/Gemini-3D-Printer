# Gemini-3D-Printer
<h1>CoreXY RepRap Style 3D Printer</h1>

This is a test bed for experiments aiming for a large 300mm X 300mm X 400+mm print area FFF (layered filament) 3D printer.

<h2>Project Status and Description</h2>

This is an in-progress design for the machine - the source may change frequently and is not currently stable.
Any questions can be directed to novakane on the freenode IRC channel #reprap 

Initial object models were designed to minimize initial print time; test the underlying design theory; and finally, identify stress points in assembly.
This makes the parts more fragile than a production model, however the initial K02.2 prototype successfully made several prints of decent quality.
Most print failures may have been explained by early bed mounting and filament pusher mounting - these were done mostly as hacks to test the electronics and basic mechanism.

<h2>History Notes</h2>

This project is the developers second CoreXY design and 5th original 3D printer design.

- The first version - several revisions of the K02.1 - was based around an experimental carriage for movement using low cost materials
- The first version was abandoned due to required materials being made of large lengths of steel; while fully functional, the machine was heavier than ideal
- Carriages formed the basis of the successful K03.1 and K03.2 prototype delta machines, intended as outlets for recycling initial K02 materials, fully functional but incomplete at this writing.
- Cost analysis revealed that the original K02 (and perhaps K03) was not providing significant savings in cost vs production effort 
- production of the K02/K03 machines accurately requires machinery exceeding any savings - they can be built with simple tools like a punch/hand-drill/hacksaw, but great care must be taken (mass replication would be difficult)


<h2>Work Notes</h2>

This project is the developers second CoreXY design and 5th original 3D printer design.

- The first version - several revisions of the K02.1 - was based around an experimental carriage for movement using low cost materials
- The first version was abandoned due to required materials being made of steel; while fully functional, the machine was heavier than ideal
- Carriages formed the basis of the successful K03.1 and K03.2 prototype delta machines, intended as outlets for recycling initial K02 materials, fully functional but incomplete at this writing.
- Cost analysis revealed that the original K02 (and perhaps K03) was not providing significant savings in cost vs production effort 
- production of the K02/K03 machines accurately requires machinery exceeding any savings - they can be built with simple tools like a punch/hand-drill/hacksaw, but great care must be taken (mass replication would be difficult)

<h2>Development Notes</h2>

*19/March/2015* Hotend Chassis now merged into the Master. Starting work on finalizing rest of X carriage.

<h2>Incomplete BOM</h2>

<h3>Hardware and Electronics</h3>

<h2>Incomplete BOM</h2>

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

<h2>Voltage converters for inputs to controller from 24v PSU</h2>

24v in - heatbed, hotends, motors
12v in - fans in Hotend assembly / X Carriage / Electronics Assembly (keep under 2 amp)
5v  in - USB/ethernet/CPU power (USB equivalent draw) (keep under 1 amp)

<h2>About the Developer</h2>

- "I am not an engineer, but I play one on the Internet"
- I have played many roles in my life, I am a software developer, an artist, an animator, a musician, a labourer, a technical analyst, a network engineer, an electronics engineer, an educator, a lover, a fighter.
- I am a jack of all trades, a traveller of life and today - I am a roboticist.
- I can be found on #reprap IRC as "novakane"
- I am attempting to bring together what little I know of mechanics, assembly, and avionics into a cohesive 3D printing platform


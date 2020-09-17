## System Purpose

This is a miniature arcade machine that can be played utilizing an accompanying phone app. The objective of this project is to provide a fun desk decoration that can be turned on, connected to, and played quickly during downtime. It should be small enough as too not intrude on desk space but large enough to contain a screen large enough to facilitate an enjoyable playing experience.

## Definitions, Acronyms, and Abbreviations

### Definitions

OpenSCad - script based computer aided design software (CAD) for modeling 3D objects\
Bluetooth - wireless standard used for data exchange

### Acronyms and Abbreviations

MCU - Microcontroller Unit\
PLA - Plastic used for printing chassis(Polylactic acid)\
FDM - 3D printing Process (Fused Filament Fabrication)\

## System Overview

The projected subsystems of this project include the audio, video, wireless connection, app, game logic, and 3D design.

![Blackbox Design](../diagrams/blackbox/blackbox_v2.png)

A small speaker is employed for audio, a color LCD for video, and a HC-06 for the interface between the phone app and the MCU through bluetooth. The chassis is designed utilizing openSCad and is  printed from a FDM printer, specifically the Ender 3 pro, using black eSun PLA+. The game logic is based off of the 1978 arcade game Space invaders.

### External Inputs and Outputs
| Name | Description | Use |
| - | - | - |
| Phone Application (Input) | Phone Application that allows for directional input, a fire button, a select button, and a start button | Allows for user to interact with the game on the arcade |
| Display | An LCD that displays the different frames of the game when the arcade is switched on | Allows user to interact with the game |
| Audio | A Speaker that plays sound cues and music when the arcade is switched on | Creates a more immersive experience |


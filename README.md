# Introduction
This is an app that I'm building as a side project and learning project. It is intended to be of aid to photographers for planning shots, calculating shutter times, modify EXIF files, etc.

# The App
The app features different tabs with different tools for photographers.
## Features
- Sunset, Sunrise and magic hours calculator
- Shutter speed, aperture, ISO conversion
## Planned Features
- DOF Calculator
- EXIF Editor
## To-Dos
- When shutter time calculation exceeds the normal values, print out the time in h ' " format
## Known issues
- The optionality of Date? in Solar.swift is not dealt with. Date is optional because there can be no sunset or no sunrise depending on your location, so insted of force unwrapping it in the viewModel I should deal with the possibility of there being no date in the view --> right now this would cause my app to crash

## To Implement
- Third stops: implementing this will bring precision and rounding issues. Currenlty ratios are calculated by rounding logarithmsm and because I'm working with full stops I can be sure that the result will be an Int (except for precision errors, taken care by the rounding). By implementing third stops, the result of the log of the ration can be x.3333333333 or x.66666666666.
- Focus (DOF) calculator
- EXIF Editor

# Credits
- Solar calculations performed with Solar  by Chris Howell - https://github.com/ceeK/Solar - Copyright © 2016 Chris Howell. All rights reserved.
- App icon adapted by me from a graphic by Althepal on Wikipedia - English Wikipedia - Graphic by AlthepalThis W3C-unspecified vector image was created with Inkscape.Transferred from en.wikipedia to Commons by Ludmiła Pilecka using CommonsHelper., CC BY-SA 2.5, https://commons.wikimedia.org/w/index.php?curid=8020183






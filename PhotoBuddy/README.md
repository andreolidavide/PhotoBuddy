# Notes

# To-Dos
- When shutter time calculation exceeds the normal values, print out the time in h ' " format
- Deal with the optionality of Date? in Solar.swift. Date is optional because there can be no sunset or no sunrise depending on your location, so insted of force unwrapping it in the viewModel I should deal with the possibility of there being no date in the view

# To Implement
- Third stops: implementing this will bring precision and rounding issues. Currenlty ratios are calculated by rounding logarithmsm and because I'm working with full stops I can be sure that the result will be an Int (except for precision errors, taken care by the rounding). By implementing third stops, the result of the log of the ration can be x.3333333333 or x.66666666666.
- Focus (DOF) calculator
- EXIF Editor




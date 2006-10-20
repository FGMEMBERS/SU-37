# Drop-view functions
#--------------------------------------------------------------------
# Let FG get initialised before trying to set a position.
initialise = func {
  settimer(initialise_drop_view_pos, 4);
}
#--------------------------------------------------------------------
# Initialise the view to the starting location.
initialise_drop_view_pos = func {
  eyelatdeg = getprop("/position/latitude-deg");
  eyelondeg = getprop("/position/longitude-deg");
  eyealtft = getprop("/position/altitude-ft") + 20;
  setprop("/sim/view[6]/latitude-deg", eyelatdeg);
  setprop("/sim/view[6]/longitude-deg", eyelondeg);
  setprop("/sim/view[6]/altitude-ft", eyealtft);
  print("Drop-view initialised");
}
#--------------------------------------------------------------------
# Move the view to the current location.
update_drop_view_pos = func {
  eyelatdeg = getprop("/position/latitude-deg");
  eyelondeg = getprop("/position/longitude-deg");
  eyealtft = getprop("/position/altitude-ft") + 20;
  interpolate("/sim/view[6]/latitude-deg", eyelatdeg, 5);
  interpolate("/sim/view[6]/longitude-deg", eyelondeg, 5);
  interpolate("/sim/view[6]/altitude-ft", eyealtft, 5);
}
#--------------------------------------------------------------------

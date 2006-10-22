# FCS AEI animation handler.
#--------------------------------------------------------------------
initialise = func {
  settimer(fod_screens, 4);
}
#--------------------------------------------------------------------
fod_screens = func {
  # FOD screens animation.
  # Check that agl and lower them when below the set agl.
  # This animation script has no effect upon the aerodynamic
  # behaviour.

  fcs_fod_screens_agl_ft = getprop("/autopilot/FCS/settings/fod-screens-agl-ft");
  altitude_agl_ft = getprop("/position/altitude-agl-ft");

  if(altitude_agl_ft < fcs_fod_screens_agl_ft) {
    interpolate("/autopilot/FCS/controls/engines/fod-screens-pos-norm", 1, 0.5);
  } else {
    interpolate("/autopilot/FCS/controls/engines/fod-screens-pos-norm", 0, 0.5);
  }
  # This doesn't need a high refresh rate but set it higher than
  # the animation interpolation period.
  settimer(fod_screens, 1.0);
}
#--------------------------------------------------------------------

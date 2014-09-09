# FCS AEI animation handler.
#--------------------------------------------------------------------
# Globals
fcs_fod_screens_agl_ft = props.globals.getNode("/autopilot/FCS/settings/fod-screens-agl-ft", 1);
fcs_fod_screens_norm = props.globals.getNode("/autopilot/FCS/controls/engines/fod-screens-norm", 1);
altitude_agl_ft = props.globals.getNode("/position/altitude-agl-ft", 1);
#--------------------------------------------------------------------
# Functions
#--------------------------------------------------------------------
initialise = func {
  settimer(fod_screens, 0.2);
}
#--------------------------------------------------------------------
fod_screens = func {
  # FOD screens animation.
  # Check the agl and lower the screens when below the set agl.
  # This animation script has no effect upon the aerodynamic
  # behaviour.

  if(altitude_agl_ft.getValue() < fcs_fod_screens_agl_ft.getValue()) {
    fcs_fod_screens_norm.setDoubleValue(1);
  } else {
    fcs_fod_screens_norm.setDoubleValue(0);
  }
  settimer(fod_screens, 0.2);
}
#--------------------------------------------------------------------

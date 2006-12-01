# FCS AEI animation handler.
#--------------------------------------------------------------------
# Globals
fcs_fod_screens_agl_ft = props.globals.getNode("/autopilot/FCS/settings/fod-screens-agl-ft", 1);
fcs_fod_screens_norm = props.globals.getNode("/autopilot/FCS/controls/engines/fod-screens-norm", 1);
#--------------------------------------------------------------------
# Functions
#--------------------------------------------------------------------
initialise = func {
#  setlistener("/position/altitude-agl-ft", fod_screens);
  setlistener("/autopilot/FCS/internal/altitude-agl-ft-filtered", fod_screens);
}
#--------------------------------------------------------------------
fod_screens = func {
  # FOD screens animation.
  # Check the agl and lower the screens when below the set agl.
  # This animation script has no effect upon the aerodynamic
  # behaviour.

  altitude_agl_ft = cmdarg().getValue();

  if(altitude_agl_ft < fcs_fod_screens_agl_ft.getValue()) {
    fcs_fod_screens_norm.setDoubleValue(1);
  } else {
    fcs_fod_screens_norm.setDoubleValue(0);
  }
}
#--------------------------------------------------------------------

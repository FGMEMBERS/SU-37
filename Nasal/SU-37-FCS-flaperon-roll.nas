# FCS flaperon roll handler
#--------------------------------------------------------------------
# Globals
fcs_flaperon_flaps_norm = props.globals.getNode("/autopilot/FCS/controls/flaperon-flaps-norm", 1);
fcs_flaperon_roll_norm = props.globals.getNode("/autopilot/FCS/controls/flaperon-roll-norm", 1);
fcs_elevon_roll_norm = props.globals.getNode("/autopilot/FCS/controls/elevon-roll-norm", 1);
#--------------------------------------------------------------------
# Functions
#--------------------------------------------------------------------
initialise = func {
  settimer(flaperon_roll, 0.1);
}
#--------------------------------------------------------------------
flaperon_roll = func {
  # Slaves the flaperon roll to the elevon roll when no flap exteneded.

  if(fcs_flaperon_flaps_norm.getValue() == 0) {
    fcs_flaperon_roll_norm.setDoubleValue(fcs_elevon_roll_norm.getValue());
  } else {
    fcs_flaperon_roll_norm.setDoubleValue(0);
  }
  settimer(flaperon_roll, 0.1);
}
#--------------------------------------------------------------------

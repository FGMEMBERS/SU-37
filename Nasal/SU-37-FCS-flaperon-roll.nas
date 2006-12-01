# FCS flaperon roll handler
#--------------------------------------------------------------------
# Globals
fcs_flaperon_flaps_norm = props.globals.getNode("/autopilot/FCS/controls/flaperon-flaps-norm", 1);
fcs_flaperon_roll_norm = props.globals.getNode("/autopilot/FCS/controls/flaperon-roll-norm", 1);
#--------------------------------------------------------------------
# Functions
#--------------------------------------------------------------------
initialise = func {
  setlistener("/autopilot/FCS/controls/elevon-roll-norm", flaperon_roll);
}
#--------------------------------------------------------------------
flaperon_roll = func {
  # Slaves the flaperon roll to the elevon roll when no flap exteneded.

  elevon_roll_norm = cmdarg().getValue();

  if(fcs_flaperon_flaps_norm.getValue() == 0) {
    fcs_flaperon_roll_norm.setDoubleValue(elevon_roll_norm);
  } else {
    fcs_flaperon_roll_norm.setDoubleValue(0);
  }
}
#--------------------------------------------------------------------

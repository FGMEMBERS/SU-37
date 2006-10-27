# FCS raw pilot input listeners and subroutines
#--------------------------------------------------------------------
initialise = func {
  setlistener("/autopilot/FCS/inputs/flaps-filtered", flap_input);
}
#--------------------------------------------------------------------
flap_input = func {
  # Monitor flap input.
  # Handles manual flap extend/retract when in direct mode.  Pilot
  # input is ignored when flaps are in auto mode.

  raw_flap_input = cmdarg().getValue();

  fcs_auto_flap_lock = props.globals.getNode("/autopilot/FCS/locks/auto-flaps");
  fcs_flaperon_flap_norm = props.globals.getNode("/autopilot/FCS/controls/flaperon-flap-norm", 1);

  if(fcs_auto_flap_lock.getValue() == "off") {
    if(raw_flap_input != 0) {
      fcs_flaperon_flap_norm.setDoubleValue(raw_flap_input);
    } else {
      fcs_flaperon_flap_norm.setDoubleValue(0.0);
    }
  }
}
#--------------------------------------------------------------------

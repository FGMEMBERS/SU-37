# FCS raw pilot input listeners and subroutines
#--------------------------------------------------------------------
initialise = func {
  setprop("/autopilot/locks/heading", "");
  setlistener("/autopilot/FCS/inputs/aileron-filtered", elevon_roll_input);
}
#--------------------------------------------------------------------
elevon_roll_input = func {
  # Monitor aileron input.

  raw_aileron_input = cmdarg().getValue();

  target_roll_deg = props.globals.getNode("/autopilot/settings/target-roll-deg", 1);
  fcs_elevon_roll_norm = props.globals.getNode("/autopilot/FCS/controls/elevon-roll-norm", 1);
  fcs_stick_mode = props.globals.getNode("/autopilot/FCS/modes/stick", 1);
  fcs_roll_factor = props.globals.getNode("/autopilot/FCS/settings/roll-factor", 1);
  ap_heading_lock = props.globals.getNode("/autopilot/locks/heading", 1);

  # If an AP heading hold mode is set then ignore pilot input.
  # Otherwise, if the FCS stick mode is not direct then we're in FCS mode so set the
  # target roll.
  # If the FCS stick mode is direct then we're in direct mode so feed the input
  # straight to the controls and zero the fcs roll target.


  if(ap_heading_lock.getValue() == "") {
    if(fcs_stick_mode.getValue() != "direct") {
      target_roll_deg.setDoubleValue(fcs_roll_factor.getValue() * raw_aileron_input);
    } else {
      fcs_elevon_roll_norm.setDoubleValue(raw_aileron_input);
      target_roll_deg.setDoubleValue(0.0);
    }
  }
}
#--------------------------------------------------------------------

# FCS raw roll pilot input handler
#--------------------------------------------------------------------
# Globals
target_roll_deg = props.globals.getNode("/autopilot/settings/target-roll-deg", 1);
fcs_cubed_input_lock = props.globals.getNode("/autopilot/FCS/locks/cubed-input", 1);
fcs_elevon_roll_norm = props.globals.getNode("/autopilot/FCS/controls/elevon-roll-norm", 1);
fcs_stick_mode = props.globals.getNode("/autopilot/FCS/modes/stick", 1);
fcs_roll_factor = props.globals.getNode("/autopilot/FCS/settings/roll-factor", 1);
ap_heading_lock = props.globals.getNode("/autopilot/locks/heading", 1);
raw_aileron_input = props.globals.getNode("/controls/flight/aileron", 1);
#--------------------------------------------------------------------
# Functions
#--------------------------------------------------------------------
initialise = func {
  fcs_elevon_roll_norm.setValue(0);
  ap_heading_lock.setValue("");
  raw_aileron_input.setValue(0);
  settimer(elevon_roll_input, 0.1);
}
#--------------------------------------------------------------------
elevon_roll_input = func {
  # Monitor aileron input.
  # If an AP heading hold mode is set then ignore pilot input.
  # Otherwise, if the FCS stick mode is not direct then we're in FCS mode so set the
  # target roll.
  # If the FCS stick mode is direct then we're in direct mode so feed the input
  # straight to the controls and zero the fcs roll target.

  rai = raw_aileron_input.getValue();

  if(ap_heading_lock.getValue() == "") {
    if(fcs_stick_mode.getValue() != "direct") {
      target_roll_deg.setDoubleValue(fcs_roll_factor.getValue() * rai);
    } else {
      if(fcs_cubed_input_lock.getValue() == "engaged") {
        fcs_elevon_roll_norm.setValue((rai * rai * rai));
      } else {
        fcs_elevon_roll_norm.setValue(rai);
      }
      target_roll_deg.setDoubleValue(0.0);
    }
  }
  settimer(elevon_roll_input, 0.1);
}
#--------------------------------------------------------------------

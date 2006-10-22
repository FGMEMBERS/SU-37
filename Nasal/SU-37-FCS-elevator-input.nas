# FCS raw pilot elevator input handler
#--------------------------------------------------------------------
initialise = func {
  setprop("/autopilot/locks/altitude", "");
  setlistener("/autopilot/FCS/inputs/elevator-filtered", elevator_input);
}
#--------------------------------------------------------------------
elevator_input = func {
  # Monitor pilot elevator input.

  raw_elevator_input = cmdarg().getValue();

  target_climb_rate_fps = props.globals.getNode("/autopilot/settings/target-climb-rate-fps", 1);
  target_pitch_deg = props.globals.getNode("/autopilot/settings/target-pitch-deg", 1);
  fcs_elevon_pitch_norm = props.globals.getNode("/autopilot/FCS/controls/elevon-pitch-norm", 1);

  fcs_stick_mode = props.globals.getNode("/autopilot/FCS/modes/stick");

  fcs_max_climb_rate_fps = props.globals.getNode("/autopilot/FCS/settings/max-climb-rate-fps");
  fcs_min_climb_rate_fps = props.globals.getNode("/autopilot/FCS/settings/min-climb-rate-fps");
  fcs_max_pitch_deg = props.globals.getNode("/autopilot/FCS/settings/max-pitch-deg");
  fcs_min_pitch_deg = props.globals.getNode("/autopilot/FCS/settings/min-pitch-deg");

  ap_altitude_lock = props.globals.getNode("/autopilot/locks/altitude", 1);

  # If an AP altitude hold mode is set then ignore pilot input.
  # Otherwise, if the FCS pitch or vfps locks are engaged then we're in FCS mode, one
  # way or another.
  # If the FCS pitch lock isn't engaged then we're in direct mode so feed the input
  # straight to the controls and zero the fcs pitch and vfps targets.

  if(ap_altitude_lock.getValue() == "") {
    if(fcs_stick_mode.getValue() == "pitch") {
      if(raw_elevator_input > 0) {
        target_pitch_deg.setDoubleValue(fcs_min_pitch_deg.getValue() * raw_elevator_input);
      } else {
        target_pitch_deg.setDoubleValue(fcs_max_pitch_deg.getValue() * (-1 * raw_elevator_input));
      }
    } elsif(fcs_stick_mode.getValue() == "vfps") {
      if(raw_elevator_input > 0) {
        target_climb_rate_fps.setDoubleValue(fcs_min_climb_rate_fps.getValue() * raw_elevator_input);
      } else {
        target_climb_rate_fps.setDoubleValue(fcs_max_climb_rate_fps.getValue() * (-1 * raw_elevator_input));
      }
    } else {
      fcs_elevon_pitch_norm.setDoubleValue(raw_elevator_input);
      target_climb_rate_fps.setDoubleValue(0.0);
      target_pitch_deg.setDoubleValue(0.0);
    }
  }
}
#--------------------------------------------------------------------

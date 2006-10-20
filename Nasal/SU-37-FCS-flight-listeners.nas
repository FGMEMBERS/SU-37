# FCS raw pilot input listeners and subroutines
#--------------------------------------------------------------------
initialise = func {
  setlistener("/autopilot/FCS/inputs/aileron-filtered", aileron_input);
  setlistener("/autopilot/FCS/inputs/elevator-filtered", elevator_input);
  setlistener("/autopilot/FCS/inputs/flaps-filtered", flap_input);
}
#--------------------------------------------------------------------
aileron_input = func {
  # Monitor aileron input.

  fcs_roll_lock = getprop("/autopilot/FCS/locks/roll");
  fcs_roll_factor = getprop("/autopilot/FCS/settings/roll-factor");
  ap_heading_lock = getprop("/autopilot/locks/heading");
  raw_aileron_input = getprop("/controls/flight/aileron");
#  mach = getprop("/velocities/mach");

#  fcs_control_factor = 1.1 - mach;
  
#  if(fcs_control_factor < 0.1) {
#    fcs_control_factor = 0.1;
#  } elsif(fcs_control_factor > 1) {
    fcs_control_factor = 1;
#  }

  setprop("/autopilot/FCS/controls/direct-control-factor", fcs_control_factor);

  if(fcs_roll_lock == "engaged") {
    if(ap_heading_lock == "") {
      target_roll_deg = fcs_roll_factor * raw_aileron_input;
      setprop("/autopilot/settings/target-roll-deg", target_roll_deg);
    }
  } else {
    fcs_scaled_aileron_input = fcs_control_factor * raw_aileron_input;
    setprop("/autopilot/FCS/controls/elevon-roll-norm", fcs_scaled_aileron_input);
    setprop("/autopilot/settings/target-roll-deg", 0);
  }
}
#--------------------------------------------------------------------
elevator_input = func {
  # Monitor elevator input.

  fcs_pitch_lock = getprop("/autopilot/FCS/locks/roll");
  fcs_vfps_lock = getprop("/autopilot/FCS/locks/vfps");
  fcs_pitch_climb_agl_ft = getprop("/autopilot/FCS/settings/pitch-climb-agl-ft");
  fcs_max_climb_rate_fps = getprop("/autopilot/FCS/settings/max-climb-rate-fps");
  fcs_min_climb_rate_fps = getprop("/autopilot/FCS/settings/min-climb-rate-fps");
  fcs_low_alt_max_pitch_deg = getprop("/autopilot/FCS/settings/low-alt-max-pitch-deg");
  ap_altitude_lock = getprop("/autopilot/locks/altitude");
  raw_elevator_input = getprop("/controls/flight/elevator");
  altitude_agl_ft = getprop("position/altitude-agl-ft");
#  mach = getprop("/velocities/mach");

#  fcs_control_factor = 1.1 - mach;

#  if(fcs_control_factor < 0.1) {
#    fcs_control_factor = 0.1;
#  } elsif(fcs_control_factor > 1) {
    fcs_control_factor = 1;
#  }

  setprop("/autopilot/FCS/controls/direct-control-factor", fcs_control_factor);

  if(fcs_pitch_lock == "engaged") {
    if(ap_altitude_lock == "") {
      if(fcs_vfps_lock == "engaged") {
        target_climb_rate_fps = fcs_max_climb_rate_fps * (-1 * raw_elevator_input);
        setprop("/autopilot/settings/target-climb-rate-fps", target_climb_rate_fps);
      } else {
        target_pitch_deg = fcs_low_alt_max_pitch_deg * (-1 * raw_elevator_input);
        setprop("/autopilot/FCS/locks/vfps", "");
        setprop("/autopilot/settings/target-pitch-deg", target_pitch_deg);
      }
    }
  } else {
    fcs_scaled_elevator_input = fcs_control_factor * raw_elevator_input;
    setprop("/autopilot/settings/target-climb-rate-fps", 0);
    setprop("/autopilot/FCS/controls/elevon-pitch-norm", fcs_scaled_elevator_input);
  }
}
#--------------------------------------------------------------------
flap_input = func {
  # Monitor flap input.
  # Handles manual flap extend/retract when in direct mode.  Pilot
  # input is ignored when flaps are in auto mode.

  fcs_auto_flap_lock = getprop("/autopilot/FCS/locks/auto-flaps");
  raw_flap_input = getprop("/controls/flight/flaps");

  if(fcs_auto_flap_lock == "off") {
    if(raw_flap_input != 0) {
      setprop("/autopilot/FCS/controls/flaperon-flap-norm", raw_flap_input);
    } else {
      setprop("/autopilot/FCS/controls/flaperon-flap-norm", 0);
    }
  }
}
#--------------------------------------------------------------------

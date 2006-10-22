# FCS raw pilot input listeners and subroutines
#--------------------------------------------------------------------
initialise = func {
  setlistener("/autopilot/FCS/inputs/aileron-filtered", aileron_input);
  setlistener("/autopilot/FCS/inputs/flaps-filtered", flap_input);
}
#--------------------------------------------------------------------
aileron_input = func {
  # Monitor aileron input.

  fcs_roll_lock = getprop("/autopilot/FCS/locks/roll");
  fcs_roll_factor = getprop("/autopilot/FCS/settings/roll-factor");
  ap_heading_lock = getprop("/autopilot/locks/heading");
  raw_aileron_input = getprop("/controls/flight/aileron");

  if(fcs_roll_lock == "engaged") {
    if(ap_heading_lock == "") {
      target_roll_deg = fcs_roll_factor * raw_aileron_input;
      setprop("/autopilot/settings/target-roll-deg", target_roll_deg);
    }
  } else {
    setprop("/autopilot/FCS/controls/elevon-roll-norm", raw_aileron_input);
    setprop("/autopilot/settings/target-roll-deg", 0);
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

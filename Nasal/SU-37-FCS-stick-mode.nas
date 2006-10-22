# FCS Stick mode handlers
#--------------------------------------------------------------------
initialise = func {

  # Store the elevator-trim at start-up.
  elevator_trim = getprop("/controls/flight/elevator-trim");
  setprop("/autopilot/FCS/store/elevator-trim", elevator_trim);

  setlistener("/autopilot/FCS/modes/stick", fcs_stick_mode_monitor);

  settimer(fcs_stick_mode_monitor, 2);
}
#--------------------------------------------------------------------
fcs_stick_mode_monitor = func {
  # This listens to the FCS mode

  fcs_stick_mode = getprop("/autopilot/FCS/modes/stick");
  fcs_pitch_lock = getprop("/autopilot/FCS/locks/pitch");
  fcs_vfps_lock = getprop("/autopilot/FCS/locks/vfps");
  fcs_roll_lock = getprop("/autopilot/FCS/locks/roll");
  ap_altitude_lock = getprop("/autopilot/locks/altitude");
  elevator_trim = getprop("/controls/flight/elevator-trim");

  if(fcs_stick_mode == "direct") {
    setprop("/autopilot/locks/altitude", "");
    setprop("/autopilot/locks/heading", "");
    setprop("/autopilot/FCS/locks/pitch", "off");
    setprop("/autopilot/FCS/locks/vfps", "off");
    setprop("/autopilot/FCS/locks/roll", "off");
    stored_elevator_trim = getprop("/autopilot/FCS/store/elevator-trim");
    interpolate("/controls/flight/elevator-trim", stored_elevator_trim, 4);
  } elsif(fcs_stick_mode == "pitch") {
    setprop("/autopilot/FCS/store/elevator-trim", elevator_trim);
    interpolate("/controls/flight/elevator-trim", 0, 4);
    setprop("/autopilot/FCS/locks/pitch", "engaged");
    setprop("/autopilot/FCS/locks/vfps", "off");
    setprop("/autopilot/FCS/locks/roll", "engaged");
  } elsif(fcs_stick_mode == "vfps") {
    setprop("/autopilot/FCS/store/elevator-trim", elevator_trim);
    interpolate("/controls/flight/elevator-trim", 0, 4);
    setprop("/autopilot/FCS/locks/pitch", "engaged");
    setprop("/autopilot/FCS/locks/vfps", "engaged");
    setprop("/autopilot/FCS/locks/roll", "engaged");
  }
}
#--------------------------------------------------------------------

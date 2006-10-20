# FCS locks listeners
#--------------------------------------------------------------------
initialise = func {
  setlistener("/autopilot/FCS/modes/stick", fcs_stick_mode_monitor);
  setlistener("/autopilot/locks/speed", speed_lock_monitor);

  settimer(fcs_stick_mode_monitor, 2);
}
#--------------------------------------------------------------------
fcs_stick_mode_monitor = func {
  # This listens to the FCS mode

  fcs_stick_mode = getprop("/autopilot/FCS/modes/stick");
  elevator_trim = getprop("/controls/flight/elevator-trim");

  if(fcs_stick_mode == "FCS") {
    setprop("/autopilot/FCS/store/elevator-trim", elevator_trim);
    interpolate("/controls/flight/elevator-trim", 0, 4);
    setprop("/autopilot/FCS/locks/pitch", "engaged");
    setprop("/autopilot/FCS/locks/roll", "engaged");
  } else {
    setprop("/autopilot/FCS/locks/pitch", "off");
    setprop("/autopilot/FCS/locks/roll", "off");
    stored_elevator_trim = getprop("/autopilot/FCS/store/elevator-trim");
    interpolate("/controls/flight/elevator-trim", stored_elevator_trim, 4);
  }
}
#--------------------------------------------------------------------
speed_lock_monitor = func {
  fcs_auto_speedbrake_lock = getprop("/autopilot/FCS/locks/auto-speedbrake");
  speed_lock = getprop("/autopilot/locks/speed");

  if(fcs_auto_speedbrake_lock == "engaged") {
    if(speed_lock == "speed-with-throttle") {
      setprop("/autopilot/FCS/modes/auto-speedbrake", "kias");
    } elsif(speed_lock == "mach-with-throttle") {
      setprop("/autopilot/FCS/modes/auto-speedbrake", "mach");
    } else {
      setprop("/autopilot/FCS/modes/auto-speedbrake", "off");
      setprop("/autopilot/FCS/controls/spoiler-norm", 0);
    }
  } elsif(fcs_auto_speedbrake_lock == "off") {
    setprop("/autopilot/FCS/modes/auto-speedbrake", "off");
    setprop("/autopilot/FCS/controls/spoiler-norm", 0);
  }
}
#--------------------------------------------------------------------

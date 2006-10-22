# FCS Speed lock handler
#--------------------------------------------------------------------
initialise = func {
  setlistener("/autopilot/locks/speed", speed_lock_monitor);
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

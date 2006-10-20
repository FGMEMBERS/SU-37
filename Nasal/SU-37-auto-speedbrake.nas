#--------------------------------------------------------------------
initialise = func {
  setlistener("/autopilot/locks/speed", speed_lock_monitor);
}
#--------------------------------------------------------------------
toggle_auto_speedbrake = func {
  auto_speedbrake_lock = getprop("/autopilot/locks/auto-speedbrake");

  if(auto_speedbrake_lock == "engaged") {
    setprop("/autopilot/locks/auto-speedbrake", "off");
    setprop("/controls/flight/spoilers", 0);
  } else {
    setprop("/autopilot/locks/auto-speedbrake", "engaged");
  }
  speed_lock_monitor();
}
#--------------------------------------------------------------------
speed_lock_monitor = func {
  auto_speedbrake_lock = getprop("/autopilot/locks/auto-speedbrake");
  speed_lock = getprop("/autopilot/locks/speed");

  if(speed_lock == "speed-with-throttle") {
    if(auto_speedbrake_lock == "engaged") {
      setprop("/autopilot/FCS/locks/auto-speedbrake", "kias");
    } else {
      setprop("/autopilot/FCS/locks/auto-speedbrake", "off");
    }
  } elsif(speed_lock == "mach-with-throttle") {
    if(auto_speedbrake_lock == "engaged") {
      setprop("/autopilot/FCS/locks/auto-speedbrake", "mach");
    } else {
      setprop("/autopilot/FCS/locks/auto-speedbrake", "off");
    }
  } else {
    setprop("/autopilot/FCS/locks/auto-speedbrake", "off");
  }
}
#--------------------------------------------------------------------

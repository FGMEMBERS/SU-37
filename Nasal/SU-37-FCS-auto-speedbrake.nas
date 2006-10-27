#--------------------------------------------------------------------
initialise = func {
  setprop("/autopilot/locks/speed", "");
  setlistener("/autopilot/locks/speed", ap_speed_lock_monitor);
  setlistener("/autopilot/settings/target-speed-kt", ap_target_kt_monitor);
  setlistener("/autopilot/settings/target-mach", ap_target_mach_monitor);
  setlistener("/autopilot/FCS/locks/auto-speedbrake", fcs_auto_speedbrake_lock_monitor);
  p = "/autopilot/settings/target-speed-kt";
  setprop(p, getprop(p));
  p = "/autopilot/settings/target-mach";
  setprop(p, getprop(p));
}
#--------------------------------------------------------------------
ap_speed_lock_monitor = func {
  # Monitor the AP speed lock and set the appropriate FCS speedbrake
  # locks and modes.
  # If the AP speed lock is not set i.e. direct control of throttles
  # set both fcs auto speedbrake lock and mode to off as there's no
  # target.

  ap_speed_lock = cmdarg().getValue();

  fcs_auto_speedbrake_lock = props.globals.getNode("/autopilot/FCS/locks/auto-speedbrake");
  fcs_auto_speedbrake_mode = props.globals.getNode("/autopilot/FCS/modes/auto-speedbrake");
  fcs_speedbrake_norm = props.globals.getNode("/autopilot/FCS/controls/speedbrake-norm");

  if(ap_speed_lock == "speed-with-throttle") {
    if(fcs_auto_speedbrake_lock.getValue() == "engaged") {
      fcs_auto_speedbrake_mode.setValue("kias");
    } else {
      fcs_auto_speedbrake_mode.setValue("off");
      fcs_speedbrake_norm.setValue(0);
    }
  } elsif(ap_speed_lock == "mach-with-throttle") {
    if(fcs_auto_speedbrake_lock.getValue() == "engaged") {
      fcs_auto_speedbrake_mode.setValue("mach");
    } else {
      fcs_auto_speedbrake_mode.setValue("off");
      fcs_speedbrake_norm.setValue(0);
    }
  } else {
    fcs_auto_speedbrake_lock.setValue("off");
    fcs_auto_speedbrake_mode.setValue("off");
  }
}
#--------------------------------------------------------------------
ap_target_kt_monitor = func {
  # Monitor the AP target kt setting and calculate the extend kts.
  ap_target_kt = cmdarg().getValue();
  fcs_speedbrake_extend_kt = props.globals.getNode("/autopilot/FCS/settings/speedbrake-extend-kt");

  fcs_speedbrake_extend_kt.setDoubleValue(ap_target_kt + 10);
}
#--------------------------------------------------------------------
ap_target_mach_monitor = func {
  # Monitor the AP target mach setting and calculate the extend mach.
  ap_target_mach = cmdarg().getValue();
  fcs_speedbrake_extend_mach = props.globals.getNode("/autopilot/FCS/settings/speedbrake-extend-mach");

  fcs_speedbrake_extend_mach.setDoubleValue(ap_target_mach + 0.015);
}
#--------------------------------------------------------------------
fcs_auto_speedbrake_lock_monitor = func {
  # Monitor the FCS auto-speedbrake lock and trigger
  # ap_speed_lock_monitor to set the appropriate mode.
  ap_speed_lock = props.globals.getNode("/autopilot/locks/speed");
  ap_speed_lock.setValue(ap_speed_lock.getValue());
}
#--------------------------------------------------------------------

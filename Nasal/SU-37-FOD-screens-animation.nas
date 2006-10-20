# FCS AEI animation handler.
#--------------------------------------------------------------------
initialise = func {
  settimer(fod_screens, 4);
  setlistener("/autopilot/FCS/locks/fod-screens", fod_screens_lock_monitor);
}
#--------------------------------------------------------------------
fod_screens = func {
  # FOD screens animation.
  # Set the FOD screens locks.
  # This animation script has no effect upon the aerodynamic
  # behaviour.

  fcs_fod_screens_lock = getprop("/autopilot/FCS/locks/fod-screens");
  fcs_fod_screens_agl_ft = getprop("/autopilot/FCS/settings/fod-screens-agl-ft");
  altitude_agl_ft = getprop("/position/altitude-agl-ft");

  if(altitude_agl_ft < fcs_fod_screens_agl_ft) {
    if(fcs_fod_screens_lock == "lowered") {
      setprop("/autopilot/FCS/locks/fod-screens", "raised");
    }
  } else {
    if(fcs_fod_screens_lock == "raised") {
      setprop("/autopilot/FCS/locks/fod-screens", "lowered");
    }
  }
  settimer(fod_screens, 0.1);
}
#--------------------------------------------------------------------
fod_screens_lock_monitor = func {
  # Monitor the FOD screens lock and raise or lower them.
  # This is only required to smooth the animation.

  fcs_fod_screens_lock = getprop("/autopilot/FCS/locks/fod-screens");
  fcs_fod_screens_pos_norm = getprop("/autopilot/FCS/controls/engines/fod-screens-pos-norm");

  if(fcs_fod_screens_lock == "raised") {
    if(fcs_fod_screens_pos_norm == 0) {
      interpolate("/autopilot/FCS/controls/engines/fod-screens-pos-norm", 1, 1);
    }
  } else {
    if(fcs_fod_screens_pos_norm == 1) {
      interpolate("/autopilot/FCS/controls/engines/fod-screens-pos-norm", 0, 1);
    }
  }
}
#--------------------------------------------------------------------

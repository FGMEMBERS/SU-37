# FCS Velocities listeners
#--------------------------------------------------------------------
initialise = func {
  setlistener("/autopilot/FCS/inputs/mach-filtered", mach_monitor);
}
#--------------------------------------------------------------------
mach_monitor = func {
  # Monitor mach

  flaperon_flaps();
}
#--------------------------------------------------------------------
flaperon_flaps = func {

  fcs_auto_flap_lock = getprop("/autopilot/FCS/locks/auto-flaps");
  fcs_flaps_extend_mach = getprop("/autopilot/FCS/settings/flaps-extend-mach");
  fcs_flaps_extend_factor = getprop("/autopilot/FCS/settings/flaps-extend-factor");
  mach = getprop("/velocities/mach");

  if(fcs_auto_flap_lock == "engaged") {
    if(mach < fcs_flaps_extend_mach) {
      fcs_flaperon_flap_norm = fcs_flaps_extend_factor * (fcs_flaps_extend_mach - mach);
      if(fcs_flaperon_flap_norm > 1) {
        setprop("/autopilot/FCS/controls/flaperon-flap-norm", 1);
      } else {
        setprop("/autopilot/FCS/controls/flaperon-flap-norm", fcs_flaperon_flap_norm);
      }
    } else {
      setprop("/autopilot/FCS/controls/flaperon-flap-norm", 0);
    }
  }
}
#--------------------------------------------------------------------

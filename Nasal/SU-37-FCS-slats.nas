# FCS slats handlers.
#--------------------------------------------------------------------
initialise = func {
  settimer(slats, 0.1);
}
#--------------------------------------------------------------------
slats = func {
  # Slats functions

  fcs_auto_slats_lock = getprop("/autopilot/FCS/locks/auto-slats");
  fcs_slats_extend_mach = getprop("/autopilot/FCS/settings/slats-extend-mach");
  fcs_slats_extend_factor = getprop("/autopilot/FCS/settings/slats-extend-factor");
  mach = getprop("/velocities/mach");
  slats_input = getprop("/controls/flight/slats");

  if(fcs_auto_slats_lock == "engaged") {
    if(mach < fcs_slats_extend_mach) {
      fcs_slats_norm = fcs_slats_extend_factor * (fcs_slats_extend_mach - mach);
      if(fcs_slats_norm < 0) {
        fcs_slats_norm = 0;
      } elsif(fcs_slats_norm > 1) {
        fcs_slats_norm = 1;
      }
    } else {
      fcs_slats_norm = 0;
    }
  } else {
    fcs_slats_norm = slats_input;
  }
  setprop("/autopilot/FCS/controls/slats-norm", fcs_slats_norm);
  settimer(slats, 0.1);
}
#--------------------------------------------------------------------

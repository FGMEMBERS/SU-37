# FCS slats handlers.
#--------------------------------------------------------------------
initialise = func {
  settimer(canards, 4);
}
#--------------------------------------------------------------------
canards = func {
  # Canards functions,
  # Purely eye-candy as I can't get the YASim incidence control to
  # work

  aoa_deg = getprop("/orientation/alpha-deg");
  fcs_canard_incidence_deg = getprop("/autopilot/FCS/controls/canard-incidence-deg");
  
  if(aoa_deg < 10) {
    if(aoa_deg > -70) {
      fcs_canard_incidence_deg = -1 * aoa_deg;
    }
  }
  setprop("/autopilot/FCS/controls/canard-incidence-deg", fcs_canard_incidence_deg);
  settimer(canards, 0.1);
}
#--------------------------------------------------------------------

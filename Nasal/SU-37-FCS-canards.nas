# FCS canards handlers.
#--------------------------------------------------------------------
initialise = func {
  setlistener("/autopilot/FCS/inputs/alpha-deg-filtered", canards);
}
#--------------------------------------------------------------------
canards = func {
  # Canards functions.
  # Purely eye-candy as I can't get the YASim incidence control to
  # work

  aoa_deg = cmdarg().getValue();
  fcs_canard_incidence_deg = props.globals.getNode("/autopilot/FCS/controls/canard-incidence-deg", 1);

  if(aoa_deg > -10.0) {
    if(aoa_deg < 70.0) {
      fcs_canard_incidence_deg.setDoubleValue((-1 * aoa_deg));
    }
  }
}
#--------------------------------------------------------------------

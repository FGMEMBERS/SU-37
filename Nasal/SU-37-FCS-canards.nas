# FCS canards handlers.
#--------------------------------------------------------------------
# Globals
fcs_canard_incidence_deg = props.globals.getNode("/autopilot/FCS/controls/canard-incidence-deg", 1);
aoa_deg = props.globals.getNode("/orientation/alpha-deg", 1);
#--------------------------------------------------------------------
# Functions
#--------------------------------------------------------------------
initialise = func {
  settimer(canards, 0.2);
}
#--------------------------------------------------------------------
canards = func {
  # Canards functions.
  # Purely eye-candy as I can't get the YASim incidence control to
  # work

  ad = aoa_deg.getValue();

  if(ad > -10.0) {
    if(ad < 70.0) {
      fcs_canard_incidence_deg.setDoubleValue((-1 * ad));
    }
  }
  settimer(canards, 0.2);
}
#--------------------------------------------------------------------

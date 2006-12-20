# FCS AEI animation handler.
#--------------------------------------------------------------------
# Globals.
fcs_aei_open_aoa_deg = props.globals.getNode("/autopilot/FCS/settings/aei-open-aoa-deg", 1);
fcs_aei_open_aoa_factor = props.globals.getNode("/autopilot/FCS/settings/aei-open-aoa-factor", 1);
fcs_aei_open_min_agl_ft = props.globals.getNode("/autopilot/FCS/settings/aei-open-min-agl-ft", 1);
fcs_aei_norm0 = props.globals.getNode("/autopilot/FCS/controls/engines/engine[0]/aei-norm", 1);
fcs_aei_norm1 = props.globals.getNode("/autopilot/FCS/controls/engines/engine[1]/aei-norm", 1);
altitude_agl_ft = props.globals.getNode("/position/altitude-agl-ft", 1);
aoa_deg = props.globals.getNode("/orientation/alpha-deg", 1);
#--------------------------------------------------------------------
# Functions
#--------------------------------------------------------------------
initialise = func {
  settimer(aei_doors, 0.2);
}
#--------------------------------------------------------------------
aei_doors = func {
  # Auxilary Engine Intake animation.
  # This animation script has no effect upon the aerodynamic
  # behaviour.

  ad = aoa_deg.getValue();

  if(ad > fcs_aei_open_aoa_deg.getValue()) {
    if(altitude_agl_ft.getValue() > fcs_aei_open_min_agl_ft.getValue()) {
      fcs_aei_norm = fcs_aei_open_aoa_factor.getValue() * (ad - fcs_aei_open_aoa_deg.getValue());
      if(fcs_aei_norm > 1) {
        fcs_aei_norm = 1;
      }
    } else {
      fcs_aei_norm = 0;
    }
  } else {
    fcs_aei_norm = 0;
  }
  fcs_aei_norm0.setDoubleValue(fcs_aei_norm);
  fcs_aei_norm1.setDoubleValue(fcs_aei_norm);

  settimer(aei_doors, 0.2);
}
#--------------------------------------------------------------------

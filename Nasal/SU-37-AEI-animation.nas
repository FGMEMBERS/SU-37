# FCS AEI animation handler.
#--------------------------------------------------------------------
initialise = func {
  setlistener("/autopilot/FCS/inputs/alpha-deg-filtered", aei_doors);
}
#--------------------------------------------------------------------
aei_doors = func {
  # Auxilary Engine Intake animation.
  # This animation script has no effect upon the aerodynamic
  # behaviour.

  fcs_aei_open_aoa_deg = props.globals.getNode("/autopilot/FCS/settings/aei-open-aoa-deg");
  fcs_aei_open_aoa_factor = props.globals.getNode("/autopilot/FCS/settings/aei-open-aoa-factor");
  fcs_aei_open_min_agl_ft = props.globals.getNode("/autopilot/FCS/settings/aei-open-min-agl-ft");
  fcs_aei_norm0 = props.globals.getNode("/autopilot/FCS/controls/engines/engine[0]/aei-norm");
  fcs_aei_norm1 = props.globals.getNode("/autopilot/FCS/controls/engines/engine[1]/aei-norm");

  altitude_agl_ft = props.globals.getNode("/position/altitude-agl-ft");

  aoa_deg = cmdarg().getValue();

  if(aoa_deg > fcs_aei_open_aoa_deg.getValue()) {
    if(altitude_agl_ft.getValue() > fcs_aei_open_min_agl_ft.getValue()) {
      fcs_aei_norm = fcs_aei_open_aoa_factor.getValue() * (aoa_deg - fcs_aei_open_aoa_deg.getValue());
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
}
#--------------------------------------------------------------------

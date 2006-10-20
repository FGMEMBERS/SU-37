# FCS AEI animation handler.
#--------------------------------------------------------------------
initialise = func {
  settimer(aei_doors, 4);
}
#--------------------------------------------------------------------
aei_doors = func {
  # Auxilary Engine Intake animation.
  # This animation script has no effect upon the aerodynamic
  # behaviour.

  fcs_aei_open_aoa_deg = getprop("/autopilot/FCS/settings/aei-open-aoa-deg");
  fcs_aei_open_aoa_factor = getprop("/autopilot/FCS/settings/aei-open-aoa-factor");
  fcs_aei_open_min_agl_ft = getprop("/autopilot/FCS/settings/aei-open-min-agl-ft");

  altitude_agl_ft = getprop("/position/altitude-agl-ft");
  aoa_deg = getprop("/orientation/alpha-deg");

  if(altitude_agl_ft > fcs_aei_open_min_agl_ft) {
    if(aoa_deg > fcs_aei_open_aoa_deg) {
      fcs_aei_norm = fcs_aei_open_aoa_factor * (aoa_deg - fcs_aei_open_aoa_deg);
      if(fcs_aei_norm > 1) {
        fcs_aei_norm = 1;
      }
    } else {
      fcs_aei_norm = 0;
    }
  } else {
    fcs_aei_norm = 0;
  }
  setprop("/autopilot/FCS/controls/engines/engine[0]/aei-norm", fcs_aei_norm);
  setprop("/autopilot/FCS/controls/engines/engine[1]/aei-norm", fcs_aei_norm);
  settimer(aei_doors, 0.1);
}
#--------------------------------------------------------------------

# FCS Flaps handler
#--------------------------------------------------------------------
# Globals
fcs_auto_flaps_lock = props.globals.getNode("/autopilot/FCS/locks/auto-flaps", 1);
fcs_flaps_extend_mach = props.globals.getNode("/autopilot/FCS/settings/flaps-extend-mach", 1);
fcs_flaps_extend_factor = props.globals.getNode("/autopilot/FCS/settings/flaps-extend-factor", 1);
fcs_flaperon_flaps_norm = props.globals.getNode("/autopilot/FCS/controls/flaperon-flaps-norm", 1);
raw_flaps_input = props.globals.getNode("/controls/flight/flaps", 1);
#--------------------------------------------------------------------
# Functions
#--------------------------------------------------------------------
initialise = func {
  setlistener("/autopilot/FCS/internal/mach-filtered", flaperon_flaps);
}
#--------------------------------------------------------------------
flaperon_flaps = func {
  # Monitor mach and extend the flaps if in auto-flap mode.  If not in auto-flap mode
  # apply the raw flap input

  mach = cmdarg().getValue();

  if(fcs_auto_flaps_lock.getValue() == "engaged") {
    if(mach < fcs_flaps_extend_mach.getValue()) {
      fffn = fcs_flaps_extend_factor.getValue() * (fcs_flaps_extend_mach.getValue() - mach);
      if(fffn > 1) {
        fcs_flaperon_flaps_norm.setDoubleValue(1);
      } else {
        fcs_flaperon_flaps_norm.setDoubleValue(fffn);
      }
    } else {
      fcs_flaperon_flaps_norm.setDoubleValue(0);
    }
  } else {
    fcs_flaperon_flaps_norm.setDoubleValue(raw_flaps_input.getValue());
  }
}
#--------------------------------------------------------------------

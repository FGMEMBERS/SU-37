# FCS slats handlers.
#--------------------------------------------------------------------
# Globals
fcs_auto_slats_lock = props.globals.getNode("/autopilot/FCS/locks/auto-slats", 1);
fcs_slats_extend_mach = props.globals.getNode("/autopilot/FCS/settings/slats-extend-mach", 1);
fcs_slats_extend_factor = props.globals.getNode("/autopilot/FCS/settings/slats-extend-factor", 1);
fcs_slats_norm = props.globals.getNode("/autopilot/FCS/controls/slats-norm", 1);
raw_slats_input = props.globals.getNode("/controls/flight/slats", 1);
#--------------------------------------------------------------------
# Functions
#--------------------------------------------------------------------
initialise = func {
  setlistener("/autopilot/FCS/internal/mach-filtered", slats);
}
#--------------------------------------------------------------------
slats = func {
  # Monitor mach and extend the slats if in auto-flap mode.  If not in auto-slats mode
  # apply the raw slats input

  mach = cmdarg().getValue();

  if(fcs_auto_slats_lock.getValue() == "engaged") {
    if(mach < fcs_slats_extend_mach.getValue()) {
      fsn = fcs_slats_extend_factor.getValue() * (fcs_slats_extend_mach.getValue() - mach);
      if(fsn > 1) {
        fcs_slats_norm.setDoubleValue(1);
      } else {
        fcs_slats_norm.setDoubleValue(fsn);
      }
    } else {
      fcs_slats_norm.setDoubleValue(0);
    }
  } else {
    fcs_slats_norm.setDoubleValue(raw_slats_input.getValue());
  }
}
#--------------------------------------------------------------------

# FCS Stick mode handlers
#--------------------------------------------------------------------
# Globals
fcs_pitch_lock = props.globals.getNode("/autopilot/FCS/locks/pitch");
fcs_vfps_lock = props.globals.getNode("/autopilot/FCS/locks/vfps");
fcs_roll_lock = props.globals.getNode("/autopilot/FCS/locks/roll");
ap_altitude_lock = props.globals.getNode("/autopilot/locks/altitude");
ap_heading_lock = props.globals.getNode("/autopilot/locks/heading");
#--------------------------------------------------------------------
# Functions
#--------------------------------------------------------------------
initialise = func {
  setlistener("/autopilot/FCS/modes/stick", fcs_stick_mode_monitor);
}
#--------------------------------------------------------------------
fcs_stick_mode_monitor = func {
  # Monitor the FCS stick mode and set/clear appropriate locks.

  fcs_stick_mode = cmdarg().getValue();

  if(fcs_stick_mode == "direct") {
    ap_altitude_lock.setValue("");
    ap_heading_lock.setValue("");
    fcs_pitch_lock.setValue("off");
    fcs_vfps_lock.setValue("off");
    fcs_roll_lock.setValue("off");
  } elsif(fcs_stick_mode == "pitch") {
    fcs_pitch_lock.setValue("engaged");
    fcs_vfps_lock.setValue("off");
    fcs_roll_lock.setValue("engaged");
  } elsif(fcs_stick_mode == "vfps") {
    fcs_pitch_lock.setValue("engaged");
    fcs_vfps_lock.setValue("engaged");
    fcs_roll_lock.setValue("engaged");
  }
}
#--------------------------------------------------------------------

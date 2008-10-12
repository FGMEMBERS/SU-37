# FCS Stick mode handlers
#--------------------------------------------------------------------
# Globals
fcs_pitch_lock = props.globals.getNode("/autopilot/FCS/locks/pitch", 1);
fcs_vfps_lock = props.globals.getNode("/autopilot/FCS/locks/vfps", 1);
fcs_roll_lock = props.globals.getNode("/autopilot/FCS/locks/roll", 1);
#fcs_stick_mode = props.globals.getNode("/autopilot/FCS/modes/stick", 1);
ap_altitude_lock = props.globals.getNode("/autopilot/locks/altitude", 1);
ap_heading_lock = props.globals.getNode("/autopilot/locks/heading", 1);
#--------------------------------------------------------------------
# Functions
#--------------------------------------------------------------------
initialise = func {
#  settimer(fcs_stick_mode_monitor, 0.2);
  setlistener("/autopilot/FCS/modes/stick", fcs_stick_mode);
}
#--------------------------------------------------------------------
fcs_stick_mode = func(n) {
  # Monitor the FCS stick mode and set/clear appropriate locks.

  fcs_stick_mode = n.getValue();

  if(fcs_stick_mode == "direct") {
    ap_altitude_lock.setValue("");
    ap_heading_lock.setValue("");
    fcs_pitch_lock.setValue("off");
    fcs_vfps_lock.setValue("off");
    fcs_roll_lock.setValue("off");
  } elsif(fcs_stick_mode == "pitch") {
    ap_altitude_lock.setValue("");
    ap_heading_lock.setValue("");
    fcs_pitch_lock.setValue("engaged");
    fcs_vfps_lock.setValue("off");
    fcs_roll_lock.setValue("engaged");
  } elsif(fcs_stick_mode == "vfps") {
    ap_altitude_lock.setValue("");
    ap_heading_lock.setValue("");
    fcs_pitch_lock.setValue("engaged");
    fcs_vfps_lock.setValue("engaged");
    fcs_roll_lock.setValue("engaged");
  }
#  settimer(fcs_stick_mode_monitor, 0.2);
}
#--------------------------------------------------------------------

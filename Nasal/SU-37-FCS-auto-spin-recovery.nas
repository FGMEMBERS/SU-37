# FCS auto spin recovery handlers.
#--------------------------------------------------------------------
# Globals
roll_deg = props.globals.getNode("/orientation/roll-deg", 1);
yaw_rate_degps = props.globals.getNode("/orientation/yaw-rate-degps", 1);
ap_altitude_lock = props.globals.getNode("/autopilot/locks/altitude", 1);
ap_heading_lock = props.globals.getNode("/autopilot/locks/heading", 1);
ap_speed_lock = props.globals.getNode("/autopilot/locks/speed", 1);
ap_target_vfps = props.globals.getNode("/autopilot/settings/target-climb-rate-fps", 1);
ctrl_aileron = props.globals.getNode("/controls/flight/aileron", 1);
ctrl_elevator = props.globals.getNode("/controls/flight/elevator", 1);
ctrl_rudder = props.globals.getNode("/controls/flight/rudder", 1);
ctrl_throttle0 = props.globals.getNode("/controls/engines/engine[0]/throttle", 1);
ctrl_throttle1 = props.globals.getNode("/controls/engines/engine[1]/throttle", 1);
ctrl_reheat0 = props.globals.getNode("/controls/engines/engine[0]/reheat", 1);
ctrl_reheat1 = props.globals.getNode("/controls/engines/engine[1]/reheat", 1);
fcs_auto_spin_recovery_lock = props.globals.getNode("/autopilot/FCS/locks/auto-spin-recovery", 1);
fcs_stick_mode = props.globals.getNode("/autopilot/FCS/modes/stick", 1);
#--------------------------------------------------------------------
# Functions
#--------------------------------------------------------------------
initialise = func {
  settimer(FCS_auto_spin_recovery, 0.2);
}
#--------------------------------------------------------------------
FCS_auto_spin_recovery = func {

  if(fcs_auto_spin_recovery_lock.getValue() == "enabled") {
    if(yaw_rate_degps.getValue() > 40.0) {
      FCS_spr00();
    } elsif(yaw_rate_degps.getValue() < -40) {
      FCS_spr00();
    }
  }
  settimer(FCS_auto_spin_recovery, 0.2);
}
#--------------------------------------------------------------------
FCS_spr00 = func {
  fcs_auto_spin_recovery_lock.setValue("engaged");
  fcs_stick_mode.setValue("direct");

  ap_speed_lock.setValue("");
  ctrl_aileron.setValue(0.0);
  ctrl_elevator.setValue(0.0);
  ctrl_rudder.setValue(0.0);
  ctrl_throttle0.setValue(1.0);
  ctrl_throttle1.setValue(1.0);
  ctrl_reheat0.setValue(1.0);
  ctrl_reheat1.setValue(1.0);

  if(yaw_rate_degps.getValue() > 3) {
    settimer(FCS_spr00, 0.2);
  } elsif(yaw_rate_degps.getValue() < -3) {
    settimer(FCS_spr00, 0.2);
  } else {
    settimer(FCS_spr01, 2);
  }
}
#--------------------------------------------------------------------
FCS_spr01 = func {
  # ASR is a null value for FCS stick mode but it stops the FCS stick
  # mode listener from chaning the FCS locks, which are overridden
  # during ASR.
  ctrl_reheat0.setValue(0.0);
  ctrl_reheat1.setValue(0.0);
  ctrl_elevator.setValue(-0.1);
  fcs_stick_mode.setValue("ASR");
  ap_heading_lock.setValue("auto-spin-recovery");
  ap_speed_lock.setValue("speed-with-throttle");

  if(roll_deg.getValue() > 10) {
    settimer(FCS_spr01, 0.2);
  } elsif(roll_deg.getValue() < -10) {
    settimer(FCS_spr01, 0.2);
  } else {
    settimer(FCS_spr02, 2);
    settimer(FCS_spr03, 6);
  }
}
#--------------------------------------------------------------------
FCS_spr02 = func {
  ap_altitude_lock.setValue("auto-spin-recovery");
}
#--------------------------------------------------------------------
FCS_spr03 = func {
  ap_heading_lock.setValue("wing-leveler");
  ap_altitude_lock.setValue("vfps-hold");
  fcs_auto_spin_recovery_lock.setValue("enabled");
}
#--------------------------------------------------------------------

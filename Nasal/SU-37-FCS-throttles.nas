# FCS Throttles.
#
# When auto-reheat is off: pass-through throttle and reheat inputs.
# When auto-reheat is engaged: throttle range 0-reheat-threshold
# controls the throttle and throttle range reheat-threshold-1
# controls reheat.
#--------------------------------------------------------------------
# Globals
throttle0 = props.globals.getNode("/controls/engines/engine[0]/throttle", 1);
throttle1 = props.globals.getNode("/controls/engines/engine[1]/throttle", 1);
reheat0 = props.globals.getNode("/controls/engines/engine[0]/reheat", 1);
reheat1 = props.globals.getNode("/controls/engines/engine[1]/reheat", 1);
fcs_auto_reheat_lock = props.globals.getNode("/autopilot/FCS/locks/auto-reheat", 1);
fcs_auto_reheat_threshold = props.globals.getNode("/autopilot/FCS/settings/auto-reheat-threshold", 1);
fcs_throttle0_norm = props.globals.getNode("/autopilot/FCS/controls/engines/engine[0]/throttle-norm", 1);
fcs_throttle1_norm = props.globals.getNode("/autopilot/FCS/controls/engines/engine[1]/throttle-norm", 1);
fcs_reheat0_norm = props.globals.getNode("/autopilot/FCS/controls/engines/engine[0]/reheat-norm", 1);
fcs_reheat1_norm = props.globals.getNode("/autopilot/FCS/controls/engines/engine[1]/reheat-norm", 1);
n2_0 = props.globals.getNode("/engines/engine[0]/n2", 1);
n2_1 = props.globals.getNode("/engines/engine[1]/n2", 1);
#--------------------------------------------------------------------
# Functions
#--------------------------------------------------------------------
initialise = func {
  settimer(throttle0_monitor, 0.2);
  settimer(throttle1_monitor, 0.2);
  settimer(reheat0_monitor, 0.2);
  settimer(reheat1_monitor, 0.2);
}
#--------------------------------------------------------------------
throttle0_monitor = func {
  if(fcs_auto_reheat_lock.getValue() != "engaged") {
    # Auto reheat not engaged.
    fcs_throttle0_norm.setValue(throttle0.getValue());
  } else {
    # Auto reheat engaged.
    fcs_throttle_factor = 1 / fcs_auto_reheat_threshold.getValue();
    fcs_throttle0_norm.setValue(throttle0.getValue() * fcs_throttle_factor);
    if(n2_0.getValue() > 98) {
      # Wait until nozzle dilated before engaging reheat.
      if(throttle0.getValue() > fcs_auto_reheat_threshold.getValue()) {
        fcs_reheat_factor = 1 / (1 - fcs_auto_reheat_threshold.getValue());
        fcs_reheat0_norm.setValue((throttle0.getValue() - fcs_auto_reheat_threshold.getValue()) * fcs_reheat_factor);
      }
    } else {
      fcs_reheat0_norm.setValue(0);
    }
  }
  settimer(throttle0_monitor, 0.2);
}
#--------------------------------------------------------------------
throttle1_monitor = func {
  if(fcs_auto_reheat_lock.getValue() != "engaged") {
    # Auto reheat not engaged.
    fcs_throttle1_norm.setValue(throttle1.getValue());
  } else {
    # Auto reheat engaged.
    fcs_throttle_factor = 1 / fcs_auto_reheat_threshold.getValue();
    fcs_throttle1_norm.setValue(throttle1.getValue() * fcs_throttle_factor);
    if(n2_1.getValue() > 98) {
      # Wait until nozzle dilated before engaging reheat.
      if(throttle1.getValue() > fcs_auto_reheat_threshold.getValue()) {
        fcs_reheat_factor = 1 / (1 - fcs_auto_reheat_threshold.getValue());
        fcs_reheat1_norm.setValue((throttle1.getValue() - fcs_auto_reheat_threshold.getValue()) * fcs_reheat_factor);
      }
    } else {
      fcs_reheat1_norm.setValue(0);
    }
  }
  settimer(throttle1_monitor, 0.2);
}
#--------------------------------------------------------------------
reheat0_monitor = func {
  if(fcs_auto_reheat_lock.getValue() != "engaged") {
    fcs_reheat0_norm.setValue(reheat0.getValue());
  }
  settimer(reheat0_monitor, 0.2);
}
#--------------------------------------------------------------------
reheat1_monitor = func {
  if(fcs_auto_reheat_lock.getValue() != "engaged") {
    fcs_reheat1_norm.setValue(reheat1.getValue());
  }
  settimer(reheat1_monitor, 0.2);
}
#--------------------------------------------------------------------

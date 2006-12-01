# FCS Throttles.
#
# When auto-reheat is off: pass-through throttle and reheat inputs.
# When auto-reheat is engaged: throttle range 0-0.9 controls the 
# throttle and throttle range 0.9-1 controls reheat.
#--------------------------------------------------------------------
# Globals
#--------------------------------------------------------------------
# Functions
#--------------------------------------------------------------------
initialise = func {
  setprop("/engines/engine[0]/n2", 0.0);
  setprop("/engines/engine[1]/n2", 0.0);
  settimer(throttle_left, 0.2);
  settimer(throttle_right, 0.2);
}
#--------------------------------------------------------------------
throttle_left = func {
  # Monitor throttle inputs

  fcs_auto_reheat_lock = getprop("/autopilot/FCS/locks/auto-reheat");
  fcs_auto_reheat_threshold = getprop("/autopilot/FCS/settings/auto-reheat-threshold");
  throttle_input = getprop("/controls/engines/engine[0]/throttle");
  reheat_input = getprop("/controls/engines/engine[0]/reheat");
  n2 = getprop("/engines/engine[0]/n2");

  if(fcs_auto_reheat_lock == "engaged") {
    fcs_throttle_factor = 1 / fcs_auto_reheat_threshold;
    fcs_throttle_norm = throttle_input * fcs_throttle_factor;

    fcs_reheat_factor = 1 / (1 - fcs_auto_reheat_threshold);
    fcs_reheat_norm = (throttle_input - fcs_auto_reheat_threshold) * fcs_reheat_factor;

    if(fcs_throttle_norm < 0) {
      fcs_throttle_norm = 0;
    } elsif(fcs_throttle_norm > 1) {
      fcs_throttle_norm = 1;
    }

    if(fcs_reheat_norm < 0) {
      fcs_reheat_norm = 0;
    } elsif(fcs_reheat_norm > 1) {
      fcs_reheat_norm = 1;
    }

  } else {
    fcs_throttle_norm = throttle_input;
    fcs_reheat_norm = reheat_input;
  }
  setprop("/autopilot/FCS/controls/engines/engine[0]/throttle-norm", fcs_throttle_norm);
  if(n2 > 99) {
    setprop("/autopilot/FCS/controls/engines/engine[0]/reheat-norm", fcs_reheat_norm);
  }
  settimer(throttle_left, 0.2);
}
#--------------------------------------------------------------------
throttle_right = func {
  # Monitor throttle inputs

  fcs_auto_reheat_lock = getprop("/autopilot/FCS/locks/auto-reheat");
  fcs_auto_reheat_threshold = getprop("/autopilot/FCS/settings/auto-reheat-threshold");
  throttle_input = getprop("/controls/engines/engine[1]/throttle");
  reheat_input = getprop("/controls/engines/engine[1]/reheat");
  n2 = getprop("/engines/engine[1]/n2");

  if(fcs_auto_reheat_lock == "engaged") {
    fcs_throttle_factor = 1 / fcs_auto_reheat_threshold;
    fcs_throttle_norm = throttle_input * fcs_throttle_factor;

    fcs_reheat_factor = 1 / (1 - fcs_auto_reheat_threshold);
    fcs_reheat_norm = (throttle_input - fcs_auto_reheat_threshold) * fcs_reheat_factor;

    if(fcs_throttle_norm < 0) {
      fcs_throttle_norm = 0;
    } elsif(fcs_throttle_norm > 1) {
      fcs_throttle_norm = 1;
    }

    if(fcs_reheat_norm < 0) {
      fcs_reheat_norm = 0;
    } elsif(fcs_reheat_norm > 1) {
      fcs_reheat_norm = 1;
    }

  } else {
    fcs_throttle_norm = throttle_input;
    fcs_reheat_norm = reheat_input;
  }
  setprop("/autopilot/FCS/controls/engines/engine[1]/throttle-norm", fcs_throttle_norm);
  if(n2 > 99) {
    setprop("/autopilot/FCS/controls/engines/engine[1]/reheat-norm", fcs_reheat_norm);
  }
  settimer(throttle_right, 0.2);
}
#--------------------------------------------------------------------

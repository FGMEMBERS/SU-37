# FCS slave listeners
#--------------------------------------------------------------------
initialise = func {
  setlistener("/autopilot/FCS/controls/elevon-roll-norm", flaperon_roll);
  setlistener("/autopilot/FCS/internal/left-elevon-pos-norm-filtered", vector_left);
  setlistener("/autopilot/FCS/internal/right-elevon-pos-norm-filtered", vector_right);
}
#--------------------------------------------------------------------
flaperon_roll = func {
  # Slaves the flaperon roll to the elevon roll when no flap extened.

  fcs_flaperon_flap_norm = getprop("/autopilot/FCS/controls/flaperon-flap-norm");
  fcs_elevon_roll_norm = getprop("/autopilot/FCS/controls/elevon-roll-norm");

  if(fcs_flaperon_flap_norm == 0) {
    setprop("/autopilot/FCS/controls/flaperon-roll-norm", fcs_elevon_roll_norm);
  } else {
    setprop("/autopilot/FCS/controls/flaperon-roll-norm", 0);
  }
}
#--------------------------------------------------------------------
vector_left = func {
  # Slaves the left engine vectoring to the left elevon-pos-norm.
  # Note that the scaling is applied in YASim.

  left_elevon_pos_norm = getprop("/surface-positions/left-elevon-pos-norm");

  setprop("/autopilot/FCS/controls/engines/engine[0]/vector-norm", left_elevon_pos_norm);
}
#--------------------------------------------------------------------
vector_right = func {
  # Slaves the Right engine vectoring to the right elevon-pos-norm.
  # Note that the scaling is applied in YASim.

  right_elevon_pos_norm = getprop("/surface-positions/right-elevon-pos-norm");

  setprop("/autopilot/FCS/controls/engines/engine[1]/vector-norm", right_elevon_pos_norm);
}
#--------------------------------------------------------------------

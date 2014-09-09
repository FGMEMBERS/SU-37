# FCS thrust vectoring handler
#--------------------------------------------------------------------
# Globals
eng0_vector_norm = props.globals.getNode("/autopilot/FCS/controls/engines/engine[0]/vector-norm", 1);
eng1_vector_norm = props.globals.getNode("/autopilot/FCS/controls/engines/engine[1]/vector-norm", 1);
left_elevon_pos_norm = props.globals.getNode("/surface-positions/left-elevon-pos-norm", 1);
right_elevon_pos_norm = props.globals.getNode("/surface-positions/right-elevon-pos-norm", 1);
#--------------------------------------------------------------------
# Functions
#--------------------------------------------------------------------
initialise = func {
  eng0_vector_norm.setDoubleValue(0);
  eng1_vector_norm.setDoubleValue(0);
  eng0_vector_norm.setDoubleValue(0);
  eng1_vector_norm.setDoubleValue(0);
  settimer(vector_left, 5);
  settimer(vector_right, 5);
}
#--------------------------------------------------------------------
vector_left = func {
  # Slaves the left engine vectoring to the left elevon-pos-norm.
  # Note that the scaling is applied in YASim.

  eng0_vector_norm.setDoubleValue(left_elevon_pos_norm.getValue());

  settimer(vector_left, 0.1);
}
#--------------------------------------------------------------------
vector_right = func {
  # Slaves the Right engine vectoring to the right elevon-pos-norm.
  # Note that the scaling is applied in YASim.

  eng1_vector_norm.setDoubleValue(right_elevon_pos_norm.getValue());

  settimer(vector_right, 0.1);
}
#--------------------------------------------------------------------

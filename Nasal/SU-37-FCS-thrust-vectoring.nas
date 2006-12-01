# FCS thrust vectoring handler
#--------------------------------------------------------------------
# Globals
eng0_vector_norm = props.globals.getNode("/autopilot/FCS/controls/engines/engine[0]/vector-norm", 1);
eng1_vector_norm = props.globals.getNode("/autopilot/FCS/controls/engines/engine[1]/vector-norm", 1);
#--------------------------------------------------------------------
# Functions
#--------------------------------------------------------------------
initialise = func {
  setlistener("/autopilot/FCS/internal/left-elevon-pos-norm-filtered", vector_left);
  setlistener("/autopilot/FCS/internal/right-elevon-pos-norm-filtered", vector_right);
}
#--------------------------------------------------------------------
vector_left = func {
  # Slaves the left engine vectoring to the left elevon-pos-norm.
  # Note that the scaling is applied in YASim.

  eng0_vector_norm.setDoubleValue(cmdarg().getValue());
}
#--------------------------------------------------------------------
vector_right = func {
  # Slaves the Right engine vectoring to the right elevon-pos-norm.
  # Note that the scaling is applied in YASim.

  eng1_vector_norm.setDoubleValue(cmdarg().getValue());
}
#--------------------------------------------------------------------

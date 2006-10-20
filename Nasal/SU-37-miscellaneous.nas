# Miscellaneous functions
#--------------------------------------------------------------------
toggle_traj_mkr = func {
  if(getprop("ai/submodels/trajectory-markers") < 1) {
    setprop("ai/submodels/trajectory-markers", 1);
  } else {
    setprop("ai/submodels/trajectory-markers", 0);
  }
}
#--------------------------------------------------------------------
update_drop_view_pos = func {
  eyelatdeg = getprop("/position/latitude-deg");
  eyelondeg = getprop("/position/longitude-deg");
  eyealtft = getprop("/position/altitude-ft") + 20;
  interpolate("/sim/view[7]/latitude-deg", eyelatdeg, 5);
  interpolate("/sim/view[7]/longitude-deg", eyelondeg, 5);
  interpolate("/sim/view[7]/altitude-ft", eyealtft, 5);
}
#--------------------------------------------------------------------

altitude_hold_off = func {

  ap_altitude_mode = getprop("/autopilot/locks/altitude");

  if(ap_altitude_mode != "") {
    setprop("/autopilot/locks/altitude", "");
  }
}
#--------------------------------------------------------------------
toggle_altitude_hold = func {

  ap_altitude_mode = getprop("/autopilot/locks/altitude");

  if(ap_altitude_mode == "altitude-hold") {
    setprop("/autopilot/locks/altitude", "");
  } else {
    setprop("/autopilot/locks/altitude", "altitude-hold");
  }
}
#--------------------------------------------------------------------
toggle_agl_hold = func {

  ap_altitude_mode = getprop("/autopilot/locks/altitude");

  if(ap_altitude_mode == "agl-hold") {
    setprop("/autopilot/locks/altitude", "");
  } else {
    setprop("/autopilot/locks/altitude", "agl-hold");
  }
}
#--------------------------------------------------------------------
toggle_pitch_hold = func {

  ap_altitude_mode = getprop("/autopilot/locks/altitude");

  if(ap_altitude_mode == "pitch-hold") {
    setprop("/autopilot/locks/altitude", "");
  } else {
    setprop("/autopilot/locks/altitude", "pitch-hold");
  }
}
#--------------------------------------------------------------------
toggle_aoa_hold = func {

  ap_altitude_mode = getprop("/autopilot/locks/altitude");

  if(ap_altitude_mode == "aoa-hold") {
    setprop("/autopilot/locks/altitude", "");
  } else {
    setprop("/autopilot/locks/altitude", "aoa-hold");
  }
}
#--------------------------------------------------------------------
toggle_vfps_hold = func {

  ap_altitude_mode = getprop("/autopilot/locks/altitude");

  if(ap_altitude_mode == "vfps-hold") {
    setprop("/autopilot/locks/altitude", "");
  } else {
    setprop("/autopilot/locks/altitude", "vfps-hold");
  }
}
#--------------------------------------------------------------------
toggle_gs1_hold = func {

  ap_altitude_mode = getprop("/autopilot/locks/altitude");

  if(ap_altitude_mode == "gs1-hold") {
    setprop("/autopilot/locks/altitude", "");
  } else {
    setprop("/autopilot/locks/altitude", "gs1-hold");
  }
}
#--------------------------------------------------------------------
toggle_mc_hold = func {

  ap_altitude_mode = getprop("/autopilot/locks/altitude");

  if(ap_altitude_mode == "mach-climb") {
    setprop("/autopilot/locks/altitude", "");
  } else {
    setprop("/autopilot/locks/altitude", "mach-climb");
  }
}
#--------------------------------------------------------------------
heading_hold_off = func {

  ap_heading_mode = getprop("/autopilot/locks/heading");

  if(ap_heading_mode != "") {
    setprop("/autopilot/locks/heading", "");
  }
}
#--------------------------------------------------------------------
toggle_wing_leveler = func {

  ap_heading_mode = getprop("/autopilot/locks/heading");

  if(ap_heading_mode == "wing-leveler") {
    setprop("/autopilot/locks/heading", "");
  } else {
    setprop("/autopilot/locks/heading", "wing-leveler");
  }
}
#--------------------------------------------------------------------
toggle_true_heading_hold = func {

  ap_heading_mode = getprop("/autopilot/locks/heading");

  if(ap_heading_mode == "true-heading-hold") {
    setprop("/autopilot/locks/heading", "");
  } else {
    setprop("/autopilot/locks/heading", "true-heading-hold");
  }
}
#--------------------------------------------------------------------
toggle_dg_heading_hold = func {

  ap_heading_mode = getprop("/autopilot/locks/heading");

  if(ap_heading_mode == "dg-heading-hold") {
    setprop("/autopilot/locks/heading", "");
  } else {
    setprop("/autopilot/locks/heading", "dg-heading-hold");
  }
}
#--------------------------------------------------------------------
toggle_nav1_hold = func {

  ap_heading_mode = getprop("/autopilot/locks/heading");

  if(ap_heading_mode == "nav1-hold") {
    setprop("/autopilot/locks/heading", "");
  } else {
    setprop("/autopilot/locks/heading", "nav1-hold");
  }
}
#--------------------------------------------------------------------
set_fcs_direct_stick_mode = func {
  
  setprop("/autopilot/FCS/modes/stick", "direct");
}
#--------------------------------------------------------------------
set_fcs_pitch_stick_mode = func {
  
  setprop("/autopilot/FCS/modes/stick", "pitch");
}
#--------------------------------------------------------------------
set_fcs_vfps_stick_mode = func {
  
  setprop("/autopilot/FCS/modes/stick", "vfps");
}
#--------------------------------------------------------------------
toggle_fcs_auto_flaps = func {

  fcs_auto_flaps_lock = getprop("/autopilot/FCS/locks/auto-flaps");

  if(fcs_auto_flaps_lock == "engaged") {
    setprop("/autopilot/FCS/locks/auto-flaps", "off");
  } else {
    setprop("/autopilot/FCS/locks/auto-flaps", "engaged");
  }
}
#--------------------------------------------------------------------
toggle_fcs_auto_slats = func {

  fcs_auto_slats_lock = getprop("/autopilot/FCS/locks/auto-slats");

  if(fcs_auto_slats_lock == "engaged") {
    setprop("/autopilot/FCS/locks/auto-slats", "off");
  } else {
    setprop("/autopilot/FCS/locks/auto-slats", "engaged");
  }
}
#--------------------------------------------------------------------
toggle_fcs_auto_speedbrake = func {

  fcs_auto_speedbrake_lock = getprop("/autopilot/FCS/locks/auto-speedbrake");

  if(fcs_auto_speedbrake_lock == "engaged") {
    setprop("/autopilot/FCS/locks/auto-speedbrake", "off");
  } else {
    setprop("/autopilot/FCS/locks/auto-speedbrake", "engaged");
  }
}
#--------------------------------------------------------------------
toggle_fcs_cubed_input = func {

  fcs_cubed_input_lock = getprop("/autopilot/FCS/locks/cubed-input");

  if(fcs_cubed_input_lock == "engaged") {
    setprop("/autopilot/FCS/locks/cubed-input", "off");
  } else {
    setprop("/autopilot/FCS/locks/cubed-input", "engaged");
  }
}
#--------------------------------------------------------------------
toggle_fcs_auto_reheat = func {

  fcs_auto_reheat_lock = getprop("/autopilot/FCS/locks/auto-reheat");

  if(fcs_auto_reheat_lock == "engaged") {
    setprop("/autopilot/FCS/locks/auto-reheat", "off");
  } else {
    setprop("/autopilot/FCS/locks/auto-reheat", "engaged");
  }
}
#--------------------------------------------------------------------

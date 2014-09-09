var altitude_hold_off = func {

  var ap_altitude_mode = getprop("/autopilot/locks/altitude");

  if(ap_altitude_mode != "") {
    setprop("/autopilot/locks/altitude", "");
  }
}
#--------------------------------------------------------------------
var toggle_altitude_hold = func {

  var ap_altitude_mode = getprop("/autopilot/locks/altitude");

  if(ap_altitude_mode == "altitude-hold") {
    setprop("/autopilot/locks/altitude", "");
  } else {
    setprop("/autopilot/locks/altitude", "altitude-hold");
  }
}
#--------------------------------------------------------------------
var toggle_agl_hold = func {

  var ap_altitude_mode = getprop("/autopilot/locks/altitude");

  if(ap_altitude_mode == "agl-hold") {
    setprop("/autopilot/locks/altitude", "");
  } else {
    setprop("/autopilot/locks/altitude", "agl-hold");
  }
}
#--------------------------------------------------------------------
var toggle_pitch_hold = func {

  var ap_altitude_mode = getprop("/autopilot/locks/altitude");

  if(ap_altitude_mode == "pitch-hold") {
    setprop("/autopilot/locks/altitude", "");
  } else {
    setprop("/autopilot/locks/altitude", "pitch-hold");
  }
}
#--------------------------------------------------------------------
var toggle_aoa_hold = func {

  var ap_altitude_mode = getprop("/autopilot/locks/altitude");

  if(ap_altitude_mode == "aoa-hold") {
    setprop("/autopilot/locks/altitude", "");
  } else {
    setprop("/autopilot/locks/altitude", "aoa-hold");
  }
}
#--------------------------------------------------------------------
var toggle_vfps_hold = func {

  var ap_altitude_mode = getprop("/autopilot/locks/altitude");

  if(ap_altitude_mode == "vfps-hold") {
    setprop("/autopilot/locks/altitude", "");
  } else {
    setprop("/autopilot/locks/altitude", "vfps-hold");
  }
}
#--------------------------------------------------------------------
var toggle_gs1_hold = func {

  var ap_altitude_mode = getprop("/autopilot/locks/altitude");

  if(ap_altitude_mode == "gs1-hold") {
    setprop("/autopilot/locks/altitude", "");
  } else {
    setprop("/autopilot/locks/altitude", "gs1-hold");
  }
}
#--------------------------------------------------------------------
var toggle_mc_hold = func {

  var ap_altitude_mode = getprop("/autopilot/locks/altitude");

  if(ap_altitude_mode == "mach-climb") {
    setprop("/autopilot/locks/altitude", "");
  } else {
    setprop("/autopilot/locks/altitude", "mach-climb");
  }
}
#--------------------------------------------------------------------
var heading_hold_off = func {

  var ap_heading_mode = getprop("/autopilot/locks/heading");

  if(ap_heading_mode != "") {
    setprop("/autopilot/locks/heading", "");
  }
}
#--------------------------------------------------------------------
var toggle_wing_leveler = func {

  var ap_heading_mode = getprop("/autopilot/locks/heading");

  if(ap_heading_mode == "wing-leveler") {
    setprop("/autopilot/locks/heading", "");
  } else {
    setprop("/autopilot/locks/heading", "wing-leveler");
  }
}
#--------------------------------------------------------------------
var toggle_true_heading_hold = func {

  var ap_heading_mode = getprop("/autopilot/locks/heading");

  if(ap_heading_mode == "true-heading-hold") {
    setprop("/autopilot/locks/heading", "");
  } else {
    setprop("/autopilot/locks/heading", "true-heading-hold");
  }
}
#--------------------------------------------------------------------
var toggle_dg_heading_hold = func {

  var ap_heading_mode = getprop("/autopilot/locks/heading");

  if(ap_heading_mode == "dg-heading-hold") {
    setprop("/autopilot/locks/heading", "");
  } else {
    setprop("/autopilot/locks/heading", "dg-heading-hold");
  }
}
#--------------------------------------------------------------------
var toggle_nav1_hold = func {

  var ap_heading_mode = getprop("/autopilot/locks/heading");

  if(ap_heading_mode == "nav1-hold") {
    setprop("/autopilot/locks/heading", "");
  } else {
    setprop("/autopilot/locks/heading", "nav1-hold");
  }
}
#--------------------------------------------------------------------
var set_fcs_direct_stick_mode = func {

  setprop("/autopilot/FCS/modes/stick", "direct");
}
#--------------------------------------------------------------------
var set_fcs_pitch_stick_mode = func {

  setprop("/autopilot/FCS/modes/stick", "pitch");
}
#--------------------------------------------------------------------
var set_fcs_vfps_stick_mode = func {

  setprop("/autopilot/FCS/modes/stick", "vfps");
}
#--------------------------------------------------------------------
var toggle_fcs_auto_flaps = func {

  var fcs_auto_flaps_lock = getprop("/autopilot/FCS/locks/auto-flaps");

  if(fcs_auto_flaps_lock == "engaged") {
    setprop("/autopilot/FCS/locks/auto-flaps", "off");
  } else {
    setprop("/autopilot/FCS/locks/auto-flaps", "engaged");
  }
}
#--------------------------------------------------------------------
var toggle_fcs_auto_slats = func {

  var fcs_auto_slats_lock = getprop("/autopilot/FCS/locks/auto-slats");

  if(fcs_auto_slats_lock == "engaged") {
    setprop("/autopilot/FCS/locks/auto-slats", "off");
  } else {
    setprop("/autopilot/FCS/locks/auto-slats", "engaged");
  }
}
#--------------------------------------------------------------------
var toggle_fcs_auto_speedbrake = func {

  var fcs_auto_speedbrake_lock = getprop("/autopilot/FCS/locks/auto-speedbrake");

  if(fcs_auto_speedbrake_lock == "engaged") {
    setprop("/autopilot/FCS/locks/auto-speedbrake", "off");
  } else {
    setprop("/autopilot/FCS/locks/auto-speedbrake", "engaged");
  }
}
#--------------------------------------------------------------------
var toggle_fcs_cubed_input = func {

  var fcs_cubed_input_lock = getprop("/autopilot/FCS/locks/cubed-input");

  if(fcs_cubed_input_lock == "engaged") {
    setprop("/autopilot/FCS/locks/cubed-input", "off");
  } else {
    setprop("/autopilot/FCS/locks/cubed-input", "engaged");
  }
}
#--------------------------------------------------------------------
var toggle_fcs_auto_reheat = func {

  var fcs_auto_reheat_lock = getprop("/autopilot/FCS/locks/auto-reheat");

  if(fcs_auto_reheat_lock == "engaged") {
    setprop("/autopilot/FCS/locks/auto-reheat", "off");
  } else {
    setprop("/autopilot/FCS/locks/auto-reheat", "engaged");
  }
}
#--------------------------------------------------------------------
var toggle_fcs_auto_spin_recovery = func {

  var fcs_auto_spin_recovery_lock = getprop("/autopilot/FCS/locks/auto-spin-recovery");

  if(fcs_auto_spin_recovery_lock == "enabled") {
    setprop("/autopilot/FCS/locks/auto-spin-recovery", "off");
  } else {
    setprop("/autopilot/FCS/locks/auto-spin-recovery", "enabled");
  }
}
#--------------------------------------------------------------------

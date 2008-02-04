# FCS listeners
#--------------------------------------------------------------------
var initialise = func {
  setlistener("/autopilot/locks/altitude", altitude_lock);
  setlistener("/autopilot/locks/heading", heading_lock);
}
#--------------------------------------------------------------------
var altitude_lock = func {
  # Set the necessary locks for each pitch hold function.
  var altitude_lock = getprop("/autopilot/locks/altitude");
  if(altitude_lock == "") {
#    setprop("/autopilot/FCS/modes/stick", "");
    setprop("/autopilot/FCS/locks/pitch", "off");
    setprop("/autopilot/FCS/locks/vfps", "off");
    tfa_off();
  } elsif(altitude_lock == "altitude-hold") {
    setprop("/autopilot/FCS/modes/stick", "");
    setprop("/autopilot/FCS/locks/pitch", "engaged");
    setprop("/autopilot/FCS/locks/vfps", "engaged");
    tfa_off();
  } elsif(altitude_lock == "agl-hold") {
    setprop("/autopilot/FCS/modes/stick", "");
    setprop("/autopilot/FCS/locks/pitch", "engaged");
    setprop("/autopilot/FCS/locks/vfps", "engaged");
    tfa_engaged();
  } elsif(altitude_lock == "pitch-hold") {
    setprop("/autopilot/FCS/modes/stick", "");
    setprop("/autopilot/FCS/locks/pitch", "engaged");
    setprop("/autopilot/FCS/locks/vfps", "off");
    tfa_off();
  } elsif(altitude_lock == "aoa-hold") {
    setprop("/autopilot/FCS/modes/stick", "");
    setprop("/autopilot/FCS/locks/pitch", "engaged");
    setprop("/autopilot/FCS/locks/vfps", "off");
    tfa_off();
  } elsif(altitude_lock == "vfps-hold") {
    setprop("/autopilot/FCS/modes/stick", "");
    setprop("/autopilot/FCS/locks/pitch", "engaged");
    setprop("/autopilot/FCS/locks/vfps", "engaged");
    tfa_off();
  } elsif(altitude_lock == "gs1-hold") {
    setprop("/autopilot/FCS/modes/stick", "");
    setprop("/autopilot/FCS/locks/pitch", "engaged");
    setprop("/autopilot/FCS/locks/vfps", "engaged");
    tfa_off();
  } elsif(altitude_lock == "mach-climb") {
    setprop("/autopilot/FCS/modes/stick", "");
    setprop("/autopilot/FCS/locks/pitch", "engaged");
    setprop("/autopilot/FCS/locks/vfps", "engaged");
    tfa_off();
  } elsif(altitude_lock == "climb-out") {
    setprop("/autopilot/FCS/modes/stick", "");
    setprop("/autopilot/FCS/locks/pitch", "engaged");
    setprop("/autopilot/FCS/locks/vfps", "off");
    tfa_off();
  } elsif(altitude_lock == "ground-roll") {
    setprop("/autopilot/FCS/modes/stick", "");
    setprop("/autopilot/FCS/locks/pitch", "engaged");
    setprop("/autopilot/FCS/locks/vfps", "off");
    tfa_off();
  } elsif(altitude_lock == "auto-spin-recovery") {
    setprop("/autopilot/FCS/modes/stick", "");
    setprop("/autopilot/FCS/locks/pitch", "ASR");
    setprop("/autopilot/FCS/locks/vfps", "off");
    tfa_off();
  }
}
#--------------------------------------------------------------------
var heading_lock = func {
  # Set the necessary locks for each roll hold function.
  var heading_lock = getprop("/autopilot/locks/heading");
  if(heading_lock == "") {
    setprop("/autopilot/settings/target-roll-deg", 0);
    setprop("/autopilot/FCS/locks/roll", "off");
  } elsif(heading_lock == "wing-leveler") {
    setprop("/autopilot/settings/target-roll-deg", 0);
    setprop("/autopilot/FCS/locks/roll", "engaged");
  } elsif (heading_lock == "true-heading-hold") {
    setprop("/autopilot/FCS/locks/roll", "engaged");
  } elsif (heading_lock == "dg-heading-hold") {
    setprop("/autopilot/FCS/locks/roll", "engaged");
  } elsif (heading_lock == "nav1-hold") {
    setprop("/autopilot/FCS/locks/roll", "engaged");
  } elsif (heading_lock == "auto-spin-recovery") {
    setprop("/autopilot/FCS/locks/roll", "ASR");
  }
}
#--------------------------------------------------------------------
var tfa_engaged = func {
  var current_alt_ft = getprop("/position/altitude-ft");
  var tfa_mode =       getprop("/instrumentation/terrain-radar/settings/mode");
  setprop("/autopilot/settings/target-climb-rate-fps", 0);
  setprop("/autopilot/internal/target-tfa-altitude-ft", current_alt_ft);
  setprop("/instrumentation/terrain-radar/settings/state", "on");

  # Start the collision monitor.
  settimer(SU37TFA.collision_monitor, 0.5);

  # Check the mode and start the appropriate loop.
  if(tfa_mode == "extend") {
    settimer(SU37TFA.tfa_radar_extend_mode_loop, 0.1);
  } else {
    if(tfa_mode == "continuous") {
      settimer(SU37TFA.tfa_radar_continuous_mode_loop, 0.1);
    }
  }
}
#--------------------------------------------------------------------
var tfa_off = func {
  setprop("/instrumentation/terrain-radar/settings/state", "off");
  setprop("/instrumentation/terrain-radar/hi-elev/alt-ft", -9999.9);
  setprop("/instrumentation/terrain-radar/hi-elev/lat-deg", -9999.9);
  setprop("/instrumentation/terrain-radar/hi-elev/lon-deg", -9999.9);
  setprop("/instrumentation/terrain-radar/hi-elev/dist-m", -9999.9);
  setprop("/instrumentation/terrain-radar/hi-elev/collision-status", "");
  setprop("/autopilot/internal/target-tfa-altitude-ft", -9999.9);
}
#--------------------------------------------------------------------

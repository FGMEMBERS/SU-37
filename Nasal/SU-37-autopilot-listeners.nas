# FCS listeners
#--------------------------------------------------------------------
initialise = func {
  setlistener("/autopilot/locks/altitude", altitude_lock);
  setlistener("/autopilot/locks/heading", heading_lock);
}
#--------------------------------------------------------------------
altitude_lock = func {
  # Set the necessary locks for each pitch hold function.
  altitude_lock = getprop("/autopilot/locks/altitude");
  if(altitude_lock == "") {
#    setprop("/autopilot/FCS/modes/stick", "");
    setprop("/autopilot/FCS/locks/pitch", "off");
    setprop("/autopilot/FCS/locks/vfps", "off");
  } elsif(altitude_lock == "altitude-hold") {
    setprop("/autopilot/FCS/modes/stick", "");
    setprop("/autopilot/FCS/locks/pitch", "engaged");
    setprop("/autopilot/FCS/locks/vfps", "engaged");
  } elsif(altitude_lock == "agl-hold") {
    setprop("/autopilot/FCS/modes/stick", "");
    setprop("/autopilot/FCS/locks/pitch", "engaged");
    setprop("/autopilot/FCS/locks/vfps", "engaged");
  } elsif(altitude_lock == "pitch-hold") {
    setprop("/autopilot/FCS/modes/stick", "");
    setprop("/autopilot/FCS/locks/pitch", "engaged");
    setprop("/autopilot/FCS/locks/vfps", "off");
  } elsif(altitude_lock == "aoa-hold") {
    setprop("/autopilot/FCS/modes/stick", "");
    setprop("/autopilot/FCS/locks/pitch", "engaged");
    setprop("/autopilot/FCS/locks/vfps", "off");
  } elsif(altitude_lock == "vfps-hold") {
    setprop("/autopilot/FCS/modes/stick", "");
    setprop("/autopilot/FCS/locks/pitch", "engaged");
    setprop("/autopilot/FCS/locks/vfps", "engaged");
  } elsif(altitude_lock == "gs1-hold") {
    setprop("/autopilot/FCS/modes/stick", "");
    setprop("/autopilot/FCS/locks/pitch", "engaged");
    setprop("/autopilot/FCS/locks/vfps", "engaged");
  } elsif(altitude_lock == "mach-climb") {
    setprop("/autopilot/FCS/modes/stick", "");
    setprop("/autopilot/FCS/locks/pitch", "engaged");
    setprop("/autopilot/FCS/locks/vfps", "engaged");
  } elsif(altitude_lock == "climb-out") {
    setprop("/autopilot/FCS/modes/stick", "");
    setprop("/autopilot/FCS/locks/pitch", "engaged");
    setprop("/autopilot/FCS/locks/vfps", "off");
  } elsif(altitude_lock == "ground-roll") {
    setprop("/autopilot/FCS/modes/stick", "");
    setprop("/autopilot/FCS/locks/pitch", "engaged");
    setprop("/autopilot/FCS/locks/vfps", "off");
  } elsif(altitude_lock == "auto-spin-recovery") {
    setprop("/autopilot/FCS/modes/stick", "");
    setprop("/autopilot/FCS/locks/pitch", "ASR");
    setprop("/autopilot/FCS/locks/vfps", "off");
  }
}
#--------------------------------------------------------------------
heading_lock = func {
  # Set the necessary locks for each roll hold function.
  heading_lock = getprop("/autopilot/locks/heading");
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

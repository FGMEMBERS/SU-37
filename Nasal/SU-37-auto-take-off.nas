autotakeoff = func {
  if(getprop("/autopilot/locks/auto-take-off") == "enabled") {
    ato_initiation();
  }
}
#--------------------------------------------------------------------
ato_initiation = func {
  # Check that the aircraft is on the ground, initialise, call the
  # main loop and set the ato lock to engaged.

  gear_agl_ft = getprop("/position/gear-agl-ft");

  if(gear_agl_ft  < 0.00000001) {
  
    current_heading_deg = getprop("/orientation/heading-deg");

    setprop("/controls/flight/spoilers", 0);
    setprop("/controls/gear/brake-left", 0);
    setprop("/controls/gear/brake-right", 0);
    setprop("/controls/gear/brake-parking", 0);

    setprop("/autopilot/FCS/modes/stick", "pitch");
    setprop("/autopilot/FCS/locks/auto-flaps", "off");
    setprop("/autopilot/FCS/locks/auto-slats", "engaged");
    setprop("/autopilot/FCS/locks/auto-reheat", "engaged");
    setprop("/autopilot/locks/altitude", "pitch-hold");
    setprop("/autopilot/locks/heading", "wing-leveler");

    setprop("/autopilot/locks/auto-take-off", "engaged");

    setprop("/autopilot/settings/steering-heading-deg", current_heading_deg);
    setprop("/autopilot/settings/target-speed-kt", 400);
    setprop("/autopilot/settings/target-pitch-deg", 0);
    interpolate("/controls/engines/engine[0]/throttle", 1, 4);
    interpolate("/controls/engines/engine[1]/throttle", 1, 4);

    ato_loop();
  }
}
#--------------------------------------------------------------------
ato_loop = func {
  if(getprop("/autopilot/locks/auto-take-off") == "engaged") {
    ato_speed();
    ato_altitude();
    settimer(ato_loop, 0.2);
  }
}
#--------------------------------------------------------------------
ato_speed = func {
  # Speed dependent actions.
  
  current_airspeed_kt = getprop("/velocities/airspeed-kt");
  rotate_airspeed_kt = getprop("/autopilot/FCS/settings/rotate-airspeed-kt");

  if(current_airspeed_kt < 30) {
    setprop("/autopilot/locks/ground-steering", "ground-roll");
  } elsif(current_airspeed_kt < rotate_airspeed_kt) {
    # Wait until we get to rotation speed...
  } else {
    # Rotation speed - set the target pitch to the rotation pitch.
    take_off_pitch_deg = getprop("/autopilot/FCS/settings/take-off-pitch-deg");
    setprop("/autopilot/settings/target-pitch-deg", take_off_pitch_deg);
  }
}
#--------------------------------------------------------------------
ato_altitude = func {
  # Altitude dependent actions.

  current_agl_ft = getprop("/position/altitude-agl-ft");
  gear_up_agl_ft = getprop("/autopilot/settings/gear-up-agl-ft");
  climb_out_agl_ft = getprop("/autopilot/settings/climb-out-agl-ft");

  if(current_agl_ft < gear_up_agl_ft) {
    # Do nothing until we can get the gear up.
  } elsif(current_agl_ft < climb_out_agl_ft) {
    # Gear up agl ft.
    setprop("/controls/gear/gear-down", "false");
  } else {
    setprop("/autopilot/locks/ground-steering", "");
    interpolate("/controls/flight/rudder", 0, 5);

    setprop("/autopilot/FCS/modes/stick", "vfps");
    setprop("/autopilot/FCS/locks/auto-flaps", "off");
    setprop("/autopilot/FCS/locks/auto-slats", "off");
    setprop("/autopilot/FCS/locks/auto-reheat", "off");
    setprop("/controls/engines/engine[0]/reheat", 0);
    setprop("/controls/engines/engine[1]/reheat", 0);
    setprop("/autopilot/locks/altitude", "altitude-hold");
    setprop("/autopilot/locks/heading", "true-heading-hold");
    setprop("/autopilot/locks/speed", "speed-with-throttle");
    setprop("/autopilot/locks/auto-take-off", "disabled");
    setprop("/autopilot/locks/auto-landing", "enabled");
  }
}
#--------------------------------------------------------------------

#--------------------------------------------------------------------
autoland = func {
  if(getprop("/autopilot/locks/auto-landing") == "enabled") {
    setprop("/autopilot/locks/auto-landing", "engaged");
    atl_initiation();
  }
}
#--------------------------------------------------------------------
atl_initiation = func {

  fcs_approach_aoa_deg = getprop("/autopilot/settings/approach-aoa-deg");
  current_vfps = getprop("/velocities/vertical-speed-fps");

  setprop("/autopilot/FCS/modes/stick", "FCS");
  setprop("/autopilot/FCS/locks/auto-flaps", "engaged");
  setprop("/autopilot/FCS/locks/auto-slats", "engaged");
  setprop("/autopilot/FCS/locks/auto-speedbrake", "engaged");
  setprop("/autopilot/FCS/locks/auto-reheat", "off");

  setprop("/autopilot/locks/speed", "speed-with-throttle");
  setprop("/autopilot/settings/target-aoa-deg", fcs_approach_aoa_deg);
  setprop("/autopilot/locks/aoa", "aoa-with-speed");

  setprop("/autopilot/settings/target-climb-rate-fps", current_vfps);
  setprop("/autopilot/locks/altitude", "gs1-hold");
  interpolate("/autopilot/settings/target-climb-rate-fps", 0, 5);
  
  # Set the A/P Heading lock to nav1-hold.
  setprop("/autopilot/locks/heading", "nav1-hold");

  # Allow the a/c to level out and then start the main loop.
  settimer(atl_loop, 4);
}
#--------------------------------------------------------------------
atl_loop = func {
  agl = getprop("/position/altitude-agl-ft");

  if(agl > 400) {
    # Glide Slope phase.
    atl_glideslope();
    atl_gear();
  } else {
    # Touch Down phase.
    atl_touchdown();
  }

  # Re-schedule the next loop if the Landing function is enabled.
  if(getprop("/autopilot/locks/auto-landing") == "engaged") {
    settimer(atl_loop, 0.1);
  }
}
#--------------------------------------------------------------------
atl_glideslope = func {
  # This script handles glide slope interception.

  gsroc = getprop("/autopilot/internal/gs-rate-of-climb-filtered");
  nav1hderrd = getprop("/autopilot/internal/nav1-heading-error-deg");

  target_vfps = 0;

  if(nav1hderrd > -80) {
    if(nav1hderrd < 80) {
      target_vfps = gsroc;
    }
  }
  setprop("/autopilot/settings/target-climb-rate-fps", target_vfps);
}
#--------------------------------------------------------------------
atl_gear = func {
  # This script handles gear extend.

  airspeed_kt = getprop("/velocities/airspeed-kt");
  gear_down_airspeed_kt = getprop("/autopilot/settings/gear-down-airspeed-kt");

  if(airspeed_kt < gear_down_airspeed_kt) {
    setprop("/controls/gear/gear-down", "true");
  }
}
#--------------------------------------------------------------------
atl_touchdown = func {
  # Touch Down phase.
  agl = getprop("/position/gear-agl-ft");
  vfps = getprop("/velocities/vertical-speed-fps");

  setprop("/autopilot/locks/heading", "");

  if(agl < 1) {
    setprop("/autopilot/FCS/modes/stick", "direct");
    setprop("/controls/gear/brake-left", 0.1);
    setprop("/controls/gear/brake-right", 0.1);
    setprop("/autopilot/locks/auto-landing", "disabled");
    setprop("/autopilot/locks/auto-take-off", "enabled");
    setprop("/autopilot/locks/altitude", "pitch-hold");
    setprop("/autopilot/settings/target-climb-rate-fps", 0);
    interpolate("/autopilot/settings/target-pitch-deg", -2, 4);
  } else {
    if(agl < 2) {
      setprop("/autopilot/settings/target-climb-rate-fps", -1);
      setprop("/autopilot/locks/heading", "");
      setprop("/controls/flight/spoilers", 1);
    } else {
      if(agl < 4) {
        setprop("/autopilot/settings/target-climb-rate-fps", -2);
        setprop("/autopilot/locks/aoa", "");
        setprop("/autopilot/locks/speed", "off");
        setprop("/controls/engines/engine[0]/throttle", 0);
        setprop("/controls/engines/engine[1]/throttle", 0);
      } else {
        if(agl < 8) {
          setprop("/autopilot/settings/target-climb-rate-fps", -4);
        } else {
          if(agl < 16) {
            setprop("/autopilot/settings/target-climb-rate-fps", -6);
          } else {
            if(agl < 32) {
              setprop("/autopilot/settings/target-climb-rate-fps", -8);
            } else {
              if(agl < 64) {
                if(vfps < -10) {
                  setprop("/autopilot/settings/target-climb-rate-fps", -10);
                }
              } else {
                if(agl < 132) {
                  if(vfps < -12) {
                    setprop("/autopilot/settings/target-climb-rate-fps", -12);
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
#--------------------------------------------------------------------

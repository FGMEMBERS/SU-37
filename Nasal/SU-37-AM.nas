# Air Manuevers (sp?)
#--------------------------------------------------------------------
# 1. Engage speedbrake and set target speed to 200 kt.
# 2. Set target agl to 2000 ft and engage agl-hold.
# 3. Engage wing-leveler.
# 4. Wait until conditions 1 & 2 are met.
# 5. Set vfps to 0 and engage vfps-hold.
# 6. Wait 10 sec for a/c to level out.
# 7. Disengage speed-brake, speed-lock & agl-hold.
# 8. Do it.
#--------------------------------------------------------------------
m01 = func {
  print("m01");
  setprop("/autopilot/FCS/locks/auto-speedbrake", "engaged");
  setprop("/autopilot/settings/target-speed-kt", 200);
  setprop("/autopilot/locks/heading", "wing-leveler");
  setprop("/autopilot/settings/target-climb-rate-fps", 0);
  setprop("/autopilot/locks/altitude", "vfps-hold");

  settimer(m02, 5);
}
#--------------------------------------------------------------------
m02 = func {
  print("m02");
  m03_delay = getprop("/autopilot/FCS/settings/m03-delay");
  m04_delay = getprop("/autopilot/FCS/settings/m04-delay");
  m05_delay = getprop("/autopilot/FCS/settings/m05-delay");
  m06_delay = getprop("/autopilot/FCS/settings/m06-delay");
  if(getprop("/velocities/airspeed-kt") < 205) {
    if(getprop("/velocities/vertical-speed-fps") < 1) {
      if(getprop("/velocities/vertical-speed-fps") > -1) {
        setprop("/autopilot/FCS/locks/auto-speedbrake", "off");
        settimer(m03, m03_delay);
        settimer(m04, m04_delay);
        settimer(m05, m05_delay);
        settimer(m06, m06_delay);
      } else {
        settimer(m02, 2);
      }
    } else {
      settimer(m02, 2);
    }
  } else {
    settimer(m02, 2);
  }
}
#--------------------------------------------------------------------
m03 = func {
  print("m03");
  setprop("/autopilot/locks/speed", "");
  setprop("/autopilot/locks/heading", "");
  setprop("/autopilot/locks/altitude", "");
  setprop("/autopilot/FCS/modes/stick", "direct");
  setprop("/controls/flight/elevator", -1);
  setprop("/controls/engines/engine[0]/throttle", 1);
  setprop("/controls/engines/engine[1]/throttle", 1);
}
#--------------------------------------------------------------------
m04 = func {
  print("m04");
  setprop("/controls/flight/elevator", 0.5);
  setprop("/controls/engines/engine[0]/reheat", 1);
  setprop("/controls/engines/engine[1]/reheat", 1);
}
#--------------------------------------------------------------------
m05 = func {
  print("m05");
  setprop("/controls/flight/elevator", -0.1);
}
#--------------------------------------------------------------------
m06 = func {
  print("m06");
  setprop("/autopilot/locks/speed", "speed-with-throttle");
  setprop("/autopilot/settings/target-speed-kt", 240);
  setprop("/autopilot/locks/altitude", "vfps-hold");
  setprop("/autopilot/locks/heading", "wing-leveler");
  setprop("/controls/engines/engine[0]/reheat", 0);
  setprop("/controls/engines/engine[1]/reheat", 0);
}
#--------------------------------------------------------------------

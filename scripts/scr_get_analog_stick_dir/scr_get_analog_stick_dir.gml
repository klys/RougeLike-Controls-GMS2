/// @description  scr_get_analog_stick_dir(touch)
/// @param touch
/// get a value between 0 to 360 
function scr_get_analog_stick_dir(argument0) {
	

	var stick = findStick(argument0); // should be ID of obj_analog_stick instance
	if (stick == undefined) return 0;
	return point_direction(stick.guiX,stick.guiY,stick.stickX,stick.stickY); 





}
// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function findStick(argument0){
	with(obj_analog_stick) {
		if (touch == argument0) return id;
	}
	return undefined;
}
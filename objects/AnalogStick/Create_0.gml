/// @description  Important stuff about making the analog stick work properly!

/* 
    The stick is drawn to the GUI layer - that is, its pixels aren't scaled up with the game view. 
    It is drawn DIRECTLY to the screen. This means that if you have (on Windows Phone, for instance) a 
	400x200 game that 
    is scaled up to a 1280x720 resolution, the analog stick will be drawn as if the game wasn't scaled. 
	(If the stick 
    was positioned at (380,180), the lower-left of a 400x200 screen, it would appear to be in the upper
	right of a 
    1280x720 screen.)
    So be mindful of how the coordinates at which you place the analog stick in the room editor may not 
	necessarily 
    reflect the coordinates to which it is drawn during run time!  
    
    Currently there's code in the stick's create event to take care of this issue (it's as simple as 
	multiplying its room
    coordinates by the ratio of the screen width to the view width), but it's a good thing to be aware of. 
    HOWEVER, make sure your room has at least one view, even if your game doesn't need it! 
    (Using the variables view_wview and view_hview when views aren't actually enabled doesn't seem to work. 
    To work around this, just make a view with the dimensions of your room. Thanks!)
*/
        
        

/* */
/// initialize enums for axes

// originally these were stored as AXIS_X and AXIS_Y 
// as macros/constants, but the marketplace currently 
// doesn't support those. 

enum axis { 
    X,
    Y
}; 

/* */
/// initialize stick

global.touch = 0;
touch = -1
maxDis = 150

boundSprite = sprite_index; // should be spr_analog_boundary 
stickSprite = spr_analog_stick; 

radius = sprite_get_width(boundSprite)/2; 
alpha = 0.75; 
snapRate = 24; // speed at which stick snapes back to origin

// as a note, image_xscale and image_yscale should be used for referencing scale.

// stick OBJECT won't actually move with view - only sprite will. 
guiX = x * display_get_gui_width()/__view_get( e__VW.WView, 0 ); // multiplying by the gui to room ratio accounts for any view scaling issues
guiY = y * display_get_gui_height()/__view_get( e__VW.HView, 0 );

// using GUI mouse coordinates is easier than offsetting the room
guiMouseX = (touch == -1) ? device_mouse_x_to_gui(global.touch) : device_mouse_x_to_gui(touch); 
guiMouseY = (touch == -1) ? device_mouse_y_to_gui(global.touch) : device_mouse_y_to_gui(touch); 

stickX = guiX; 
stickY = guiY; 

// boolean
isPressed = false; 


/* */
/*  */



/// @description  scr_get_analog_stick_axis(obj,axis)
/// @param obj
/// @param axis
/// get a value between 1 and -1 for either the x or y axis. 
Axis = function(argument0) {
	

	var stick = id;
	var axis = argument0; // should be 1 of 2 constants: AXIS_X or AXIS_Y
	
	var value = 0; 
	
	
	// yields 0 - 360
	var dir = point_direction(stick.guiX,stick.guiY,stick.stickX,stick.stickY); 
	// yields decimal from 0 - 1
	var mag = point_distance(stick.guiX,stick.guiY,stick.stickX,stick.stickY)/(stick.radius*stick.image_xscale); 

	if (axis == axis.X) { 
	    value = lengthdir_x(mag,dir); 
	}
	else {
	    value = lengthdir_y(mag,dir); 
	} 

	return value; 



}



/// @description  scr_get_analog_stick_dir(touch)
/// @param touch
/// get a value between 0 to 360 
Dir = function () {
	

	var stick = id;
	if (stick == undefined) return 0;
	return point_direction(stick.guiX,stick.guiY,stick.stickX,stick.stickY); 


}


/// @description  scr_get_tilt_speed(xvector,speed_factor,dead_zone)
/// @param xvector
/// @param speed_factor
/// @param dead_zone
/// yields tilt speed for ON-SCREEN x axis (for some reason this is the phone's y axis)
/// utilizes device ACCELEROMETER. 
tillSpeed = function (argument0, argument1, argument2) {

	// The x axis corresponds to side-to-side movement. (Tilting the phone like a steering wheel.)
	var speed_factor = argument1; 
	var dead_zone = argument2; 
	var xspeed = device_get_tilt_y() * argument0 * speed_factor; 
	// speed factor is used so that full speed can be achieved without titling phone at 90 degree angle

	if (abs(xspeed) > dead_zone*argument0*speed_factor) { 
	    if (display_get_orientation() == display_landscape) {
	        xspeed *= -1; //flip it  
	    }
	    else if (display_get_orientation() == display_landscape_flipped) {
	        xspeed *= 1; //for consistency's sake; remove later?
	    }
	}
 
	return xspeed; // used to derive input (e.g. moving left vs. right)




}

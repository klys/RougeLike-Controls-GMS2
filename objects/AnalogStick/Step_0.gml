/// @description  update analog stick
guiMouseX = (touch == -1) ? device_mouse_x_to_gui(global.touch) : device_mouse_x_to_gui(touch); 
guiMouseY = (touch == -1) ? device_mouse_y_to_gui(global.touch) : device_mouse_y_to_gui(touch); 
if (mouse_check_button(mb_left)){
	
	if (touch == -1) and (point_distance(guiMouseX, guiMouseY,x,y) <= maxDis) {
		touch = global.touch;
		global.touch++;
	}
	
	if (touch != -1)
	if (device_mouse_check_button(touch,mb_left)) { 
     
    
	    // update GUI mouse coords only if mouse is pressed	    
		
	isPressed = true;
		
	
	}
	
} else {
	isPressed = false; 
	if (touch != -1) {
		global.touch--;
		touch = -1;
	}
}

// update stick coords
if (isPressed) { 
    if (point_distance(guiX,guiY,guiMouseX,guiMouseY) <= radius*image_xscale) {
        stickX = guiMouseX; 
        stickY = guiMouseY;
    }
    else { // constrain stick to boundary
        var dir = point_direction(guiX,guiY,guiMouseX,guiMouseY); 
        stickX = guiX + lengthdir_x(radius*image_xscale,dir); 
        stickY = guiY + lengthdir_y(radius*image_xscale,dir); 
    }
}
else { 
    // snap back to origin
    if (point_distance(stickX,stickY,guiX,guiY) >= snapRate*image_xscale) {
        var dir = point_direction(stickX,stickY,guiX,guiY); 
        stickX += lengthdir_x(snapRate*image_xscale,dir); 
        stickY += lengthdir_y(snapRate*image_xscale,dir); 
    }
    else { // prevents overshooting
        stickX = guiX; 
        stickY = guiY; 
    }       
}
    


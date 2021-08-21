

var ViewWidth,ViewHeight;

ViewHeight=display_get_gui_height(); //This is the vertical height I'm designing my game around.
var _aspect = display_get_width() / display_get_height(); //Get the aspect ratio of the display.

// You can use these settings to test out various aspect ratios
//var _aspect = 1440 / 2960; //Galaxy s8 super narrow screen
//var _aspect = 480 / 640; //Tablet
//var _aspect = 720 / 1280; //Standard phone

//Restrict horizontal screen size so elements aren't cut off
if _aspect<.49{_aspect=.49;}

ViewWidth=round(ViewHeight*_aspect); //Set the view width based on the display.

surface_resize(application_surface, ViewWidth, ViewHeight); //Resize the application surface to the new size.
camera_set_view_size(view_camera[0],ViewWidth,ViewHeight);
window_set_size(ViewWidth,ViewHeight); //Finally, set the window size.
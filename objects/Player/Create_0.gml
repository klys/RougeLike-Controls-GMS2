/// @description  init

rate = 8; 

stick[0] = instance_create_depth(224,832,0, AnalogStick)
stick[1] = instance_create_depth(1664,832,0, AnalogStick)


pointer = function() {
	if (instance_exists(AnalogStick))
	draw_sprite_ext(Sprite5,0,x,y,1,1,stick[1].Dir(),c_red,1)
}

alarm[0] = 30
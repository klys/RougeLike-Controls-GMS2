/// @description  draw the stick

draw_sprite_ext(boundSprite,0,guiX,guiY,image_xscale,image_yscale,0,c_white,alpha); 

// stick
draw_sprite_ext(stickSprite,0,stickX,stickY,image_xscale,image_yscale,0,c_white,alpha); 


// debug

var axisx = Axis(axis.X); 
var axisy = Axis(axis.Y); 

draw_text(32,32,string_hash_to_newline("x: "+string(axisx)+"#y: "+string(axisy))); 

//draw touchable area
draw_circle(x,y,maxDis,1)
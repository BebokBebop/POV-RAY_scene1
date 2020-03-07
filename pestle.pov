#include "shapes.inc"
#include "colors.inc"



#declare pestleWoodPigment = 
texture{
    pigment {        
        wood        
        color_map {          
            [0.0 color<.4,.15,.1>*0.15]          
            [0.9 color <.4,.15,.1>*0.2]          
            [1.0 color <.4,.15,.1>*0.3]       
        }        
        turbulence 0.05        
        scale <0.1, 0.6, 0.5> 
    } 
    finish{
        phong .1
        phong_size 100
    }
}

#macro pestle(
    maj_radius, 
    minor_radius, 
    length, 
    center, 
    wood_texture
)
#local total_radius=maj_radius+minor_radius;
#declare handle_texture = texture {

    pigment {
        color rgb <0.40, 0.15, 0.1>*0.2
    }                   
    finish {
        crand 0.4
        diffuse 0.7
    }    
}

#declare handle_texture2 = texture {

    pigment {
        color rgb <0.45, 0.15, 0.1>*0.1
    }                   
    finish {
        crand 0.2 
        diffuse 0.7
    }    
}

union {
    cylinder {
        <center, -length>,
        <center, 0>,
        total_radius  
    }
    torus {
        maj_radius, minor_radius
        translate <0,0,0>
    }
    torus {
        maj_radius, minor_radius
        translate <0,1.5*minor_radius,0>
    }
    torus {
        maj_radius, minor_radius
        translate <0,3*minor_radius,0>
    }
    torus {
        maj_radius, minor_radius
        translate <0,4.5*minor_radius,0>
    }
    cylinder {
        <center, 5.0*minor_radius>,
        <center, length+5.0*minor_radius>,
        total_radius
        texture { 
            bozo
            texture_map {
                [0.2 handle_texture2] 
                [0.7 handle_texture] 
            }    
            turbulence 0.5  
            rotate <0, 180, 0>
        } 
    }
    cylinder { 
        <center, length+5.0*minor_radius>
        <center, 0.1 + length+5.0*minor_radius>
        total_radius
        texture {
            pigment {
                color rgb <0.23, 0.2, 0.2>
            }
        } 
    }   
    cylinder { 
        <center, length+5.0*minor_radius>
        <center, 0.2 + length+5.0*minor_radius>
        total_radius - 0.2
    }
    texture {
        wood_texture            
    }  
    rotate <0, 180, 0>   
}
#end 


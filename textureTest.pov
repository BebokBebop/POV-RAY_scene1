//textureTest
#include "MyTextures.pov"

// sphere{
//     <0,1,0>, 2}
#declare doBlur = 0;
#local tableRadius = 23;
cylinder{
    <0,-0.1,0>
    <0,0,0>
    tableRadius
    texture{
        pigment {        
            wood        
            color_map {          
                [0.0 color <.5,.1,.09>]          
                [0.9 color <.3,.2,.1>]          
                [1.0 color <.1,.1,.05>]        
            }        
            turbulence 0.05        
            scale <0.1, 0.6, 0.5>
        }
    }
rotate<0,0,0>
translate<-4,0,-12>
}



camera {
    angle 10
    location <0,8,-10>
    look_at <0,0,0>
}
light_source {
    <10, 10, -10> // <x, y, z>
    color <1.0, 1.0,  1.0> // <red, green, blue>
}
light_source {
    <-100, -150, -5> // <x, y, z>
    color <1.0, 1.0,  1.0> // <red, green, blue>
}
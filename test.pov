#include "flask.pov"
#include "roundedHollowTear.pov"
#include "shapes.inc"
#include "MyTextures.pov"
#include "table.pov"
#include "bowl.pov"
#include "pestle.pov"
#include "prism.pov"

union{
    //bowl
    object{
        bowl(
            3,
            0.1,
            texture { bowl_texture_out
            },  
            texture {bowl_texture_in
            },
            85,    //angleA, 83
            .7,    //neckHeight,
            .06    //engeRoundingR
        )
        scale<.9,.9,.9>
        translate<4.5,1.5,1>
    }
    //pestle
    object {
        pestle(
            1.4,
            1.7,
            15,
            0, 
            pestleWoodPigment
        )
        scale <0.15, 0.15, 0.15>
        rotate <-20, 0, -52>    
        
        translate <5.3, 1.58, 0.6>
    }
    translate<0,.3,0>
}

//camera
// camera {
//     angle 22
//     location<0,15,-45>
//     look_at<0,2,0> 
// }
camera {
    //angle 20
    angle 10
    location<0,15,-45>
    //look_at<0,2,0> 
    look_at<5.5,3,0> 
}
//cam top
// camera {
//     angle 20
//     location<0,20,0>
//     look_at<5,0,0> 
// }
//cam bot
// camera {
//     angle 90
//     location<0,0,-10>
//     look_at<0,100,0> 
// }

//lights
#declare lampBrightness = .33;
#declare lampColor =    
rgb<
        .95 *lampBrightness,
        // 0.82 *lampBrightness,
        // 0.698*lampBrightness
        0.8 *lampBrightness,
        0.6 *lampBrightness
>;

#local roz = 5;
light_source{
    <-2.5, 30, -3.5> 
    color lampColor
    area_light <roz, 0, 0>, <0, 0, roz>, 3, 3
    adaptive 1
    jitter
}    

//flash
#local flashRoz = .1;
light_source{
    <0,16.3,-45> 
    color rgb<.99,.99,.99>
    area_light <flashRoz, 0, 0>, <0, flashRoz, 0>, 2, 2
    adaptive 1
    jitter

    fade_distance 40
    fade_power 2 
}  
//room

//table

#local tableRadius = 23;
#local tableRoundness = 2;
#declare doBlur = 0;
object{
    table(tableRadius,tableRoundness,doBlur)
    rotate<0,30,0>
    translate<-4,0,-12>
}

//wall
plane{
    <0,0,1> 15
    texture{
        pigment{color <01.5,1.6,0.1>}
        finish {
            diffuse .9
        }
    } 
}
plane{
    <1,0,0> 25
    texture{
        pigment{color <01.5,1.6,0.1>}
        finish {
            diffuse .9
        }
    } 
}
plane{
    <-1,0,0> 30
    texture{
        pigment{color <01.5,1.6,0.1>}
        finish {
            diffuse .9
        }
    } 
}
//ceiling
plane{
    <0,1,0> 30.5
    texture{
        pigment{color rgb<1,1,1>}
        finish {
            diffuse .9
        }
    } 
}
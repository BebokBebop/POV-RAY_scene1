#include "flask.pov"
#include "roundedHollowTear.pov"
#include "shapes.inc"
#include "MyTextures.pov"
#include "table.pov"
#include "bowl.pov"
#include "pestle.pov"
#include "prism.pov"

//flask
#local fsize = 0.75;
difference{
object{
    flaskW2Textures(
        0.1  * fsize,       // topRoundness
        1.7  * fsize,       // topCylRoundness
        1.25  * fsize,       // topRadius
        1.5  * fsize,       // topHeight

        1.2  * fsize,       // bottomCylRoundness
        0.25 * fsize,       // bottomRoundness
        2.69  * fsize,       // bottomRadius
        4.6    * fsize,       // bottomHeight

        1.3  * fsize,       // cylinderHeight,
        0.63 * fsize,       // cylinderRadius,

        0.12 * fsize,       // flaskThickness

        material{texture{pigment{color Yellow}}},   // flaskTexture,
        // material {FlaskTexture4},  // flaskTexture
        //material{texture{pigment{color Red}}},   // flaskTexture,
        material {FlaskNeckTexture1},    // cylinderTexture

        4.42  * fsize,       // altTextureH1,
        5.95  * fsize        // altTextureH2
        )
        translate<0,0.0001,0>
    }
// box{
//     <-100,-1,-100>
//     <100,10,0>
// }
}

//bowl & pestle
union{
    //bowl
    object{
        bowl(
            2.7,
            0.1,
            texture { bowl_texture_out
            },  
            texture {bowl_texture_in
            },
            83    ,    //angleA, 83
            .27 ,    //neckHeight,
            .06    //engeRoundingR
        )
        scale <1.05, 0.89, 1.05> 
        //scale<.9,.9,.9>
        translate<4.3,1.85,1>
    }
    //pestle
    object {
        pestle(
            1.4,                //maj_radius, 
            1.7,                //minor_radius,
            15,                 //length, 
            0,                  //center, 
            pestleWoodPigment   //wood_texture
        )
        scale <0.15, 0.15, 0.15>
        rotate <-20, 0, -52>    
        
        translate <5.3, 1.72, 0.6>
    }
    translate<-.1,.3,0>
}


//camera
camera {
    angle 22
    location<0,15,-45>
    look_at<0,2,0> 
    right x * 16/9
    right x * 1024/768
}
// camera {
//     //angle 20
//     angle 12
//     location<0,15,-45>
//     look_at<5.5,2,0> 
//     right x * 16/9
// }
//cam top
// camera {
//     angle 80
//     location<0,20,0>
//     look_at<0,0,0> 
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
    <0,16.5,-45> 
    color rgb<.99,.99,.99>
    area_light <flashRoz, 0, 0>, <0, flashRoz, 0>, 2, 2
    adaptive 1
    jitter

    fade_distance 40
    fade_power 2 
}  
//room

//table

#local tableRadius = 27.5;
#local tableRoundness = 2;
#local translationVector = <-4,0,-18>;
#declare doBlur = 0;
object{
    table(tableRadius,tableRoundness,doBlur)
    rotate<0,30,0>
    translate translationVector 
}

//wall

#local fac = 2;
#local dist = -1;
#local sFac = 1.3;
difference{
    cone{
        <0,-2,0> (sFac*tableRadius)+1+dist
        <0,100,0> ((sFac*tableRadius)+1+dist)*fac
    }
    cone{
        <0,-2,0> (sFac*tableRadius)+dist
        <0,100,0> ((sFac*tableRadius)+dist)*fac
    }
    // box{
    //     <-100,-10,-100>
    //     <100,50,tableRadius/2>
    // }
    translate translationVector*sFac
    translate <-1,0,-1.2>
    texture{ wallTexture }

}
// plane{
    //     <0,0,1> 8.8
    //     texture{ wallTexture }
    //     rotate<30,20,0>
    // }
    // plane{
    //     <1,0,0> 25
    //     texture{ wallTexture } 
    // }
    // plane{
    //     <-1,0,0> 30
    //     texture{ wallTexture } 
    // }
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
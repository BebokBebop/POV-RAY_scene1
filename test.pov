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

    0.16 * fsize,       // flaskThickness

    // material{texture{pigment{color Yellow}}},   // flaskTexture,
    material{FlaskTexture1},   // flaskTexture,
    material {
        texture{
            pigment {
                colour rgb .99
                filter .18
                transmit .05
            }
            // normal {
            //     crackle, 0.010
            //     form < -1.000, 1.000, 0.000 >
            //     metric 2.000
            //     offset 0.000
            //     scale     <0.010,0.010,0.010>  /* Scale micro-normals. */
            // }

            finish {
                ior 1.5
                //ambient     rgb <0.100,0.100,0.100>*2.500
                //brilliance  1.000
                //diffuse     0.300
                //phong       0.000
                //phong_size  1.000
                specular .9
                roughness .0025
                reflection {
                    //rgb <0.015,0.015,0.015>, 
                    //rgb <0.025,0.025,0.025>
                    fresnel   1
                    //falloff   0.000
                    //exponent  1.000
                    //metallic  0.000
                }
            }
        }

    },  // flaskTexture
    //material {FlaskTexture2},    // cylinderTexture

    4.42  * fsize,       // altTextureH1,
    5.95  * fsize        // altTextureH2

)translate<0,0.0001,0>
} 
//camera
camera {
    //angle 20
    angle 20
    location<0,15,-45>
    //look_at<0,2,0> 
    look_at<0,4,0> 
}
//cam top
// camera {
//     angle 90
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

light_source{
    <-2.5, 30, -3.5> 
    color lampColor
}   
light_source{
    <-2, 30, -3> 
    color lampColor
}   
light_source{
    <-1.5, 30, -3> 
    color lampColor
}   
// light_source{
//     <0,5,0>
//     color rgb<.1,.1,.1>
// }
//flash
light_source{
    <-1,15.3,-45> 
    color rgb<.99,.99,.99>
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
plane{
    <0,1,0> 30.5
    texture{
        pigment{color rgb<1,1,1>}
        finish {
            diffuse .9
        }
    } 
}
#include "flask.pov"
#include "roundedHollowTear.pov"
#include "shapes.inc"
#include "MyTextures.pov"
#include "table.pov"
#include "bowl.pov"
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
    material {FlaskTexture1},  // flaskTexture
    material{texture{pigment{color Red}}},   // flaskTexture,
    //material {FlaskTexture2},    // cylinderTexture

    4.42  * fsize,       // altTextureH1,
    5.95  * fsize        // altTextureH2

)translate<0,0.0001,0>
}

//tear
object{ 
    #local tSize = 1.15 ;
    roundedHollowTear(
        2       *tSize,       //bigRadius,
        1.05    *tSize,       //smallRadius,
        0.95    *tSize,       //cutRadius,
        0.06     *tSize,       //angleA,
        0.75    *tSize,       //height,
        0.45    *tSize,     //thic,
        0.08    *tSize,      //roundness
        0.005    *tSize,     //insideMetal outSticking
        0.02    *tSize,     //tail roundness outside
        0.001   *tSize,     //tail roundness inside
        texture{tearTextureOutside},  //textureOutside
        texture{tearTextureInside}     //textureInside
    )
    rotate<-90,0,-25>
    rotate<0,-13,0>
    translate < -4.5, 2*tSize, -1.5>
}

//bowl
object{
    bowl(
        3,
        0.1,
        texture { BowlTextureOut
        },  
        texture {BowlTextureIn
        }
    )
    scale<.9,.9,.9>
    translate<4.5,1.5,1>
}

//prism
object{
    whole_prism(
        3,     //hex_top,          
        0,     //hex_bottom,  
        4.6,     //trapeze_top1,  
        5,   //trapeze_top2,  
        0,     //trapeze_botto 
        4,     //rhombus_top,  
        .5,     //rhombus_bottom
        1.7,     //hex_side,  
        0.1,   //hex_thickness     
        1.3,     //trapeze_cutof 
        .6    //rhombus_side 
        prismMaterial
    )
    scale .9
    translate<-6,+0.01,1.5>
    rotate<0,30,0>
}
//camera
camera {
    angle 20
    location<0,15,-45>
    look_at<0,2,0> 
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
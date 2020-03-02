#include "colors.inc"      
#include "glass.inc"    
#include "shapes.inc"
#include "woods.inc"

#macro flask(
    topRoundness,
    topCylRoundness,
    topRadius,
    topHeight,
    
    bottomBigRadius,
    bottomHeight,
    bottomRoundness

    cylinderHeight,
    cylinderRadius,

    flaskThickness,

    flaskTexture,
    cylinderTexture
)
#local sinTopAngle = topHeight / sqrt(topHeight*topHeight + (topRadius-cylinderRadius)*(topRadius-cylinderRadius));
#local topTorSmallRad = flaskThickness/2;
#local tmpX = topTorSmallRad /tan(asin(sinTopAngle)/2);
#local tmpZ = topTorSmallRad * sinTopAngle;
#local topTorheight = tmpX * sinTopAngle;
#local topTorBigRad = topRadius - tmpX; 

#local tmpY = topCylRoundness * tan(pi/4-asin(sinTopAngle)/2);
#local topCylRounderY = bottomHeight + cylinderHeight - tmpY;

#local tmpW = tmpY * sinTopAngle;
#local tmpQ = tmpY * cos(asin(sinTopAngle));
difference{
merge{
    difference{
        merge{
            //top cone + torus
            merge{
                torus{
                    topTorBigRad,
                    topTorSmallRad
                    texture {flaskTexture}
                    translate <0, 
                        bottomHeight + cylinderHeight + topHeight - topTorSmallRad
                        //+topTorSmallRad
                        , 
                    0> // <x, y, z>
                }
                difference{
                    cone{
                        <0,bottomHeight + cylinderHeight + topHeight,0>,
                        topRadius,    
                        <0,bottomHeight + cylinderHeight , 0>,
                        cylinderRadius
                        texture{flaskTexture}
                    }
                    cone{
                        <0,bottomHeight + cylinderHeight + topHeight+0.0000001,0>,
                        topRadius - flaskThickness/sinTopAngle,    
                        <0,bottomHeight + cylinderHeight-0.0000001 , 0>,
                        cylinderRadius - flaskThickness/sinTopAngle
                        texture{flaskTexture}
                    }
                    difference{
                        cylinder{
                            <0,bottomHeight + cylinderHeight + topHeight + 0.001,0>,
                            <0,bottomHeight + cylinderHeight + topHeight - topTorheight, 0>,
                            topRadius
                            texture{flaskTexture}
                        }
                        cylinder{
                            <0,bottomHeight + cylinderHeight + topHeight + 0.001,0>,
                            <0,bottomHeight + cylinderHeight + topHeight - topTorheight, 0>,
                            topRadius -tmpX - tmpZ
                            texture{flaskTexture}
                        }
                    }
                }
            }
            //cylinder
            difference{
                cylinder{
                    <0,bottomHeight,0>
                    <0,bottomHeight+cylinderHeight, 0>
                    cylinderRadius 
                    texture{flaskTexture}      
                }      
                cylinder{
                    <0,bottomHeight - 0.01,0>
                    <0,bottomHeight + cylinderHeight + 0.01, 0>
                    cylinderRadius - flaskThickness   
                    texture{flaskTexture}   
                }
            }
        }
        //inside roundness to be cut out
        difference{
            merge{
                cone{
                    <0, bottomHeight + cylinderHeight + tmpW ,0>
                    cylinderRadius + tmpQ
                    <0, bottomHeight + cylinderHeight - tmpY,0>
                    cylinderRadius
                    texture {flaskTexture}
                }
                cone{
                    <0, 
                    bottomHeight + cylinderHeight + tmpW
                            + flaskThickness * cos(asin(sinTopAngle))
                    ,0>
                    cylinderRadius + tmpQ - flaskThickness * sinTopAngle
                    <0, bottomHeight + cylinderHeight + tmpW ,0>
                    cylinderRadius + tmpQ
                    texture {flaskTexture}
                }
            }
            torus{
                cylinderRadius + topCylRoundness, 
                topCylRoundness + flaskThickness-0.000001
                translate <0, bottomHeight + cylinderHeight - tmpY, 0> // <x, y, z>
                texture {flaskTexture}
            }
        }
    }
    //top-cylinder roundness
    difference{
        intersection{
            merge{
                cone{
                    <0, bottomHeight + cylinderHeight + tmpW ,0>
                    cylinderRadius + tmpQ
                    <0, bottomHeight + cylinderHeight - tmpY,0>
                    cylinderRadius
                    texture {flaskTexture}
                }
                cone{
                    <0, 
                    bottomHeight + cylinderHeight + tmpW
                            + flaskThickness*cos(asin(sinTopAngle))*2
                    ,0>
                    cylinderRadius + tmpQ - flaskThickness *sinTopAngle*2
                    <0, bottomHeight + cylinderHeight + tmpW ,0>
                    cylinderRadius + tmpQ
                    texture {flaskTexture}
                }
            }
            torus{
                cylinderRadius + topCylRoundness, 
                topCylRoundness + flaskThickness
                translate <0, bottomHeight + cylinderHeight - tmpY, 0> // <x, y, z>
                texture {flaskTexture}
            }
        }
        torus{
            cylinderRadius + topCylRoundness, topCylRoundness
            translate <0, bottomHeight + cylinderHeight - tmpY, 0> // <x, y, z>
            texture {flaskTexture}
        }
    }
    
    //

    
}
box{
    <-100,0,-100>
    <100,100,0>
    texture{flaskTexture}
}
// box{
//     <-100,0,0.001>
//     <100,100,100>
//     texture{flaskTexture}
// }

}

#end


flask(
      0.1,    //     topRoundness
      0.4,      //topCylRoundness
      2,    // topRadius
      0.8,    // topHeight
      4,    // bottomBigRadius
      5,    // bottomHeight
      0.5,    // bottomRoundness

      1,    // cylinderHeight,
      0.8,    // cylinderRadius,

      0.1,    // flaskThickness

      texture{pigment{color Yellow}},   // flaskTexture,
      //texture{T_Glass4},    // cylinderTexture
      texture{T_Glass4}    // cylinderTexture
)

camera { orthographic
    location <-1, 6,-2.5>
    look_at <-1,6,0>
    // location <0, 7,0>
    // look_at <0,0,0>
}
light_source {
    <-1, 6, -10>
    color rgb <1, 1, 1>
}



plane{ // Floor
    <0,1,0>, 0 //Normal and distance
    texture{ //T_Wood5
        pigment{color Black}
        finish {
            reflection 0.3
            phong .75
            phong_size 20
        } 
    } 
    rotate<0,30,0>
}  



//FLASK  
// difference{
//     merge{
//         cone{
//             <0,9,0>, 1.3, <0,7,0>, 0.7
//             texture{
//                 T_Glass4
//             }
//         }
//         cylinder {
//             <0,6><0,7>, 0.7
//             texture {
//                 T_Glass4
//             }
//         }
//         object{ //full flask
//             Round_Cone(              
//                 <0,0,0>, //PtA
//                 3.7,     //RadiusA 
//                 <0,6,0>, //PtB
//                 0.7,     //RadiusB 
//                 0.2,      //EdgeRadius
//                 1        //UseMerge
//             )
//             texture{
//                 T_Glass4
//             }      
//         }
//      }  
           
//      merge{ //hollow flask 
//          cone{
//             <0,9,0>, 1.2, <0,7,0>, 0.6
//             texture{
//                 T_Glass4
//             }
//          }
//          cylinder {
//             <0,6><0,7>, 0.6
//             texture {
//                 T_Glass4
//             }
//          }
//          object{ //bottom cone
//             Round_Cone(              
//                 <0,0.1,0>, //PtA
//                 3.6,     //RadiusA 
//                 <0,6,0>, //PtB
//                 0.6,     //RadiusB 
//                 0.2,      //EdgeRadius
//                 1        //UseMerge
//             )
//             texture{
//                 T_Glass4
//             }      
//          }  
//      }
// }

//background {
//color Gray
//}
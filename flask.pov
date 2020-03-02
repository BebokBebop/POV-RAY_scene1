#macro flask(
    topRoundness,
    topCylRoundness,
    topRadius,
    topHeight,
    
    bottomRoundness
    bottomCylRoundness
    bottomRadius,
    bottomHeight,

    cylinderHeight,
    cylinderRadius,

    flaskThickness,

    flaskTexture,
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

#local sinBottomAngle = bottomHeight / sqrt(bottomHeight*bottomHeight + (bottomRadius - cylinderRadius)*(bottomRadius - cylinderRadius));
#local tmpX1 = flaskThickness / tan(asin(sinBottomAngle)/2);

#local tmpM = bottomRoundness - flaskThickness;
#local tmpX2 = tmpM / tan(asin(sinBottomAngle)/2);
#local tmpY2 = tmpX2*sinBottomAngle;
#local tmpX3 = tmpX2 *cos(asin(sinBottomAngle));

#local tmpX4 = bottomRoundness / tan(asin(sinBottomAngle)/2);
#local tmpY4 = tmpX4 * sinBottomAngle;
#local tmpX5 = tmpX4 * cos(asin(sinBottomAngle));

#local tmpY6 = bottomCylRoundness * tan(pi/4 - asin(sinBottomAngle)/2); 

#local tmpY7 = (topCylRoundness+flaskThickness)* tan(pi/2 - asin(sinTopAngle)); 
#local tmpY8 = (bottomCylRoundness+flaskThickness)* tan(pi/2 - asin(sinBottomAngle)); 
merge{
    //top + torus + cyl + bottom - inside roundnesss
    difference{
        //top + bottom + cyl
        merge{
            //top cone + torus
            difference{
                //top cone
                cone{
                    <0,bottomHeight + cylinderHeight + topHeight,0>,
                    topRadius,    
                    <0,bottomHeight + cylinderHeight , 0>,
                    cylinderRadius
                    material{flaskTexture}
                }
                //inside 
                cone{
                    <0,bottomHeight + cylinderHeight + topHeight+0.0000001,0>,
                    topRadius - flaskThickness/sinTopAngle,    
                    <0,bottomHeight + cylinderHeight-0.0000001 , 0>,
                    cylinderRadius - flaskThickness/sinTopAngle
                    material{flaskTexture}
                }
                //top rounding
                difference{
                    cylinder{
                        <0,bottomHeight + cylinderHeight + topHeight + 0.001,0>,
                        <0,bottomHeight + cylinderHeight + topHeight - topTorheight, 0>,
                        topRadius
                        material{flaskTexture}
                    }
                    cylinder{
                        <0,bottomHeight + cylinderHeight + topHeight + 0.001,0>,
                        <0,bottomHeight + cylinderHeight + topHeight - topTorheight, 0>,
                        topRadius -tmpX - tmpZ
                        material{flaskTexture}
                    }
                    torus{
                        topTorBigRad,
                        topTorSmallRad
                        material {flaskTexture}
                        translate <0, 
                            bottomHeight + cylinderHeight + topHeight - topTorSmallRad
                            //+topTorSmallRad
                            , 
                        0> // <x, y, z>
                    }
                    cutaway_textures
                }
                cutaway_textures
            }         
            //cylinder
            difference{
                cylinder{
                    <0,bottomHeight,0>
                    <0,bottomHeight+cylinderHeight, 0>
                    cylinderRadius 
                    material{cylinderTexture}      
                }      
                cylinder{
                    <0,bottomHeight - 0.01,0>
                    <0,bottomHeight + cylinderHeight + 0.01, 0>
                    cylinderRadius - flaskThickness   
                    material{cylinderTexture}   
                }
                cutaway_textures
            }
            //bottom cone
            difference{
                //filled
                cone{
                    <0,0,0>, 
                    bottomRadius,
                    <0,bottomHeight,0>,
                    cylinderRadius
                    material{flaskTexture}   
                }
                //to be cut
                difference{
                    //inside cone
                    cone{
                        <0,flaskThickness,0>, 
                        bottomRadius-tmpX1,
                        <0,bottomHeight+0.0000001,0>,
                        cylinderRadius-flaskThickness/sinBottomAngle
                        material{flaskTexture}   
                    }
                    //to be trimmed by torus
                    difference{
                        cylinder{
                            <0,0,0>
                            <0,tmpY2+flaskThickness,0>
                            bottomRadius
                            material{flaskTexture}   
                        }
                        cylinder{
                            <0,-0.001,0>
                            <0,tmpY2+flaskThickness+0.001,0>
                            bottomRadius - tmpX1 - tmpX2
                            material{flaskTexture}   
                        }
                        cutaway_textures
                    }
                    cutaway_textures
                }
                //inside torus to be cut out
                torus{
                    bottomRadius-tmpX1-tmpX2,
                    tmpM
                    material{flaskTexture} 
                    translate<0,bottomRoundness,0>
                }
                //trimming to bottom Roundness
                //outside space to be cut
                difference{
                    cylinder{
                        <0,-0.01,0>
                        <0,tmpY4,0>
                        bottomRadius+0.01
                        material{flaskTexture}   
                    }
                    cylinder{
                        <0,-0.02,0>
                        <0,tmpY2+flaskThickness+0.1,0>
                        bottomRadius - tmpX1 - tmpX2
                        material{flaskTexture}   
                    }
                    cone {
                        <0,bottomRoundness,0>,
                        bottomRadius - tmpX1 - tmpX2,
                        <0,tmpY4+0.000001,0>,
                        bottomRadius - tmpX5
                        material{flaskTexture}   
                    }
                    torus{
                        bottomRadius - tmpX4, 
                        bottomRoundness
                        material{flaskTexture} 
                        translate<0,bottomRoundness,0>
                    }
                    cutaway_textures
                }
            }
        }
        //inside cyl roundnesses to be cut out
        merge{
            //top
            difference{
                cone{
                    <0,bottomHeight + cylinderHeight - tmpY,0>
                    cylinderRadius + topCylRoundness
                    <0,bottomHeight + cylinderHeight - tmpY + tmpY7,0>
                    cylinderRadius - flaskThickness
                    material {flaskTexture}
                }
                torus{
                    cylinderRadius + topCylRoundness, 
                    topCylRoundness + flaskThickness-0.000001
                    translate <0, bottomHeight + cylinderHeight - tmpY, 0> // <x, y, z>
                    material {flaskTexture}
                }
                cutaway_textures
            }
            //bottom
            difference{
                cone{
                    <0,bottomHeight + tmpY6,0>
                    cylinderRadius + bottomCylRoundness
                    <0,bottomHeight + tmpY6 - tmpY8,0>
                    cylinderRadius - flaskThickness
                    material {flaskTexture}
                }
                torus{
                    cylinderRadius + bottomCylRoundness, 
                    bottomCylRoundness + flaskThickness+ 0.0001
                    translate <0, bottomHeight + tmpY6, 0> // <x, y, z>
                    material {flaskTexture}
                }
                cutaway_textures
            }

        }
    }
    //top-cylinder roundness
    difference{
        intersection{
            cone{
                <0,bottomHeight + cylinderHeight - tmpY,0>
                cylinderRadius + topCylRoundness
                <0,bottomHeight + cylinderHeight - tmpY + tmpY7,0>
                cylinderRadius - flaskThickness
                material {flaskTexture}
            }
            torus{
                cylinderRadius + topCylRoundness, 
                topCylRoundness + flaskThickness
                translate <0, bottomHeight + cylinderHeight - tmpY, 0> // <x, y, z>
                material {flaskTexture}
            }
            cutaway_textures
        }
        torus{
            cylinderRadius + topCylRoundness, topCylRoundness
            translate <0, bottomHeight + cylinderHeight - tmpY, 0> // <x, y, z>
            material {flaskTexture}
        }
        cutaway_textures
    }   
    //bottom-cylinder roundness
    difference{
        intersection{
            cone{
                <0,bottomHeight + tmpY6,0>
                cylinderRadius + bottomCylRoundness
                <0,bottomHeight + tmpY6 - tmpY8,0>
                cylinderRadius - flaskThickness
                material {flaskTexture}
            }
            torus{
                cylinderRadius + bottomCylRoundness, 
                bottomCylRoundness + flaskThickness
                translate <0, bottomHeight + tmpY6, 0> // <x, y, z>
                material {flaskTexture}
            }
            cutaway_textures
        }
        torus{
            cylinderRadius + bottomCylRoundness, bottomCylRoundness
            translate <0, bottomHeight + tmpY6, 0> // <x, y, z>
            material {flaskTexture}
        }
        cutaway_textures
    }
}
// box{
//     <-100,flaskThickness+0.001,100>
//     <100,flaskThickness/2,-100>
//     texture{flaskTexture}
// }

// box{
//     <-100,bottomHeight/2,100>
//     <100,100,-100>
//     texture{flaskTexture}
// }
#end

#macro flaskW2Textures(
    topRoundness,
    topCylRoundness,
    topRadius,
    topHeight,
    
    bottomRoundness
    bottomCylRoundness
    bottomRadius,
    bottomHeight,

    cylinderHeight,
    cylinderRadius,

    flaskThickness,

    flaskTexture,
    cylinderTexture,
    altTextureH1,
    altTextureH2
)

difference{
    merge{
        difference{
            flask(
                topRoundness,
                topCylRoundness,
                topRadius,
                topHeight,
                
                bottomRoundness
                bottomCylRoundness
                bottomRadius,
                bottomHeight,

                cylinderHeight,
                cylinderRadius,

                flaskThickness,

                flaskTexture
            )
            cylinder{
                <0, altTextureH1+0.0001, 0>
                <0, altTextureH2-0.0001, 0>
                bottomRadius +0.0001
            }
            cutaway_textures
        }
        intersection{
            flask(
                topRoundness,
                topCylRoundness,
                topRadius,
                topHeight,
                
                bottomRoundness
                bottomCylRoundness
                bottomRadius,
                bottomHeight,

                cylinderHeight,
                cylinderRadius,

                flaskThickness,

                cylinderTexture
            )
            cylinder{
                <0, altTextureH1, 0>
                <0, altTextureH2, 0>
                bottomRadius +0.0001
                material{cylinderTexture}
            }
            cutaway_textures
        }
    }
    // box{
    //     <-100,-1,-100>
    //     <100,100,0>
    // }
    // cutaway_textures
}

#end


// #local fsize = 0.75;
// object{
// flaskW2Textures(
//     0.1  * fsize,       // topRoundness
//     3    * fsize,       // topCylRoundness
//     1.5  * fsize,       // topRadius
//     1.5  * fsize,       // topHeight

//     1.2  * fsize,       // bottomCylRoundness
//     0.33 * fsize,       // bottomRoundness
//     2.6  * fsize,       // bottomRadius
//     5    * fsize,       // bottomHeight

//     1.3  * fsize,       // cylinderHeight,
//     0.77 * fsize,       // cylinderRadius,

//     0.16 * fsize,       // flaskThickness

//     // texture{pigment{color Yellow}},   // flaskTexture,
//     // texture{pigment{color Red}},   // flaskTexture,
//     texture{T_Glass3},    // cylinderTexture
//     texture{T_Glass4},    // cylinderTexture

//     4.8  * fsize,       // altTextureH1,
//     6.5  * fsize        // altTextureH2

// )translate<0,0.0001,0>
// }
// camera { orthographic
//     location <0, 5,-7>
//     look_at <0,2.5,0>
//     // location <0, 7,0>
//     // look_at <0,0,0>
// }
// light_source {
//     <-15, 30, -2>
//     color rgb <1, 1, 1>
// }
// light_source {
//     <0, 5, -7>
//     color rgb <1, 1, 1>
// }



// plane{ // Floor
//     <0,1,0>, 0 //Normal and distance
//     texture{ //T_Wood5
//         pigment{color Black}
//         finish {
//             reflection 0.3
//             phong .75
//             phong_size 20
//         } 
//     } 
//     rotate<0,30,0>
// }  

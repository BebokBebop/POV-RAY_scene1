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

    #local sinBottomAngle = 
    bottomHeight 
    / sqrt(
        bottomHeight*bottomHeight 
        + 
        (bottomRadius - cylinderRadius)
        *(bottomRadius - cylinderRadius)
    );
    #local cosBottomAngle = 
    (bottomRadius - cylinderRadius) 
    / sqrt(
        bottomHeight*bottomHeight 
        + 
        (bottomRadius - cylinderRadius)
        *(bottomRadius - cylinderRadius)
    );
    #local tanBottomAngle = bottomHeight / (bottomRadius - cylinderRadius); 
    #local tmpX1 = flaskThickness / tan(asin(sinBottomAngle)/2);

    #local tmpM = bottomRoundness - flaskThickness;
    //#local tanHalfBottomAngle = 
    //bottomHeight/2 / bottomRadius - cylinderRadius;
    #local tmpHH = tmpM*cosBottomAngle;
    #local tanHalfBottomAngle = tan(asin(sinBottomAngle)/2);
    #local tmpX2 = tmpM / tanHalfBottomAngle;
    #local tmpY2 = tmpX2*sinBottomAngle;
    #local tmpX3 = tmpX2 *cos(asin(sinBottomAngle));

    #local tmpX4 = bottomRoundness / tanHalfBottomAngle;
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
                }
                //inside 
                cone{
                    <0,bottomHeight + cylinderHeight + topHeight+0.0001,0>,
                    topRadius - flaskThickness/sinTopAngle,    
                    <0,bottomHeight + cylinderHeight-0.0001 , 0>,
                    cylinderRadius - flaskThickness/sinTopAngle
                }
                //top rounding
                difference{
                    cylinder{
                        <0,bottomHeight + cylinderHeight + topHeight + 0.001,0>,
                        <0,bottomHeight + cylinderHeight + topHeight - topTorheight, 0>,
                        topRadius
                    }
                    cylinder{
                        <0,bottomHeight + cylinderHeight + topHeight + 0.001,0>,
                        <0,bottomHeight + cylinderHeight + topHeight - topTorheight, 0>,
                        topRadius -tmpX - tmpZ
                    }
                    torus{
                        topTorBigRad,
                        topTorSmallRad
                        translate <0, 
                            bottomHeight + cylinderHeight + topHeight - topTorSmallRad
                            //+topTorSmallRad
                            , 
                        0> // <x, y, z>
                    }
                }
            }         
            //cylinder
            difference{
                cylinder{
                    <0,bottomHeight,0>
                    <0,bottomHeight+cylinderHeight, 0>
                    cylinderRadius 
                }      
                cylinder{
                    <0,bottomHeight - 0.01,0>
                    <0,bottomHeight + cylinderHeight + 0.01, 0>
                    cylinderRadius - flaskThickness   
                }
            }
            //bottom cone
            difference{
                //filled
                cone{
                    <0,0,0>, 
                    bottomRadius,
                    <0,bottomHeight,0>,
                    cylinderRadius
                }
                //to be cut
                difference{
                    //inside cone
                    cone{
                        <0,flaskThickness,0>, 
                        bottomRadius-tmpX1,
                        <0,bottomHeight+0.0000001,0>,
                        cylinderRadius-flaskThickness/sinBottomAngle
                    }
                    //to be trimmed by torus
                    difference{
                        cylinder{
                            <0,0,0>
                            <0,tmpM+tmpHH+flaskThickness,0>
                            bottomRadius+0.001
                        }
                        cylinder{
                            <0,-0.001,0>
                            <0,tmpM+tmpHH+flaskThickness+0.001,0>
                            bottomRadius - tmpX1 - tmpX2
                        }
                    }
                }
                //inside torus to be cut out
                torus{
                    bottomRadius - tmpX4,
                    tmpM
                    translate<0,bottomRoundness,0>
                }
                //trimming to bottom Roundness
                //outside space to be cut
                difference{
                    cylinder{
                        <0,-0.01,0>
                        <0,tmpY4,0>
                        bottomRadius+0.01
                    }
                    cylinder{
                        <0,-0.02,0>
                        <0,tmpY4+0.01,0>
                        bottomRadius - tmpX1 - tmpX2
                    }
                    // cone {
                    //     <0,bottomRoundness,0>,
                    //     bottomRadius - tmpX1 - tmpX2,
                    //     <0,tmpY4+0.000001,0>,
                    //     bottomRadius - tmpX5
                    // }
                    torus{
                        bottomRadius - tmpX4, 
                        bottomRoundness
                        translate<0,bottomRoundness,0>
                    }
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
                }
                torus{
                    cylinderRadius + topCylRoundness, 
                    topCylRoundness + flaskThickness-0.000001
                    translate <0, bottomHeight + cylinderHeight - tmpY, 0> // <x, y, z>
                }
            }
            //bottom
            difference{
                cone{
                    <0,bottomHeight + tmpY6,0>
                    cylinderRadius + bottomCylRoundness
                    <0,bottomHeight + tmpY6 - tmpY8,0>
                    cylinderRadius - flaskThickness
                }
                torus{
                    cylinderRadius + bottomCylRoundness, 
                    bottomCylRoundness + flaskThickness+ 0.0001
                    translate <0, bottomHeight + tmpY6, 0> // <x, y, z>
                }
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
            }
            torus{
                cylinderRadius + topCylRoundness, 
                topCylRoundness + flaskThickness
                translate <0, bottomHeight + cylinderHeight - tmpY, 0> // <x, y, z>
            }
        }
        torus{
            cylinderRadius + topCylRoundness, topCylRoundness
            translate <0, bottomHeight + cylinderHeight - tmpY, 0> // <x, y, z>
        }
    }   
    //bottom-cylinder roundness
    difference{
        intersection{
            cone{
                <0,bottomHeight + tmpY6,0>
                cylinderRadius + bottomCylRoundness
                <0,bottomHeight + tmpY6 - tmpY8,0>
                cylinderRadius - flaskThickness
            }
            torus{
                cylinderRadius + bottomCylRoundness, 
                bottomCylRoundness + flaskThickness
                translate <0, bottomHeight + tmpY6, 0> // <x, y, z>
            }
        }
        torus{
            cylinderRadius + bottomCylRoundness, bottomCylRoundness
            translate <0, bottomHeight + tmpY6, 0> // <x, y, z>
        }
    }
    material {flaskTexture}
}
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
            box{
                <-100,-1,-100>
                <100,flaskThickness+0.002,100>
                material{flaskTexture}
            }
            cutaway_textures
        }

        //neck
        intersection{
            difference{
                object{
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
                    scale <1.01,0,1.01>
                }
                object{
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

                        flaskThickness*2,

                        cylinderTexture
                    )
                    scale <1.005,0,1.005>
                }

                cutaway_textures
            }
            cylinder{
                <0, altTextureH1, 0>
                <0, altTextureH2, 0>
                bottomRadius +0.0001
                material{cylinderTexture}
            }
            cutaway_textures
        }
        //bottom
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

                flaskBottomTexture
            )
            box{
                <-100,-1,-100>
                <100,flaskThickness+0.002,100>
                material{flaskBottomTexture}
            }
            cutaway_textures
        }
    }
}
#end
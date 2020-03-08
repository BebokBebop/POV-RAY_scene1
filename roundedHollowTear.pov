#include "shapes3.inc"

#macro hollowTear (bigRadius, smallRadius, cutRadius, angleA, height, thic) //TOKENS... #end
difference{
    //the filling
    merge{
        difference{
            //big
            cylinder {
                <0,0,0>,
                <0,height,0>,
                bigRadius
            }
            merge{  //to be cut
                //cut
                cylinder {
                    <
                        bigRadius - smallRadius - cos(angleA) * (smallRadius + cutRadius),
                        -0.1,
                        sin(angleA) * (smallRadius + cutRadius)
                    >,
                            <
                        bigRadius - smallRadius - cos(angleA) * (smallRadius + cutRadius),
                        height+0.1,
                        sin(angleA) * (smallRadius + cutRadius)
                    >,
                    cutRadius
                }
                //box
                prism {-0.1, height+0.2, 5
                    <-bigRadius,bigRadius>
                    <bigRadius,bigRadius>
                    <bigRadius, 0>
                    <bigRadius - smallRadius, 0>
                    <-bigRadius, tan(angleA) * (2*bigRadius - smallRadius)>
                    translate<0,-0.1,0>
                }
            }
        }
        //small
        cylinder {
            <bigRadius - smallRadius,0,0>,
            <bigRadius - smallRadius,height,0>,
            smallRadius
        }
    }

    //to be hollowed
    merge{
        difference{
            //big
            cylinder {
                <0,0,0>,
                <0,height+0.2,0>,
                bigRadius - thic
            }
            merge{  //to be cut
                //cut
                cylinder {
                    <
                        bigRadius - smallRadius - cos(angleA) * (smallRadius + cutRadius),
                        -0.1,
                        sin(angleA) * (smallRadius + cutRadius)
                    >,
                            <
                        bigRadius - smallRadius - cos(angleA) * (smallRadius + cutRadius),
                        height+0.2+0.1,
                        sin(angleA) * (smallRadius + cutRadius)
                    >,
                    cutRadius + thic
                }
                //tip rounding
                //cylinder{
                //
                //}
                //box
                prism {-0.1, height+0.2+0.2, 5
                    <-bigRadius,bigRadius>
                    <bigRadius,bigRadius>
                    <bigRadius, 0>
                    <bigRadius - smallRadius, 0>
                    <-bigRadius, tan(angleA) * (2*bigRadius - smallRadius)>
                    translate<0,-0.1,0>
                }
            }
        }
        //small
        cylinder {
            <bigRadius - smallRadius,0,0>,
            <bigRadius - smallRadius,height+0.2,0>,
            smallRadius -thic
        }
        translate<0,-0.1,0>
    }
}
#end

#macro insideRoundedHollowTear (
    bigRadius, 
    smallRadius, 
    cutRadius, 
    angleA, 
    height, 
    thic) //TOKENS... #end
intersection{
    //the filling
    merge{
        difference{
            //big
            cylinder {
                <0,0,0>,
                <0,height,0>,
                bigRadius
            }
            merge{  //to be cut
                //cut
                cylinder {
                    <
                        bigRadius - smallRadius - cos(angleA) * (smallRadius + cutRadius),
                        -0.1,
                        sin(angleA) * (smallRadius + cutRadius)
                    >,
                            <
                        bigRadius - smallRadius - cos(angleA) * (smallRadius + cutRadius),
                        height+0.1,
                        sin(angleA) * (smallRadius + cutRadius)
                    >,
                    cutRadius
                }
                //box
                prism {-0.1, height+0.2, 5
                    <-bigRadius,bigRadius>
                    <bigRadius,bigRadius>
                    <bigRadius, 0>
                    <bigRadius - smallRadius, 0>
                    <-bigRadius, tan(angleA) * (2*bigRadius - smallRadius)>
                    translate<0,-0.1,0>
                }
            }
        }
        //small
        cylinder {
            <bigRadius - smallRadius,0,0>,
            <bigRadius - smallRadius,height,0>,
            smallRadius
        }
    }

    //to be intersected
}
#end

#macro roundedHollowTear (
    bigRadius, 
    smallRadius, 
    cutRadius, 
    angleA, 
    height, 
    thic, 
    roundness, 
    insideMetalOutSticking,
    tailRoundnessOutside, 
    tailRoundnessInside,
    texture1, 
    texture2) //TOKENS... #end
#local cx = bigRadius - smallRadius - cos(angleA) * (smallRadius + cutRadius);
#local cy = sin(angleA) * (smallRadius + cutRadius);

//used for inside tail roundness
#local a = sqrt(cx*cx + cy*cy);
#local b = bigRadius - thic - tailRoundnessInside;
#local c = cutRadius + thic + tailRoundnessInside;

//used for outside tail roundness
#local d = bigRadius - tailRoundnessOutside;
#local e = cutRadius + tailRoundnessOutside;

//used to rotate coordinates of the rounding circles into their place
#local angleBC = asin(abs(cy/cx));
#local cosO = abs(cx)/a;
#local sinO = abs(cy)/a;

//calculating coords of inside tail rounder
#local tri_x_Temp = -(a*a - c*c + b*b)/2/a;
#local tri_y_Temp = -sqrt(b*b - tri_x_Temp*tri_x_Temp);
//rotating it into place
#local tri_x = tri_x_Temp * cosO + tri_y_Temp * sinO;
#local tri_y = tri_y_Temp * cosO - tri_x_Temp * sinO;

//calculating coords of outside tail rounder
#local tro_x_Temp = -(a*a - e*e + d*d)/2/a;
#local tro_y_Temp = -sqrt(d*d - tro_x_Temp*tro_x_Temp);
//rotating it into place
#local tro_x = tro_x_Temp * cosO + tro_y_Temp * sinO;
#local tro_y = tro_y_Temp * cosO - tro_x_Temp * sinO;

//angle between bigCylinder and insideTailRounder
#local cosBI = abs(tri_x)/b;
#local sinBI = abs(tri_y)/b;

//angle between bigCylinder and outsideTailRounder
#local cosBO = abs(tro_x)/d;
#local sinBO = abs(tro_y)/d;

merge{

    difference{
        merge{     
            difference{
                //big ring
                object {
                    Round_Cylinder_Tube(
                        <0,-insideMetalOutSticking,0>, // start
                        <0,height+insideMetalOutSticking,0>, // end
                        bigRadius-thic+2*roundness, // major radius
                        roundness, // border radius
                        0, //  1 = filled; 0 = open
                        0  //  Merge_On,
                    )
                    //texture{ pigment{ color rgb<1,1,1>}
                    //         finish { phong 0.1}
                    //} // end texture
                    texture{ texture2}
                }
                prism {-0.1, height+0.2+0.2, 5
                    <cx, cy>,
                    <-bigRadius,bigRadius>,
                    <-bigRadius,tri_y>,
                    <tri_x - (tailRoundnessInside+thic)*cosBI, tri_y-(tailRoundnessInside+thic)*sinBI>,
                    <tri_x, tri_y>
                translate<0,-0.1,0>
                } 
            }
            //add outside rim
            difference{
                cylinder {
                    <0,0,0>,
                    <0,height,0>,
                    bigRadius
                    texture{ texture1}
                }
                
                merge{
                    difference{
                        cylinder {
                            <0,-0.1,0>,
                            <0,height+0.1,0>,
                            bigRadius - thic +roundness
                            texture{ texture1}
                        }
                        prism {-0.1, height+0.2+0.2, 5
                            <cx, cy>,
                            <-bigRadius,bigRadius>,
                            <-bigRadius,-bigRadius>,
                            <tri_x - (tailRoundnessInside+thic)*cosBI, tri_y-(tailRoundnessInside+thic)*sinBI>,
                            <tri_x, tri_y>
                            translate<0,-0.1,0>
                            texture{ texture1}
                        }
                    }
                    cylinder{
                        <tri_x,-0.1,tri_y>,
                        <tri_x,height+0.1,tri_y>,
                        tailRoundnessInside+roundness
                    }
                }
            }
            
            //rounded part of the cut cylinder
            intersection{
                //cut rounded cylinder filled
                difference{
                    merge{
                        object {
                            Round_Cylinder_Tube(
                                <
                                    bigRadius - smallRadius - cos(angleA) * (smallRadius + cutRadius),
                                    -insideMetalOutSticking,
                                    sin(angleA) * (smallRadius + cutRadius)
                                >,
                                <
                                    bigRadius - smallRadius - cos(angleA) * (smallRadius + cutRadius),
                                    height+insideMetalOutSticking,
                                    sin(angleA) * (smallRadius + cutRadius)
                                >,
                                cutRadius + thic, // major radius
                                roundness, // border radius
                                0, //  1 = filled; 0 = open
                                0  //  Merge_On,
                            )
                            //texture{ pigment{ color rgb<1,1,1>}
                            //         finish { phong 0.1}
                            //} // end texture
                            texture{ texture2}
                        }
                        cylinder {
                            <
                                bigRadius - smallRadius - cos(angleA) * (smallRadius + cutRadius),
                                0,
                                sin(angleA) * (smallRadius + cutRadius)
                            >,
                            <
                                bigRadius - smallRadius - cos(angleA) * (smallRadius + cutRadius),
                                height,
                                sin(angleA) * (smallRadius + cutRadius)
                            >,
                            cutRadius+thic-roundness
                            texture{ texture1}
                        }   
                    }
                    prism {-0.1, height+0.2+0.2, 5
                        <cx, cy>,
                        <-bigRadius,bigRadius>,
                        <-bigRadius,tri_y>,
                        <tri_x - (tailRoundnessInside+thic)*cosBI, tri_y-(tailRoundnessInside+thic)*sinBI>,
                        <tri_x, tri_y>
                        translate<0,-0.1,0>
                    } 
                }
                //intersect with big cylinder only
                cylinder {
                    <0,-0.1,0>,
                    <0,height+0.1,0>,
                    bigRadius
                    texture{ texture1}
                }
            }      
        }
        //cut out prism and inside of cut cylinder
        merge{
            cylinder {
                <
                    bigRadius - smallRadius - cos(angleA) * (smallRadius + cutRadius),
                    -0.1,
                    sin(angleA) * (smallRadius + cutRadius)
                >,
                <
                    bigRadius - smallRadius - cos(angleA) * (smallRadius + cutRadius),
                    height+0.1,
                    sin(angleA) * (smallRadius + cutRadius)
                >,
                cutRadius
                texture{ texture1}
            }
            prism {-0.1, height+0.2+0.2, 5
                <-bigRadius,bigRadius>
                <bigRadius,bigRadius>
                <bigRadius, 0>
                <bigRadius - smallRadius, 0>
                <-bigRadius, tan(angleA) * (2*bigRadius - smallRadius)>
                translate<0,-0.1,0>
            }
            prism{-0.1, height+0.2, 5
                <cx, cy>,
                <-bigRadius,bigRadius>,
                <-bigRadius,tro_y - (tailRoundnessOutside)*sinBO>,
                <
                    tro_x - (tailRoundnessOutside)*cosBO, 
                    tro_y - (tailRoundnessOutside)*sinBO
                >,
                <tro_x, tro_y>
                translate<0,-0.1,0>
                texture{texture1}
            }
        }       
    }
    //small rounded circle intersecting with prism
    intersection{
        merge{
            object {
                Round_Cylinder_Tube(
                    <bigRadius - smallRadius,-insideMetalOutSticking,0>,
                    <bigRadius - smallRadius,height+insideMetalOutSticking,0>,
                    smallRadius-thic+roundness*2, // major radius
                    roundness, // border radius
                    0, //  1 = filled; 0 = open
                    0  //  Merge_On,
                )
                //texture{ pigment{ color rgb<1,1,1>}
                //         finish { phong 0.1}
                //} // end texture
            
                texture{ texture2}
            }
            // add outside rim
            difference{
                cylinder {
                    <bigRadius - smallRadius,0,0>,
                    <bigRadius - smallRadius,height,0>,
                    smallRadius
                    texture{ texture1}
                }
                cylinder {
                    <bigRadius - smallRadius,-0.1,0>,
                    <bigRadius - smallRadius,height+0.1,0>,
                    smallRadius - thic + roundness
                    texture{ texture1}
                }
            }
        }
        prism {-0.1, height+0.2+0.2, 5
            <-bigRadius,bigRadius>
            <bigRadius,bigRadius>
            <bigRadius, 0>
            <bigRadius - smallRadius, 0>
            <-bigRadius, tan(angleA) * (2*bigRadius - smallRadius)>
            translate<0,-0.1,0>
            texture{ texture1}
        }
    }

    //tip rounder inside
    merge{
        intersection{
            object {
                Round_Cylinder_Tube(
                    <tri_x, -insideMetalOutSticking, tri_y>,
                    <tri_x, height+insideMetalOutSticking, tri_y>,
                    tailRoundnessInside+roundness*2, // major radius
                    roundness, // border radius
                    0, //  1 = filled; 0 = open
                    0  //  Merge_On,
                )
                texture{ texture2}
            }
            prism {-0.1, height+0.2+0.2, 5
                <cx, cy>,
                <-bigRadius,bigRadius>,
                <-bigRadius,tri_y>,
                <tri_x - (tailRoundnessInside+thic)*cosBI, tri_y-(tailRoundnessInside+thic)*sinBI>,
                <tri_x, tri_y>
            translate<0,-0.1,0>
            } 
            // prism{-0.1, height+0.2+0.2, 3
            //     <
            //         -(b) * cos( acos( (a*a + b*b - c*c)/(2*a*b) ) - angleBC ),
            //         -(b) * sin( acos( (a*a + b*b - c*c)/(2*a*b) ) - angleBC )
            //     >,
            //     <cx,cy>
            //     <
            //         -(b) * cos( acos( (a*a + b*b - c*c)/(2*a*b) ) - angleBC ),
            //         -(b) * sin( acos( (a*a + b*b - c*c)/(2*a*b) ) - angleBC )
            //     >
            //     translate<0,-0.1,0>
            // }
        }
    }

    //tip rounder outside 
    cylinder{
        <tro_x, 0, tro_y>,
        <tro_x, height, tro_y>,
        tailRoundnessOutside
        texture{texture1}
    }
}

#end
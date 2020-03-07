#include "colors.inc"      
#include "glass.inc"    
#include "woods.inc"
#include "metals.inc"

//flask  ///////////////////////////////////////////////

#macro Raster(RScale, RLine)
    pigment{gradient x
        scale RScale
        color_map{
        [0.000   color rgbt<0,0,0,0>]
        [0+RLine color rgbt<0,0,0,0>]
        [0+RLine color rgbt<1,1,1,1>]
        [1-RLine color rgbt<1,1,1,1>]
        [1-RLine color rgbt<0,0,0,0>]
        [1.000   color rgbt<0,0,0,0>]
        }}
#end // of macro

#macro flashNeckBlurMacro( BlurAmount2, BlurSamples2 )
texture { average 
    texture_map {
        #local Ind = 0;
        #local S = seed(0);
        #while(Ind < BlurSamples2)
        [1 
            pigment { rgbft <.8,.8,.8,.8,.03> }
            finish { 
                diffuse albedo 0.7 
                //fresnel
                //reflection .3
                //roughness .01
                //brilliance 2
               // ior 1.5
            }
            // This is the actual trick:
            normal { 
                bumps BlurAmount2 
                translate <rand(S),rand(S),rand(S)>*100
                scale 1000 
                //scale 1000
            }
        ]
        #declare Ind = Ind+1;
        #end
    }
}
#end

#declare flaskNeckBlur = flashNeckBlurMacro( .3, 3 )

#declare FlaskTexture1 = 
material{
    texture{
        pigment {color rgb .9
            transmit .98
        }
        finish {
            //specular 0.4
            reflection .05
            //refraction 0.5
            specular .9
            roughness .0025
            ior 1.5
            //crand 0.02
        }
        normal { 
            bumps 0.14
            scale 1.5 
            rotate<3,30,3> 
        }
        //scale 1000000
    }
}
#declare FlaskTexture2 =
material{
    texture {
        flaskNeckBlur

        // normal {
        //     crackle, 0.010
        //     form < -1.000, 1.000, 0.000 >
        //     metric 2000.000
        //     offset 0.000
        //     scale     <0.010,0.010,0.010>  /* Scale micro-normals. */
        // }
    }
    // interior{
    //     //ior                 1.500
    //     caustics            0.000
    //     //dispersion          2.000
    //     //dispersion_samples  15.000
    //     fade_power          2.000
    //     fade_distance       2.000
    //     fade_color          rgb <0.000,0.000,0.000>
    // }
}

#declare FlaskTexture3 =
material{
    texture {
        pigment {
            colour rgbft <.85,.85,.85,.8,.05>
        /* increase t for more transparency */
        }
        normal {
            crackle, 0.010
            form < -1.000, 1.000, 0.000 >
            metric 2.000
            offset 0.000
            scale     <0.010,0.010,0.010>  /* Scale micro-normals. */
        }
        finish {
            ambient     rgb <0.100,0.100,0.100>*2.500
            brilliance  1.000
            diffuse     0.300
            phong       0.000
            phong_size  1.000
            specular    0.078
            roughness   1.000
            reflection {
                rgb <0.015,0.015,0.015>, rgb <0.025,0.025,0.025>
                fresnel   1
                falloff   0.000
                exponent  1.000
                metallic  0.000
            }
        }
    }

    interior{
        //ior                 1.500
        caustics            0.000
        dispersion          2.000
        dispersion_samples  15.000
        fade_power          2.000
        fade_distance       2.000
        fade_color          rgb <0.000,0.000,0.000>
    }
}


//tear  ///////////////////////////////////////////////
#declare tearTextureOutside = 
texture{pigment {color Yellow }}

#declare tearTextureInside = 
texture {
    T_Chrome_1A
    finish {
        reflection 0.01
        phong 4
        phong_size 20
    }
        
}


//table  ///////////////////////////////////////////////

#declare myWoodPigment = 
pigment {        
    wood        
    color_map {          
    [0.0 color rgb <.9,.05,0>*.3]
    [0.3 color rgb <.9,.05,0>*.5]
    [0.6 color rgb <.9,.05,0>*.7]
    }        
    turbulence .05        
    scale <.1, .6, .5>
}
#declare tableTexture =
texture{
    pigment{
        brick     
        pigment{color Black}
        pigment {myWoodPigment
            rotate<0,0,-90>
        } 

        brick_size <1,2.5,20>
        mortar 0.0125
    }
    rotate<0,0,90>

    finish{
        phong 0.25
        reflection 0.1
    }
}
#declare tableBlurTexture = 
texture{ 
    #declare BlurAmount = .03; // Amount of blurring 
    #declare BlurSamples = 40; // How many rays to shoot 
    average texture_map{ 
        #declare Ind = 0; 
        #declare S = seed(0); 
        #while(Ind < BlurSamples) 
            [1 
            // The pigment of the object: 
            tableTexture
            normal {
                bumps BlurAmount 
                translate <rand(S),rand(S),rand(S)>*100
                scale 1000 
            } 

            ] 
            #declare Ind = Ind+1; 
        #end
    }
}

//bowl  ///////////////////////////////////////////////
#declare bowl_color = rgb<.9,.3,.2>*.3;
#declare bowl_color2 = rgb<.9,.3,.2>*.2;
#declare bowl_texture_out = 
texture { 
    wrinkles scale 2 //warp {reset_children}
    texture_map {
        [0 
            pigment { bowl_color}
            finish {
                ambient 0 
                diffuse 0.3 
                reflection bowl_color
                
                //reflection_max 0.6
                //reflection_min 0.3 
                //reflect_metallic 
                metallic
                phong 5
                phong_size 10 

                //specular 1 
                //roughness 0.001
            }
            normal {
                dents 0.02 scale 0.05
            }
        ]
        [1 
            pigment {bowl_color2}
            finish {
                ambient 0 
                diffuse 0.65 
                //reflection_max 0.5
                //reflection_min 0.2 
                //reflect_metallic 
                //metallic
                phong 2
                phong_size 15   
                //specular .3
                //roughness 0.09
            }
            normal { 
                bump_map { 
                    png "BrushedMetal.png" 
                    map_type 2 
                    interpolate 2
                }
                translate <0,-0.5,0> 
                scale y*.15
                bump_size .04
            }
        ]
    } 
}
#declare bowl_texture_in = 
texture { 
    wrinkles scale 2 //warp {reset_children}
    texture_map {
        [0 
            pigment { bowl_color}
            finish {
                ambient 0 
                diffuse 0.6
                reflection {
                    bowl_color2*.2
                    //0.03
                    //.4
                }
                
                //reflection_max 0.6
                //reflection_min 0.3 
                //reflect_metallic 
                metallic
                // phong 5
                // phong_size 10 

                specular 1
                roughness 0.0001
            }
            normal {
                dents 0.02 scale 0.05
            }
        ]
        [1 
            pigment {bowl_color2}
            finish {
                ambient 0 
                diffuse 0.65 
                //reflection_max 0.5
                //reflection_min 0.2 
                //reflect_metallic 
                //metallic
                phong 1.5
                phong_size 18     
                //specular .3
                //roughness 0.09
            }
            normal { 
                bump_map { 
                    png "BrushedMetal.png" 
                    map_type 2 
                    interpolate 2
                }
                translate <0,-0.5,0> 
                scale y*.15
                bump_size .04
            }
        ]
    } 
}

//prism  ///////////////////////////////////////////////
#declare prismMaterial = 
material{
    texture{
        pigment {
            color rgb<1,.9,.8>*.3
            transmit .7
        }
        finish {
            //specular 0.4
            reflection 0.2
            phong 0.01
            ior 1.5
            //crand 0.02
        }
        normal { 
            bumps 0.15
            scale .18
            rotate<3,30,3> 
        }
    }
}  
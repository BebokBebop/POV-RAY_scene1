#include "colors.inc"      
#include "glass.inc"    
#include "woods.inc"
#include "metals.inc"

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

#declare f_reflective_metal = 
finish {
    ambient .2 
    diffuse .2
    specular 1.5 
    roughness .02 
    brilliance 2
    reflection { .6 metallic 1 } metallic
}

#macro flashNeckBlurMacro( BlurAmount2, BlurSamples2 )
texture { average 
    texture_map {
        #local Ind = 0;
        #local S = seed(0);
        #while(Ind < BlurSamples2)
            [1 // The pigment of the object:
            pigment { rgbt <.8,.8,.8,.9> }
            // The surface finish:
            finish { 
                diffuse .2
                //reflection .3
                //roughness .01
                //brilliance 2
               // ior 1.5
            }
            // This is the actual trick:
            normal { wood ramp_wave
                    rotate rand(S)*30 turbulence .6
                    bump_size -BlurAmount2
                    translate <rand(S),rand(S),rand(S)>*.02
                    scale .002
                    //scale 1000
            }
        ]
        #declare Ind = Ind+1;
        #end
    }
}
#end

#declare flaskNeckBlur = flashNeckBlurMacro( .01, 1 )

#declare FlaskTexture1 = 
material{
    texture{
        pigment {color rgbt<.5,.5,.5,.9>}
        //normal {bumps 0.001}
        finish {
            //specular 0.4
            reflection 0.05
            //refraction 0.5
            phong 0.01
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
        pigment {
            colour rgbft <.85,.85,.85,.6,.001>
        /* increase t for more transparency */
        }

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


// #declare FlaskTexture2 = 
// texture
// {
//     pigment{rgbt <1, 1, 1, 0.9>}
//     finish
//     {
//         diffuse 0.3
//         ambient 0.7
//         reflection {0.05 fresnel on}
//         phong 0.25
//         phong_size 20.0
//         ior 1.5
//     }
// }

#declare tearTextureOutside = 
texture{pigment {color Yellow }}

#declare tearTextureInside = 
 texture {
    T_Chrome_1A
    finish {
        reflection 0.1
        phong 4
        phong_size 20
    }
        
}

#declare BowlColor = rgb <.5, .19, .13>;
#declare PolishedBowlTexture =
    texture{
    pigment{color BowlColor } //P_Copper4
    finish {
        //ambient 0.30
        //brilliance 3
        diffuse 0.4
        metallic
        specular 0.70
        roughness 1/60
        reflection 0.05
        phong .3
        phong_size .001
    }
    normal { 
        bumps 0.05
        scale 0.8 
    }
}
#declare UnpolishedBowlTexture = 
texture{
    pigment{color BowlColor } //P_Copper4
    finish {
        //ambient 0.30
        //brilliance 3
        diffuse .64
        metallic
        specular 0.70
        roughness 1/60
        reflection 0.007
        phong .5
        phong_size .05
    }
    normal { 
        bumps 0.05
        scale 0.8 
    }
}
#declare BowlTextureOut = 
texture {
    bozo
    scale <3, .7, 3>
    rotate<0,30,0>
    texture_map {
        [0.3  UnpolishedBowlTexture] 
        [0.3  PolishedBowlTexture]
        [0.6  PolishedBowlTexture]
        [0.9  UnpolishedBowlTexture]
    }
    turbulence 0.08      
    //rotate<90,0,0>    
}


#declare BowlTextureIn = 
texture{
    T_Brass_1A
    finish {
        crand .1
        phong_size 1
        phong 1
    }
    normal { 
        bumps 0.1 
        scale 0.8 
    }
}
#declare myWoodPigment = 
pigment {        
    wood        
    color_map {          
        [0.0 color <.5,.2,.1>]          
        [0.9 color <.3,.2,.1>]          
        [1.0 color <.2,.1,.1>]       
    }        
    turbulence 0.05        
    scale <0.1, 0.6, 0.5>
}

#declare myWoodTexture =
texture{
    pigment{
        brick     
        pigment{color Black}
        pigment {myWoodPigment
            rotate<0,0,-90>
        } 

        brick_size <1,2.5,20>
        mortar 0.0125
    }rotate<0,0,90>
    // pigment {        
    //     wood        
    //     color_map {          
    //         [0.0 color <.5,.2,.1>]          
    //         [0.9 color <.3,.2,.1>]          
    //         [1.0 color <.2,.1,.1>]        
    //     }        
    //     turbulence 0.05        
    //     scale <0.1, 0.6, 0.5>
    // }
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
            myWoodTexture
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
#declare tableWoodTexture =
texture{
    pigment { myWoodPigment } 
    finish {
        diffuse 0.9
        //brilliance 1
        reflection 0.1
        phong .75
        phong_size 20
    }  
}
#declare tableTextureTint = 
texture{
    #declare brightnessT = 0.9;
    pigment{color <
        0.463 *brightnessT,
        0.039 *brightnessT,
        0.051 *brightnessT
    > 
    transmit 0.3
    }
}
#declare tableTexture = 
texture{

}
#include "colors.inc"      
#include "glass.inc"    
#include "woods.inc"
#include "metals.inc"

//flask  ///////////////////////////////////////////////

#declare FlaskNeckTexture1 = 
material{
    texture{
        pigment{
            rgb <1,.95,.55>*.88
            filter .5
        }
        finish{
            reflection{
                0
                0.1
                falloff 10
            }
            ambient 0 
            diffuse 1 
            specular .6
            roughness .0005
        }
    }
    interior{
        media{
            scattering {1 rgb 4}
        }
        ior 1.5
    }
}
#declare FlaskTexture1 = 
material{
    texture{
    pigment{ rgbf<.98,.98,.98,0.85>*1}
    finish { 
        ambient 0.0
        diffuse 0.15
        reflection 0.2
        specular 0.6
        roughness 0.005
        // phong 1 
        // phong_size 400
        reflection { 0.03, 1.0 fresnel on }
        //   conserve_energy
    }
    } // end of texture

    interior{ ior 1.5
        fade_power 1001
        fade_distance 0.5
        fade_color <0.8,0.8,0.8>
    } // end of interior


}

#declare FlaskTexture2 =
material {
    texture{
        pigment {
            rgb 1
            transmit .98
        }
        finish {
            reflection {
                0.05
                .9
                fresnel on
            }
            //specular 1
            //roughness .0008
            //blinn 1
            conserve_energy
        }
        normal{
            bumps 0.01
            scale .5
        }
    }
    interior {
        ior 1.5
        //media {
            //absorption 1
            //method 3
        //}
    }
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
#declare FlaskTexture4 =
material{   
    texture { 
        pigment{ 
            rgb 1 
            transmit .99
        }
        normal { bumps 0.1 scale 1.5} 
        finish { 
            ambient 0.9
            diffuse 0.1 
            reflection {
                0.005
                0.3
                falloff 1
                //fresnel on
            }
            specular 0.8 
            roughness 0.0003 
            phong 1 
            phong_size 400
            conserve_energy
            }
    } 
    interior{ 
        ior 1.5 
        caustics 0.5
    } 
}

#declare flaskBottomTexture =
material{   
    texture { 
        pigment{ 
            rgb 1 
            transmit .99
        }
        normal { 
            cylindrical .2 // bump depth
            sine_wave
            scale <3,1,3>
            turbulence 0.12
            //rotate x*90
            phase 0.9
            frequency 4
            //translate<-.5,0,0>
        } 
        finish { 
            ambient 0.9
            diffuse 0.1 
            reflection {
                0.005
                0.3
                falloff 1
                //fresnel on
            }
            specular 0.8 
            roughness 0.0003 
            phong 1 
            phong_size 400
            conserve_energy
            }
    } 
    interior{ 
        ior 1.5 
        caustics 0.5
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
    [0.0 color rgb <.9,.18,0>*.3]
    [0.3 color rgb <.9,.18,0>*.5]
    [0.6 color rgb <.9,.18,0>*.7]
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

//wall  ///////////////////////////////////////////////
#declare wallTexture =
    texture{
        pigment{
            color rgb <.81,1,0.08>
        }  
    finish {
        diffuse .9
        phong .1
        phong_size 30
    }
}

//bowl  ///////////////////////////////////////////////
#declare bowl_base =  rgb<.9,.18,.05>;
#declare bowl_color =  rgb<.7,.18,.05>*.8;
#declare bowl_color2 = bowl_base*.07;
#declare bowl_texture_out = 
texture { 
    wrinkles scale 2 //warp {reset_children}
    texture_map {
        [0 
            pigment { bowl_color}
            finish {
                ambient 0 
                diffuse 0.3 
                reflection {
                    bowl_color
                }
                metallic
                phong 20
                phong_size 10 
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
                ior 100
                reflection{
                    0.01
                    0.3
                    fresnel on
                }
                phong 2
                phong_size 15   
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
            pigment { bowl_color*.7}
            finish {
                ambient 0 
                diffuse 0.6
                reflection {
                    bowl_color2*.3
                    //0.03
                    //.4
                } 
                metallic

                specular 1
                roughness 0.0001
            }
            normal {
                dents 0.02 scale 0.05
            }
        ]
        [1 
            pigment {bowl_color2*.5}
            finish {
                ambient 0 
                diffuse .3 
                phong 1.5
                phong_size 18    
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

//pestle  ///////////////////////////////////////////////
#declare pestleWoodPigment = 
texture{
    pigment {        
        wood        
        color_map {          
            [0.0 color rgb <.5,.15,.1>*0.2]          
            [0.9 color rgb <.5,.2 ,.1>*0.27]          
            [1.0 color rgb <.5,.15,.1>*0.35]       
        }  
        turbulence 0.1       
        scale <0.08, 1, 0.08> 
    } 
    finish{
        diffuse .6
        phong .1
        phong_size 80
        specular .15 
        roughness .015 
    }
    normal {
        wood .1
        rotate  x*90
        scale <.1,1,1>
        turbulence 0.05   
    }
}
#declare handle_texture = texture {

    pigment {
        color rgb <0.40, 0.15, 0.1>*0.2
    }                   
    finish {
        crand 0.4
        diffuse 0.7
    }    
}

#declare handle_texture2 = texture {

    pigment {
        color rgb <0.45, 0.15, 0.1>*0.1
    }                   
    finish {
        crand 0.2 
        diffuse 0.7
    }    
}

//prism  ///////////////////////////////////////////////
#declare prismMaterial = 
material{
    texture{
        pigment {
            color rgb<1,.6,.5>*.3
            transmit .75
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
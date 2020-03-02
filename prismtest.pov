#include "colors.inc"      
#include "glass.inc"    
#include "shapes.inc"
#include "woods.inc"


#local size_prism = 5;
#local size_prism2 = 4;
difference { 
    prism{
        0,5, 6,
        <-size_prism,0>
        <-size_prism/2, sqrt(3)*(size_prism/2)>
        <size_prism/2, sqrt(3)*(size_prism/2) >
        <size_prism,0>
        <size_prism/2, -sqrt(3)*(size_prism/2) >
        <-size_prism/2, -sqrt(3)*(size_prism/2)>

        texture {
            pigment {
                color Yellow
            }
        }
    }      
prism{
    -0.00001,5.0001, 6,
    <-size_prism2,0>
    <-size_prism2/2, sqrt(3)*(size_prism2/2)>
    <size_prism2/2, sqrt(3)*(size_prism2/2) >
    <size_prism2,0>
    <size_prism2/2, -sqrt(3)*(size_prism2/2) >
    <-size_prism2/2, -sqrt(3)*(size_prism2/2)>

    texture {
        pigment {
            color Yellow
        }
    }
}
}

camera { orthographic
    location <0, 6,-10>
    look_at <0,2,0>
    // location <0, 7,0>
    // look_at <0,0,0>
}
light_source {
    <-15, 30, -2>
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

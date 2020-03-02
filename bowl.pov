#include "colors.inc"  
#include "shapes.inc" 
#include "metals.inc"
#include "woods.inc"

#macro bowl(
    bowl_radius,
    bowlThickness,
    textureOutside,
    textureInside
)
//test
#declare bowl_radius = 3;
#declare inner_radius = bowl_radius - bowlThickness;
object {
    difference {
        sphere {
            <0, 0, 0>, bowl_radius
        }
        box {
            <-1.1*bowl_radius, bowl_radius-bowl_radius*0.6, bowl_radius*1.1>,
            <1.1*bowl_radius, 1.1*bowl_radius, -1.1*bowl_radius>
        }
        sphere {
            <0, 0, 0>, inner_radius
        }

    }
    texture { textureOutside }
    scale <1, 0.8, 1>
}
#end

// bowl(
//     3,
//     0.1,
//     texture {
//         pigment{P_Copper4}
//         finish {
//             ambient 0.30
//             brilliance 3
//             diffuse 0.4
//             metallic
//             specular 0.70
//             roughness 1/60
//             reflection 0.5
//             phong .1
//             phong_size .25
//         }
//         normal { 
//             bumps 0.05
//             scale 0.8 
//         }
//     },  
//     texture {
//         T_Brass_1A
//         finish {
//             crand .1
//             phong_size 1
//             phong 1
//         }
//         normal { 
//             bumps 0.1 
//             scale 0.8 
//         }
//     }

// )


// camera {
//     //orthographic 
//     location <0, 5, -10>
//     look_at <0, 0, 0>
// }
// light_source {
//     <10, 10, -10> // <x, y, z>
//     color <1.0, 1.0,  1.0> // <red, green, blue>
// }
// plane {
//     y, -2.7
//     pigment { P_WoodGrain5A } 
//     finish {
//         diffuse 0.9
//         //brilliance 1
//         reflection 0.1
//         phong .75
//         phong_size 20
//     }
//     rotate <0, -30, 0> // <x, y, z>
// }

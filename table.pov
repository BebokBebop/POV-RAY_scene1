#include "shapes.inc"
#include "MyTextures.pov"

#macro table(
    tableRadius,
    tableRoundness,
    doBlur
    )
#declare plankWidth = 3;
intersection {
    box{
        <-tableRadius,-1,tableRadius>
        <tableRadius,0,-tableRadius>
        
        #if(doBlur)
        texture{tableBlurTexture}
        #else
        texture{myWoodTexture}  
        #end
    }
    object{
        Round_Cylinder (
            <0,-6,0>
            <0,0.01,0>
            tableRadius, 
            tableRoundness, 
            0
        )
        texture{myWoodTexture}  
    }
    cutaway_textures
    //#if (doBlur)
    //texture{tableBlurTexture} 
    //#else //no blur - faster render
    //texture{myWoodTexture}
    //texture {tableTextureTint}
    //#end
    //tint
}
#end

// object{
//     table(23,2,0)
//     rotate<0,30,0>
//     translate<-4,0,-12>
// }
//camera
// camera {
//     angle 20
//     location<0,15,-45>
//     look_at<0,2,0> 
//     // location <0,20,0>
//     // look_at<0,0,0>
// }

// //lights
// light_source{
//     #declare brightness1 = 0.5;
//     <-2, 30, -3> 
//     color rgb<
//         1    *brightness1,
//         0.82 *brightness1,
//         0.698*brightness1
//     >
//     }   
// //flash
// light_source{
//     <-1,15.3,-45> 
//     color rgb<.8,.8,.8>
// }  

// light_source{
//     <0,5,10> 
//     color rgb<.8,.8,.8>
// }  
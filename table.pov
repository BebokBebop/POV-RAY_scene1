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
        texture{tableTexture}  
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
        texture{tableTexture}  
    }
    cutaway_textures
}
#end
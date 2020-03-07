#include "colors.inc"  
#include "shapes.inc" 
#include "metals.inc"
#include "woods.inc"

#macro bowl(
    bowl_radius,
    bowlThickness,
    textureOutside,
    textureInside,
    angleA,
    neckHeight,
    edgeRoundingR
)
//test2
#declare bowl_radius = 3; //TODO usun
#declare inner_radius = bowl_radius - bowlThickness;
#local sinA=sin(radians(angleA));
#local cosA=cos(radians(angleA));
#local tanB=tan(radians(angleA));
#local cotB=1/tanB;
#local r1 = sinA * bowl_radius;
#local r2 = r1 - cotB * neckHeight;
#local hc = cosA * bowl_radius;
object {
    merge{
        difference {
            sphere {
                <0, 0, 0>, bowl_radius
                texture { textureOutside }
            }
            box {
                <-1.1*bowl_radius, hc, bowl_radius*1.1>,
                <1.1*bowl_radius, 1.1*bowl_radius, -1.1*bowl_radius>
                texture { textureOutside }
            }
            difference{
                sphere {
                    <0, 0, 0>, inner_radius
                    scale <1, 0.9, 1> 
                    texture { textureInside }
                }
                box{
                    <-bowl_radius*1.01, -bowl_radius-0.1, -bowl_radius*1.01>
                    <bowl_radius*1.01, -bowl_radius + bowlThickness, bowl_radius*1.01>
                    texture { textureInside }
                }
            }
        }
        //box{<-4,0,4>, <4, 0.00001, -4>}
        
        difference{
            merge {
                intersection{
                    object{
                        Round_Cone(
                            <0,hc,0>, r1
                            <0,hc+neckHeight,0>, r2,
                            edgeRoundingR, 0
                        )
                        texture { textureOutside }
                    }
                    box {
                        <-1.1*r1, hc+neckHeight/2-.01, r1*1.1>,
                        <1.1*r1, hc+neckHeight+edgeRoundingR+0.1, -1.1*r1>
                        texture { textureOutside }
                    } 
                }
                intersection {
                    cone {
                        <0,hc,0>, r1
                        <0,hc+neckHeight,0>, r2
                        texture { textureOutside }
                    }
                    box {
                        <-1.1*r1, hc+neckHeight/2, r1*1.1>,
                        <1.1*r1, 0, -r1*1.1>
                        texture { textureOutside }
                    }   
                }
            }
            cone {
                <0,hc-0.001,0>, r1 - bowlThickness
                <0,hc+neckHeight+0.001,0>, r2 +.01- bowlThickness
                texture { textureInside }
            }
        }
    }
    scale <1, 0.8, 1> 
}
#end

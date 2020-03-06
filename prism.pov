#include "colors.inc"
#include "shapes.inc"

#macro hex_prism (top, bottom, a, thicc)
difference {
    prism {
        top, bottom, 6,
        <a,0>, <a/2,a*sqrt(3)/2>, <-a/2,a*sqrt(3)/2>, <-a,0>, <-a/2,-a*sqrt(3)/2>, <a/2,-a*sqrt(3)/2>
    }
    prism {
        top+0.01, bottom+thicc, 6,
        <(a-thicc),0>, <(a-thicc)/2,(a-thicc)*sqrt(3)/2>, <-(a-thicc)/2,(a-thicc)*sqrt(3)/2>, <-(a-thicc),0>, <-(a-thicc)/2,-(a-thicc)*sqrt(3)/2>, <(a-thicc)/2,-(a-thicc)*sqrt(3)/2>
    }      
}    
#end

#macro trapeze_prism(top, bottom, a, trapeze_cutof)
#local roundness = .1;
object{
    merge{
        intersection {
            object{
                Round_Pyramid_N_in (
                    3,
                    <0,bottom*.9999,0>, a*sqrt(3)/3/2,
                    <0,top*.9999>, a*sqrt(3)/3/2,
                    .1,
                    1,
                    1
                ) 
                rotate<0,180,0>
                translate<
                2/3*a*sqrt(3)/2-trapeze_cutof
                //-2/3*a*sqrt(3)/2+roundness+h2*4/3
                ,0,0>
            }
            object{
                Round_Pyramid_N_in (
                    3,
                    <0,bottom,0>, a*sqrt(3)/3/2,
                    <0,top>, a*sqrt(3)/3/2,
                    .1,
                    1,
                    1
                )  
            }
            box{
                <-a,-1,-a>
                <1/3*a*sqrt(3)/2 -trapeze_cutof+roundness*1.0001,top + 1, a>
            }
        }

        difference{
            Round_Pyramid_N_in (
                3,
                <0,bottom,0>, a*sqrt(3)/3/2,
                <0,top>, a*sqrt(3)/3/2,
                .1,
                1,
                1
            )   
            box{
                <-a,-1,-a>
                <1/3*a*sqrt(3)/2 -trapeze_cutof+roundness,top + 1, a>
            }
        }

    

    }
    rotate <0,90,0>
    translate<0,0,a*sqrt(3)/2*4/3>
    // pigment{color rgbt<.9,.9,.9,.9>}
    // finish{
    //     ior 1.5
    // }
}
#end

#macro rhombus_prism(top, bottom, c, a)
intersection {
    object {
        Round_Pyramid_N_in (
            6,
            <0,bottom*.999999,0>, c,
            <0,top*.999999>, c,
            .1,
            1,
            1
        ) 
    }
    object {
        Round_Pyramid_N_in (
            6,
            <0,bottom,0>, c,
            <0,top>, c,
            .1,
            1,
            1
        )
        translate<-c*sqrt(3)/2,0,c/2>
    }
    //pigment {color Red}
    rotate<0,30,0>
    translate<-a/2,0,a*sqrt(3)/2>
}
#end

#macro whole_prism(
    hex_top, 
    hex_bottom, 
    trapeze_top1, 
    trapeze_top2, 
    trapeze_bottom, 
    rhombus_top, 
    rhombus_bottom, 
    hex_side, 
    hex_thickness, 
    trapeze_cutoff, 
    rhombus_side,
    p_material
)
#local rhombus_a = hex_side*1.00001;
merge {
    //hexBowl
    object {
        hex_prism(hex_top, trapeze_bottom, hex_side*.9999, hex_thickness)
        material {p_material}
    }
    object {  
        merge {
            trapeze_prism(trapeze_top1, trapeze_bottom, hex_side, trapeze_cutoff)
            rhombus_prism(rhombus_top, rhombus_bottom, rhombus_side, rhombus_a)
            //rotate <0,60,0>
        }
        material {p_material}
    }
    object {  
        merge {
            trapeze_prism(trapeze_top2, trapeze_bottom, hex_side, trapeze_cutoff)
            rhombus_prism(rhombus_top, rhombus_bottom, rhombus_side, rhombus_a)
            //rotate <0,60,0>
        }
        material {p_material}   
        rotate <0,60,0>
    }      
    object {  
        merge {
            trapeze_prism(trapeze_top1, trapeze_bottom, hex_side, trapeze_cutoff)
            rhombus_prism(rhombus_top, rhombus_bottom, rhombus_side, rhombus_a)
            //rotate <0,60,0>
        }
        material {p_material}  
        rotate <0,120,0>
    }      
    object {  
        merge {
            trapeze_prism(trapeze_top2, trapeze_bottom, hex_side, trapeze_cutoff)
            rhombus_prism(rhombus_top, rhombus_bottom, rhombus_side, rhombus_a)
            //rotate <0,60,0>
        }
        material {p_material} 
        rotate <0,180,0>
    }      
    object {  
        merge {
            trapeze_prism(trapeze_top1, trapeze_bottom, hex_side, trapeze_cutoff)
            rhombus_prism(rhombus_top, rhombus_bottom, rhombus_side, rhombus_a)
        }
        material {p_material}
        rotate <0,240,0>
    }
    object {  
        merge {
            trapeze_prism(trapeze_top2, trapeze_bottom, hex_side, trapeze_cutoff)
            rhombus_prism(rhombus_top, rhombus_bottom, rhombus_side, rhombus_a)
        }
        material {p_material}
        rotate <0,300,0>
    }                                                         
}
#end

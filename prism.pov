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

#macro trapeze_prism(top, bottom, a, th)
prism {
    top, bottom, 4,
    <-a/2,a*sqrt(3)/2>, <a/2,a*sqrt(3)/2>, <(a-th)/2, (a+th)*sqrt(3)/2>, <-(a-th)/2, (a+th)*sqrt(3)/2>

}
#end

#macro rhombus_prism(top, bottom, c, a)
prism {
    top, bottom, 4,
    <-a/2,a*sqrt(3)/2>,
    <((-a/2)-c),a*sqrt(3)/2>, 
    <((-a/2)-c/2), c*sqrt(3)/2+a*sqrt(3)/2>,
    <(-a/2)+c, c*sqrt(3)/2+a*sqrt(3)/2>   
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
merge {
    //hexBowl
    object {
        hex_prism(hex_top, trapeze_bottom, hex_side, hex_thickness)
        material {p_material}
    }
    object {  
        merge {
            trapeze_prism(trapeze_top1, trapeze_bottom, hex_side, trapeze_cutoff)
            rhombus_prism(rhombus_top, rhombus_bottom, rhombus_side, hex_side)
            //rotate <0,60,0>
        }
        material {p_material}
    }
    object {  
        merge {
            trapeze_prism(trapeze_top2, trapeze_bottom, hex_side, trapeze_cutoff)
            rhombus_prism(rhombus_top, rhombus_bottom, rhombus_side, hex_side)
            //rotate <0,60,0>
        }
        material {p_material}   
        rotate <0,60,0>
    }      
    object {  
        merge {
            trapeze_prism(trapeze_top1, trapeze_bottom, hex_side, trapeze_cutoff)
            rhombus_prism(rhombus_top, rhombus_bottom, rhombus_side, hex_side)
            //rotate <0,60,0>
        }
        material {p_material}  
        rotate <0,120,0>
    }      
    object {  
        merge {
            trapeze_prism(trapeze_top2, trapeze_bottom, hex_side, trapeze_cutoff)
            rhombus_prism(rhombus_top, rhombus_bottom, rhombus_side, hex_side)
            //rotate <0,60,0>
        }
        material {p_material} 
        rotate <0,180,0>
    }      
    object {  
        merge {
            trapeze_prism(trapeze_top1, trapeze_bottom, hex_side, trapeze_cutoff)
            rhombus_prism(rhombus_top, rhombus_bottom, rhombus_side, hex_side)
        }
        material {p_material}
        rotate <0,240,0>
    }
    object {  
        merge {
            trapeze_prism(trapeze_top2, trapeze_bottom, hex_side, trapeze_cutoff)
            rhombus_prism(rhombus_top, rhombus_bottom, rhombus_side, hex_side)
        }
        material {p_material}
        rotate <0,300,0>
    }                                                         
}
#end

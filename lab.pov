#include "colors.inc"       
#include "woods.inc" 



camera {     
    location <0, 10,-15>     
    //location <-10, 10,0>     
    look_at <0,0,0>  } 
    light_source {     <0, 0, -25>      
    color rgb <1, 1, 1> }
    
    
//difference {     
    //big, yellow one 
    #declare tear =
    union {
        merge {
             difference {
                cylinder {
                    <0,0,0>,
                    <0,0,3>,
                    5
                   
                }
                
                merge {  
                    cylinder {
                        <-2.5,0,-0.1>,
                        <-2.5,0,3.1>,
                        2.5
                       
                        
                     }
                     box {
                         <-5,0,-0.1>,
                         <5,5,3.1>
                     }
                }
              }
           
            cylinder {
                    <2.5,0,0>,
                    <2.5,0,3>,
                    2.5
                  
                }  
        }
     }
    
    //small one
    
//} 
//difference{
object { tear   texture {
                        pigment {
                           color Yellow 
                        }
                    } }
    object { tear
        scale <0.8, 0.8, 0.8>
       rotate <0,0,12>
        translate <0.4, -0.5, -0.05>
         
        texture {
                        pigment {
                           color Red 
                        }
                    }
        }
    //}
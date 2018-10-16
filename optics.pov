// -w800 -h600 +a0.3

#version 3.7;

#include "colors.inc"
#include "glass.inc"

#default { finish { ambient 0.0 } }

global_settings {
    assumed_gamma 1
    max_trace_level 64
    photons {
      count 7550000
      max_trace_level 64
      //radius , 2.0
      //radius 10.1
      //media 100000
      //media 64, 128
      //media 64, 128
      //media 1000, 2
      media 100, 2
      //media 1000, 16
      //autostop 0
      //jitter .4
      //media 100,1
    }
    //subsurface {}
}

#declare fov = 25;

////lab
#declare CamPos = < -10, 2, -15>;
#declare LookAtTarg = < 2, -0.75, 1.5>;

////labalt
//#declare CamPos = < 12, 10, 12>;
//#declare LookAtTarg = < 2, -0.1, -0.1>;
////#declare CamPos = < -12, 1, -1>;
////#declare CamPos = < 1.5, 0.5, 0.0>;


////top down
//#declare CamPos = < 0, 18, 0>;
//#declare LookAtTarg = < 0, 0, 0>;

////head on
//#declare CamPos = < -18, 1, 0>;
//#declare LookAtTarg = < 0, 0, 0>;

////sideways
//#declare CamPos = < 0, 0, -10>;
//#declare LookAtTarg = < 0, -0.1, 0>;

#declare xSetupOffset = -1.0;

camera {
    location CamPos
    right x*image_width/image_height // keep propotions with any aspect ratio
    look_at LookAtTarg
    angle fov
}

/*
light_source {CamPos, color Gray25
    photons {refraction off reflection off}
    media_interaction off
}
*/

light_source { CamPos, color Gray25
    photons { refraction on reflection on }
}

//light_source {CamPos, color Gray25
//    photons { refraction on reflection on }
//    media_interaction off
//}

/*
light_source {<-50, 0.0, 0>, color rgb < 1.0, 0, 0>
    spotlight radius 0.25 falloff 0.35 point_at < 0, 0.0, 0>
    photons {refraction on reflection on}
}

light_source {<-50, 0.0, 0>, color rgb < 0, 1, 0>
    spotlight radius 0.25 falloff 0.35 point_at < 0, 0.0, 0>
    photons {refraction on reflection on}
}

light_source {<-50, 0.0, 0>, color rgb < 0, 0, 1>
    spotlight radius 0.25 falloff 0.35 point_at < 0, 0.0, 0>
    photons {refraction on reflection on}
}
*/

/*
light_source {<-50, 0.5, 0>, color rgb < 1.0, 0, 0>
    spotlight radius 0.5 falloff 0.51 point_at < 0, 0.5, 0>
    photons {refraction on reflection on}
}

light_source {<-50, 0.5, 0>, color rgb < 0, 1, 0>
    spotlight radius 0.5 falloff 0.51 point_at < 0, 0.5, 0>
    photons {refraction on reflection on}
}

light_source {<-50, 0.5, 0>, color rgb < 0, 0, 1>
    spotlight radius 0.5 falloff 0.51 point_at < 0, 0.5, 0>
    photons {refraction on reflection on}
}
*/

light_source {<-150, -0.75, 0>, color rgb < 1, 0, 0>
    spotlight radius 0.1 falloff 0.3 point_at < 0, -0.15, 0>
    photons {refraction on reflection on}
}

light_source {<-150, 0.0, 0.75>, color rgb < 0, 1, 0>
    spotlight radius 0.1 falloff 0.3 point_at < 0, 0.0, 0.25>

    photons {refraction on reflection on}
}

light_source {<-150, 0.75, 0>, color rgb < 0, 0, 1>
    spotlight radius 0.1 falloff 0.3 point_at < 0, 0.15, 0>
    photons {refraction on reflection on}
}

/*
box
 { -10,10 pigment { rgbt 1 } hollow
   interior
   { media
     { scattering { 1, 0.5 }
     }
   }
 }
*/

box {<-100,-3,-100>, < 100, -2, 100>
    texture {
        pigment { checker color White, color rgb < 0.2, 0, 0.4> }
        finish { brilliance 0.25 }
    }

    photons { target refraction off reflection yes }
}


/*
light_source {<xSetupOffset, 1.75, 0>, color rgb <0.15,0.15,0.15> //< .15, 0.15, 0.15>
    spotlight radius 10.0 falloff 20.0 point_at < xSetupOffset, 0.0, 0.0>

    photons { refraction on reflection on }
}
*/


box { <xSetupOffset,-0.25,-0.25>, <xSetupOffset-0.1, 0.25, 0.25>
    texture {
        pigment { color Green }
        //finish { reflection {1.0} brilliance 5.0 diffuse 0.9 }
        //finish { reflection {0.5} brilliance 5.0 ambient 0 diffuse 0.9 }
        //finish { ambient 0 diffuse 0 reflection 1 }
    }

    photons { target refraction off reflection on }

    rotate z*45
    translate <-0.25,0.65,0>
}

/*
intersection {
  //fl=2 ior=1.5 lr=1

	sphere{
		<0,+1.7321,0>, 2
	}

	sphere{
		<0,-1.7321,0>, 2
	}

	//texture {GlassTex1}
	//interior {GlassInt1}
	//PhotonTarget(no, yes, yes)
  //photons
  //{
  // target
  // reflection on
  // refraction on
  //}

  texture {
    pigment { Col_Glass_Clear }
    finish { ambient 0 diffuse 0 reflection 0.01 }
  }

  interior { ior 1.5 }

  photons
  {
   reflection on
   refraction on
   collect off
  }

	scale < 1, 1, 1>
  translate < 1, 1, 0>
	rotate -x*90
	rotate -y*90
  translate < 0, 0, -1.0>
}
*/

#declare lenseToPlane = (-.75);
box { <1+lenseToPlane,-2,-5>, <1+lenseToPlane+0.1, 2, 5>

    texture {
        pigment { color White }
        finish { reflection {0.0} brilliance 1.0 diffuse 1.0 }
        //finish { reflection {1.0} brilliance 0.9 diffuse 0.99 }
        //finish { diffuse 0.9
        //         phong 0.5 }
    }

/*
    texture { pigment{
                color White filter 0.27
                quick_color White}
              normal {bumps 0.1 scale 0.002}
              finish {diffuse 0.9
                      phong 0.5}
            }// end of texture
*/

    //photons { target refraction off reflection on }
}

/*
#declare R = 1.1;
#declare A = 0.1;
#declare ishift = 1.5;
difference {
	cylinder {<ishift, 0, 0>, < ishift+0.001, 0, 0>, R}
	sphere {<ishift, 0, 0>, A}
	translate <0, 0.0, 0>

    texture {
        pigment { color White }
    }

    photons {
      target
      refraction off
      reflection yes
      collect off
    }
}
*/

/*
box
 { <-5, -6.5, -10.5>, <3, 6.5, 10.25>
   pigment { rgbt 1 } hollow
   interior
   { media
     { scattering { 1, 0.07 extinction 0.01 }
       samples 30
     }
   }
   photons { pass_through }
 }
*/

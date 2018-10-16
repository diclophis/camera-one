// -w800 -h600 +a0.3

#version 3.7;

#include "colors.inc"
#include "glass.inc"

#default {finish {ambient 0}}

global_settings {
    assumed_gamma 1
    max_trace_level 4
    photons {
      //spacing 0.0001
//// count 150000
      count 5330000
      max_trace_level 4
      media 100, 1
      //media 500, 3
    }
}

//#declare CamPos = < -12, 10, -12>;

////lab
#declare CamPos = < -15, 2, -15>;
#declare LookAtTarg = < 2, -0.1, -0.1>;

////labalt
//#declare CamPos = < 12, 10, 12>;
//#declare LookAtTarg = < 2, -0.1, -0.1>;
////#declare CamPos = < -12, 1, -1>;
////#declare CamPos = < 1.5, 0.5, 0.0>;

#declare fov = 18;

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


box
 { -10,10 pigment { rgbt 1 } hollow
   interior
   { media
     { scattering { 1, 0.5 }
     }
   }
 }



box {<-100,-3,-100>, < 100, -2, 100>
    texture {
        pigment {checker color Gray90, color rgb < 0.2, 0, 0.4>}
        finish {brilliance 0.25}
    }
}

#declare GlassTex1 =
texture {
    pigment { color White filter 0.9 }
    //pigment { color White }
    finish {ambient 0 diffuse 0 reflection 0.01}
}
#declare GlassInt1 =
interior {ior 1.5}

#macro PhotonTarget(Reflect, Refract, IgnorePhotons)
	photons {
		target
		reflection Reflect
		refraction Refract
		#if(IgnorePhotons) collect off #end
	}
#end


/*#declare Fn = function {sin(z*pi)/5 - x}
isosurface {
    function {Fn(x,y,z)}
    threshold 0
    eval
//    max_gradient 9.25
    contained_by {box {<-1, 0,-2>, < 1, 1, 2>}}
    texture {
        pigment {color White}
        finish {ambient 0 diffuse 0.2 reflection 0.8}
    }
    photons {target collect off}
    rotate -y*15
    translate < 2, 0, 0>
}*/


light_source {<xSetupOffset, 5, 0>, color rgb < 0.1, 0.1, 0.1>
    spotlight radius 10.0 falloff 20.0 point_at < xSetupOffset, 0.0, 0.0>

    //area_light <10, 0, 0>, <0, 0, 10>, 10, 10
    //adaptive 1
    //jitter

    photons { refraction on reflection on }
}


box { <xSetupOffset,-0.25,-0.25>, <xSetupOffset-0.1, 0.25, 0.25>
    texture {
        pigment { color Green }
        finish { reflection {0.9} brilliance 0.5 ambient 0.5 diffuse 0.5 }
        //finish { reflection {1.0} ambient 0.0 diffuse 0.0 }
    }

    //photons {refraction on reflection on}
	  //PhotonTarget(yes, yes, false)
    //texture {pigment {color rgbf 1}}
    //interior {
    //    media {
    //        scattering {1, color White extinction 0}
    //////      emission color White*0.2
    //        method 3
    //        intervals 1 samples 4
    //    }
    //}

    photons {
      target
      refraction off
      reflection on
    }

	rotate z*45
  translate <0,0.65,0>
}

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

  pigment { Col_Glass_Clear }
  interior { ior 1.5 }
  photons
  {
   reflection on
   refraction on
  }

	scale < 1, 1, 1>
  translate < 1, 1, 0>
	rotate -x*90
	rotate -y*90
  translate < 0, 0, -1.0>
}

#declare lenseToPlane = (2 + sin(clock));
box { <1+lenseToPlane,-2,-5>, <1+lenseToPlane+0.1, 2, 5>

    texture {
        pigment { color White }
        //finish { brilliance 0.0 ambient 0.01 diffuse 0.01 }
        finish { reflection {0.0} brilliance 0.001 ambient 0.001 diffuse 0.9 }
    }
	
    //PhotonTarget(no, yes, yes)

    photons {
      target
      refraction off
      reflection yes
    }
}


/*
#declare T = 0.475*2;
#declare R = 1;
intersection {
    sphere {<-R, 0, 0>, R translate x*T/2}
    sphere {< R, 0, 0>, R translate -x*T/2}
    texture {GlassTex1}
    interior {GlassInt1}
    PhotonTarget(no, yes, yes)
    translate < 0, 0.5,-2>
}

#declare R = 1;
difference {
	cylinder {<-0.1, 0, 0>, < R, 0, 0>, R}
	sphere {< R, 0, 0>, R}
//	texture {pigment {color White}}
	texture {GlassTex1}
	interior {GlassInt1}
//	PhotonTarget(no, yes, yes)
	translate <-1, 0.5, 3>
}
*/

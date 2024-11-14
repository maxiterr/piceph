module drill(hole=[], d=1, rotation=[0,0,0]) {
  module _drill(hole=[],d) {
    $fn=16;
    translate(hole) rotate(rotation) cylinder(d=d, h=20);
  }
  for(h = hole) {
    _drill(hole=h,d=d);
  }
}


module screen0_96 (guide=false) {
  //module drill(guide=false) {
  //  module _drill(d) {
  //    $fn=16;
  //    translate ([2.5,2.5,-1]) cylinder(h=20,d=d,center=true);
  //    translate ([27.5,2.5,-1]) cylinder(h=20,d=d,center=true);
  //    translate ([2.5,21.5,-1]) cylinder(h=20,d=d,center=true);
  //    translate ([27.5,21.5,-1]) cylinder(h=20,d=d,center=true);
  //  }
  //  if(guide==true) _drill(0.1); else _drill(2);
  //}

  hole=[
    [2.5,2.5,-10],
    [27.5,2.5,-10],
    [2.5,21.5,-10],
    [27.5,21.5,-10]
  ];

  difference() {
    color("blue") cube([30,24,1]);
    drill(hole=hole,d=2);
    for (i = [0 : 7]){
      translate ([6.5+i*2.54,22.5,-1]) cylinder(h=3,d=1);
    }
  }
  if (guide==true) drill(hole=hole,d=0.1);
  translate([1.2,5.6,1]) color("black")cube([28,13.4,1.5]);
}

screen0_96(guide=true);

module joystick (guide=false) {
  module drill(guide=false) {
    module _drill(d) {
      $fn=16;
      translate ([3,3,-1]) cylinder(h=20,d=d,center=true);
      translate ([3,17,-1]) cylinder(h=20,d=d,center=true);
      translate ([19.5,3,-1]) cylinder(h=20,d=d,center=true);
      translate ([19.5,17,-1]) cylinder(h=20,d=d,center=true);
    }
    if(guide==true) _drill(0.1); else _drill(2);
  }
    difference() {
        color("blue") cube([25,20,1.5]);
        drill();
        for (i = [0 : 5]){
            translate ([23.5,3.5+i*2.54,-1]) cylinder(h=3,d=1);
        }
    }
    if (guide==true) drill(guide=true);
    translate([6.5,4.6,1.5]) {
        color("grey")cube([10,10.5,2.5]);
        translate([5,5.25,2.5])color("black")cylinder(h=2.5,d=3.7);
        translate([5,5.25,7])color("grey")cube([2.5,2.5,4],center=true);
    }
    // axe
    translate ([3,3,-1]) cylinder(h=5,d=0.1);
    translate ([3,17,-1]) cylinder(h=5,d=0.1);
    translate ([19.5,3,-1]) cylinder(h=5,d=0.1);
    translate ([19.5,17,-1]) cylinder(h=5,d=0.1);
    
}

//joystick(guide=true);
module oPZ3_drill(guide=false) {
  $fn=16;
  module drill(d) {
    translate ([2.6,2.6,0])
      cylinder(h=20,d=d,center=true);
    translate ([52.4,2.6,0])
      cylinder(h=20,d=d,center=true);
    translate ([52.4,47.4,0])
      cylinder(h=20,d=d,center=true);
    translate ([2.6,47.4,0])
      cylinder(h=20,d=d,center=true);
  }
  if(guide==true) drill(0.1); else drill(3); 
}
module oPZ3_rj45() {
  color("LightGrey") cube([16,21,13.4]);
}
module oPZ3_usb () {
  color("LightGrey") cube([5.7,14,13.2]);
}
module oPZ3_cpu () {
  color("#303030") cube([12,14,1]);
}
module oPZ3_ram () {
  color("#303030") cube([10,14.5,1]);
}
module oPZ3_network () {
  color("LightGrey") cube([10.3,10.3,2]);
}
module oPZ3_sdCard() {
  color("LightGrey") cube([11.3,15.1,1.7]);
}

module oPZ3_pin (line,col) {
  for (l = [0:line-1])
    for (c = [0:col-1])
      translate([l*2.54,c*2.54,-1.5]) {
        color("LemonChiffon")
          cube([0.7,0.7,11.5]);
        color("black") translate([0.7/2,00.7/2,4.2])
          cube([2.3,2.3,2.7], center=true);
      }
}

module oPZ3_board(guide=false) {
  difference() {
    color("LightSkyBlue") cube([55,50,1.2]);
    oPZ3_drill();
  }
  if (guide==true) oPZ3_drill(guide=true);
  translate([33.5,-0.5,1.2]) oPZ3_rj45();
  translate([26,-1,2]) oPZ3_usb();
  translate([21.3,25,1.2]) oPZ3_cpu();
  translate([7.5,24.5,1.2]) oPZ3_ram();
  translate([38.5,36.6,1.2]) oPZ3_network();
  translate([37.6,37.6,-1.7]) oPZ3_sdCard();
  
  translate([1.3,11.5,0]) oPZ3_pin(2,13);
  translate([53.3,11.5,0]) oPZ3_pin(1,13);
  translate ([8.1,48.4,0]) oPZ3_pin(3,1);
}

oPZ3_board(guide=false);

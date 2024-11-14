use <oPZ3_board.scad>
use <ssd.scad>
use <piceph_lib.scad>
use <piceph_screen.scad>

module screen_joystick(guide=false) {
  screen0_96(guide=guide);
  translate([5,-22,0]) joystick(guide=guide);
}

module internal_elements(guide=false) {

  translate ([0,-50,5]) {
    for (i = [0 : 2]){
      translate ([58*i,0,0]) {
        oPZ3_board(guide=guide);
        translate([29,-40,25]) rotate([20,00,90]) screen_joystick(guide=guide);
      }
    }
  }
  
  translate([45,0,0]) rotate([0,90,-90]) ssd_pack(n=6,guide=guide,usb=true);
  translate([153,-45,0]) rotate([0,90,0]) switch5p (guide=guide);
  translate ([40,-55,-75]) rotate([90,0,0]) power5v10a();
  translate ([0,-50,-10]) rotate([0,90,0]) fan5010(guide=guide);
  translate([-2,-59,-40]) rotate([90,0,0]) ext_rj45(guide=guide);
  translate([-2,-90,-73]) ext_switch_and_220v();

  translate([35,-90,-10]) rotate([0,0,90]) board_with_terminal_block(guide=guide);
}

//translate([0,150,0]) internal_elements(guide=true);


module internal_elements_v2(guide=false) {

  translate ([60,-45,10]) {
    for (i = [0 : 2]){
      translate ([58*i,0,0]) {
        //rotate([0,0,180]) oPZ3_board(guide=guide);
        //translate([-20,6,15]) rotate([20,00,90]) screen_joystick(guide=guide);
      }
    }
  }
  
  //translate([45,0,0]) rotate([0,90,-90]) {
  //  ssd_pack(n=6,guide=guide,usb=true);
  //  translate([0,97.9,-2]) rotate([0,0,180])ssd_flask(top=true);
  //  translate([70,8,-2]) ssd_flask();
  //}
  //translate([155,-49,-69.5]) rotate([180,-90,0]) switch5p (guide=guide);
  translate([168,-52,6.5]) rotate([0,90,0]) switch5pLock();
  translate ([42,-55,-74]) rotate([90,0,0]) power5v10a();
  translate ([0,-50,-10]) rotate([0,90,0]) fan5010(guide=guide);
  translate([-2,-59,-40]) rotate([90,0,0]) ext_rj45(guide=guide);
  //translate([-2,-90,-73]) ext_switch_and_220v();

  translate([35,-90,-10]) rotate([0,0,90]) board_with_terminal_block(guide=guide);
  translate([30,-100,-55]) rotate([90,0,0]) push_button_self_lock();
}

module base() {
    module position() {
        translate([0,0,2]) cube([8,6,3]);
        translate([0,0,5]) cube([2,6,3]);
    }
  module screw(support=false, double=false) {
    $fn=30;
    // dans piceph v1: d ext = 6 trou = 2.5
    // dans support trou 3.8
    

    difference() {
      cylinder(h=5,d=6);
      translate([0,0,-2]) cylinder(h=10,d=2.4);
    }
    if (support) {
      difference() {
        translate ([-3,0,0]) cube([6,support,5]);
        translate([0,0,-2]) cylinder(h=10,d=5);
      }
      if (double) difference() {
        translate ([-3,-support,0]) cube([6,support,5]);
        translate([0,0,-2]) cylinder(h=10,d=5);
      }
    }
  }
  //screw(support=4,double=true);
  difference() {
    translate([0,-97,-79.5])cube([170,100,3]);
    translate([46.5,-81.8,-80]) cylinder(d=5,h=10); // hole for power screw
    translate([149,-81.8,-80]) cylinder(d=5,h=10); // hole for power screw
  }
  // SSD rails position
  translate([52.4,-50.5,-76.5]) cube([2,48.5,5]);
  translate([64.1,-50.5,-76.5]) cube([2,48.5,5]);
  translate([129.7,-50.5,-76.5]) cube([2,48.5,5]);
  translate([141.4,-50.5,-76.5]) cube([2,48.5,5]);
  // SSD holder
  translate([47,-6,-73]) rotate([-90,0,0]) screw(support=4);
  translate([148,-6,-73]) rotate([-90,0,0]) screw(support=4,double=true);
  translate([148.9,-6,3]) rotate([-90,0.7,0]) screw(support=74);
  
  // Switch holder
  translate([168,-52,-73]) rotate([-90,0,90]) screw(support=4);
  //translate([168,-52,6.5]) rotate([-90,0,90]) screw(support=0);
  
  // Switch/power/disk holder
  translate([146,-55,-77]) cube([6,5,73]);
  translate([149,-55,0]) rotate([-90,0,0]) screw(support=4,double=true);
  translate([146,-55,4]) cube([6,5,5]);

  // Power position
  translate([62,-94,-79]) rotate([0,0,90]) position();
  translate([40,-61,-79]) rotate([0,0,0]) position();
  translate([100,-94,-79]) rotate([0,0,90]) position();
  translate([147,-94,-79]) rotate([0,0,90]) position();
  translate([154,-55,-79]) rotate([0,0,180]) position();
  translate([100,-53,-79]) rotate([0,0,-90]) position();
  // Power screew
  translate([46.5,-81.8,-79]) screw();
  translate([149,-81.8,-79]) screw();
}

//internal_elements_v2(guide=true);
base();


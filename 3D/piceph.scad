use <oPZ3_board.scad>
use <ssd.scad>
use <piceph_lib.scad>


translate ([0,-50,5]) {
  oPZ3_board(guide=true);
  translate ([58,0,0]) oPZ3_board(guide=true);
  translate ([58*2,0,0]) oPZ3_board(guide=true);
}


translate([45,0,0]) rotate([0,90,-90]) ssd_pack(n=6,guide=true,usb=true);
translate([153,-45,0]) rotate([0,90,0]) switch5p ();
translate ([40,-55,-75]) rotate([90,0,0]) power5v10a();
translate ([0,-50,-10]) rotate([0,90,0]) fan5010(guide=true);
translate([-2,-59,-40]) rotate([90,0,0]) ext_rj45(guide=true);
translate([-2,-90,-73]) ext_switch_and_220v();


translate([35,-90,-10]) rotate([0,0,90]) board_with_terminal_block(guide=true);

difference() {
  $fn=30;
  cube([20,20,3]);
  translate([7,7,1]) cube ([6,6,3]);
  translate([10,10,-1]) cylinder(d=3,h=5);
}

translate([-10,0,0]) difference() {
  $fn=30;
  cube ([6,50,6]);
  translate([3,-1,3]) rotate([-90,0,0]) cylinder(d=2.4, h=10);
}

module drill(hole=[], d=1, rotation=[0,0,0]) {
  module _drill(hole=[],d) {
    $fn=16;
    translate(hole) rotate(rotation)cylinder(d=d, h=20);
  }
  for(h = hole) {
    _drill(hole=h,d=d);
  }
}


module ext_rj45(guide=false){
  hole=[
    [-5,3.5,3.5],
    [-5,26-3.5,31-3.5]
  ];
  color ("grey") difference() {
    cube([2.3,26,31]);
    drill(hole=hole,rotation=[0,90,0],d=3.5);
  }
  if (guide==true) drill(hole=hole,rotation=[0,90,0],d=0.1);
  color ("grey") translate([-2.4,13,15.6]) rotate([0,90,0]) cylinder(d=23.5, h=20);
  color ("grey") translate([17.6,13,15.6]) rotate([0,90,0]) cylinder(d=20, h=7);
}

//translate([0,40,0]) ext_rj45(guide=true);

module ext_switch_and_220v(){
    color ("grey") cube([3.1,31.6,28.4]);
    color ("grey") translate([0,1.8,1.7]) cube([9.5,28,25]);
}

//ext_switch_and_220v();


module switch5p (guide=false) {
    module board() {
      hole=[
        [2.5,20.5,-10],
        [2.5+68,20.5,-10]
      ];
      difference() {
          cube([72.5,40.5,1]);
          drill(hole=hole,d=2.1);          
      }
      if (guide==true) drill(hole=hole,d=0.1);
    }
    module rj45() {
        translate([0,-5,1.5]) cube([72.5,15.2,13.2]);
    }
    color("green") board();
    color("dodgerblue") rj45();
}

//switch5p (guide=true);


module switch5pLock() {
  $fn=30;
  difference() {
    union() {
      hull() {
        translate([1,0,0]) cylinder(d=8,h=4);
        translate([78.5,0,0]) cylinder(d=8,h=4);
      }
      translate([1.5,-9.7,0]) cube([5,19.4,4]);
      translate([73,-9.7,0]) cube([5,19.4,4]);
    }
    translate([0,0,-4]) cylinder(d=3,h=10);
    translate([79.5,0,-4]) cylinder(d=3,h=10);
    translate([3,-7.7,-1]) cube([73.5,15.4,3]);
  }
  
}

translate([-3.5,2.5,13]) switch5pLock();

module power5v10a() {
  $fn=16;
  color("LightGrey") {
    difference() {
      cube([110,78,1]);
      translate([106.2,74,-1]) rotate([0,0,-90])hull() {
            translate([-3.5/2,2,0])cube ([3.5,3.5,4]);
            cylinder(d=3.5,h=4);
      }
      translate([4.5,4.5,-1]) cylinder(d=3.5,h=3);
    }
    difference() {
      cube([110,1,37]);
      translate([106.8,2,26.8]) rotate ([90,90,0]) hull() {
            translate([-3.5/2,2,0]) cube ([3.5,3.5,4]);
            cylinder(d=3.5,h=4);
      }
      translate([4.5,2,26.8]) rotate ([90,90,0]) cylinder(d=3.5,h=4);
    }
    translate([3,35,1]) cube([15,40,15]);
    translate([103,1,0]) cube([1,76,36]);
    translate([16,1,36]) difference() {
      cube([88,76,1]);
      for (i = [0 : 6]){
        for (j = [0 : 10]){
          translate([8.5+11*i,8.5+6.1*j,-1]) cylinder(h=4,d=4);
          translate([14+11*i,5+6.1*j,-1]) cylinder(h=4,d=4);
        }
      }
    }
    translate([16,77,1]) difference() {
      cube([88,1,36]);
      for (i = [0 : 6]){
        for (j = [0 : 4]){
          translate([8.5+11*i,2,4+6.1*j]) rotate([90]) cylinder(h=4,d=4);
          translate([14+11*i,2,7+6.1*j]) rotate([90]) cylinder(h=4,d=4);
        }
      }
    }
  }
}

//power5v10a();


module fan_wheel(
    outer_radius    = 23,    
    inner_radius    = 12.5,
    blade_count     = 7,
    outer_width     = 11,
    inner_width     = 6.7,
    thickness       = 1,    
    twist           = -25,    
    angle_of_attack = 45,
){

    module blade() {

        inner_height = 
            cos( 
                asin( inner_width / ( 2 * inner_radius ) ) 
            ) * inner_radius;
        
        blade_height = outer_radius - inner_height;

        angle = 
            atan( 
                  ( ( outer_width / 2 * cos( abs( twist ) ) ) - 
                    ( inner_width / 2 ) 
                  ) / blade_height 
            );    
        
        height = sin( abs( twist ) ) * outer_width / 2 + 
                 thickness;
        
        width = outer_width / 2 - inner_width / 2;
        
        depth  = 
            sqrt( 
                pow( ( outer_width / 2 * cos( abs( twist ) ) ) - 
                     ( inner_width / 2 ), 2 ) + 
                pow( blade_height, 2 )
            ) + thickness;
            
        blade_divisions = 10;
            
        difference(){
            intersection(){
                rotate( [0, -angle_of_attack, 0] )
                difference(){
                    translate( [0, inner_height, 0] )
                    rotate( [-90, 0, 0] )
                    linear_extrude( 
                        height    = blade_height, 
                        twist     = twist, 
                        slices    = 10 , 
                        convexity = 10
                    ) 
                    translate([
                        -outer_width / 2,
                        -thickness / 2
                    ])
                    polygon( concat(
                        [for (i = [0 : blade_divisions]) 
                            [i * outer_width / blade_divisions, (i % 2) * 0.0001]
                        ],
                        [for (i = [blade_divisions : -1 : 0]) 
                            [i * outer_width / blade_divisions, 
                             thickness + (i % 2) * 0.0001]
                        ]
                    ));
                    
                                                
                    for (i = [0 : 1])
                    mirror( [i, 0, 0] )
                    translate([
                        inner_width / 2,
                        inner_height,
                        -height
                    ])
                    rotate( [0, 0, -angle] )
                    translate( [0, -depth / 2, 0] )
                    cube( [width * 2, depth * 1.5, 2 * height] );

                }
                
                translate( [0, 0, -height] )
                cylinder( 
                    r = outer_radius, 
                    h = 2 * height, 
                    $fn = 100
                );
            }
            
            translate( [0, 0, -height] )
            cylinder( r = inner_radius, h = 2 * height, $fn = 50);            
        }
    }

    // hub
    hub_height = 
        sin( abs( angle_of_attack ) ) * inner_width / 2 + 
        thickness;
    
    translate( [0, 0, -hub_height] )
    cylinder( r = inner_radius, h = hub_height * 2, $fn = 50);

    // blades
    for(i = [0 : 360 / blade_count : 359])
    rotate( [0, 0, i] )
    blade();

}



//translate([0,0,0]) fan_wheel();


module fan5010(guide=false) {
  hole=[
    [5,5,0],
    [5,45,0],
    [45,45,0],
    [45,5,0]
  ];
  color ("grey") translate([25,25,6]) fan_wheel();
  color ("grey") difference() {
    hull() {
      translate([5,5,0])cylinder(d=10,h=10);
      translate([5,45,0])cylinder(d=10,h=10);
      translate([45,5,0])cylinder(d=10,h=10);
      translate([45,45,0])cylinder(d=10,h=10);
    }
    translate([0,0,-1]) drill(hole=hole, d=3);
    translate([25,25,-5]) cylinder(h=20,d=48);
  }
  if (guide==true) translate([0,0,-5]) drill(hole=hole, d=0.1);
}

//fan5010(guide=true);

module terminal_block(n=1) {
  difference() {
    cube([n*2.54+0.46,6.30,8.8]);
    for (i = [0:n-1])
      translate([0.8+i*2.54,-1,2]) cube([1.4,3.6,2]);
    translate([-2,-3,6]) rotate([-20,0,0])cube([n*2.54+4,3,5]);
    translate([-2,7,4]) rotate([20,0,0])cube([n*2.54+4,3,6]);
  }
  for (i = [0:n-1])
    translate([1.1+i*2.54,2.5,-3.6]) cube([0.8,0.8,3.6]);
}
//terminal_block(7);

module board_with_terminal_block(guide=false) {
  hole=[
    [2.5,2.5,-5],
    [30-2.5,2.5,-5]
  ];
  if (guide==true) drill(hole=hole, d=0.1);

  difference() {
    cube([30,35,1]);
    drill(hole=hole, d=2);
  }
  translate([25.5,11,1]) rotate([0,0,180])terminal_block(8);
  translate([4.5,22,1]) rotate([0,0,0])terminal_block(8);
}
//board_with_terminal_block(guide=true);

module push_button_self_lock() {
  cylinder(d=14,h=1);
  translate([0,0,1]) cylinder(d1=14,d2=11,h=1);
  translate([0,0,-20]) cylinder(d=12,h=20);
  translate([-1,3.5,-28]) cube([2,0.5,8]);
  translate([-1,-3.5,-28]) cube([2,0.5,8]);
  translate([3.5,-1,-25]) cube([0.5,2,5]);
  translate([-3.5,-1,-25]) cube([0.5,2,5]);
}


module screw(h=6,support=false, double=false) {
  $fn=30;
  // dans piceph v1: d ext = 6 trou = 2.5
  // dans support trou 3.8
  

  difference() {
    cylinder(h=h,d=6);
    translate([0,0,-2]) cylinder(h=10,d=2.4);
  }
  if (support) {
    difference() {
      translate ([-3,0,0]) cube([6,support,h]);
      translate([0,0,-2]) cylinder(h=10,d=5);
    }
    if (double) difference() {
      translate ([-3,-support,0]) cube([6,support,h]);
      translate([0,0,-2]) cylinder(h=10,d=5);
    }
  }
}


//push_button_self_lock();
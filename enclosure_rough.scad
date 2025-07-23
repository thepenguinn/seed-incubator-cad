include <polyround.scad>

include <enclosure_header.scad>

$fn = 100;

module inc_area_base_plate() {
    polygon(polyRound(incBasePoints, fn = 12));
}

module inc_area() {
    lx(incHeight) {
        inc_area_base_plate();
    }
}

module inc_area_base_plate() {
    polygon(polyRound(incBasePoints, fn = 12));
}

module water_res_side_plate() {
    polygon(polyRound(waterResSidePoints, fn = 12));
}

module water_res() {
    translate([0, -waterResDepth / 2, 0]) {
        rotate([-90, 0, 0]) {
            lx(waterResDepth) {
                water_res_side_plate();
            }
        }
    }
}


inc_area();

water_res();

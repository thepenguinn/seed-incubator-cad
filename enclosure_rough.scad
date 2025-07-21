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

inc_area();

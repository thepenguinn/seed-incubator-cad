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

module top_hatch_side_plate() {
    translate([incLength - topHatchLength, -incHeight, 0]) {
        polygon(polyRound(topHatchSidePoints, fn = 12));
    }
}

module top_hatch() {
    translate([0, -topHatchDepth / 2, 0]) {
        rotate([-90, 0, 0]) {
            lx(topHatchDepth) {
                top_hatch_side_plate();
            }
        }
    }
}

module ded_cooler_base_plate() {
    translate([incLength - topHatchLength, -incDepth / 2, 0]) {
        polygon(polyRound(dedCoolerBasePoints, fn = 12));
    }

    mirror([0, 1, 0]) {
        translate([incLength - topHatchLength, -incDepth / 2, 0]) {
            polygon(polyRound(dedCoolerBasePoints, fn = 12));
        }
    }
}


module ded_cooler() {
    translate([0, 0, incHeight - dedCoolerHeight]) {
        lx(dedCoolerHeight) {
            ded_cooler_base_plate();
        }
    }
}

module elec_bay_side_plate() {
    polygon(polyRound(elecBaySidePoints, fn = 12));
}

module elec_bay() {
    translate([incLength, -elecBayDepth / 2, 0]) {
        rotate([90, 0, 0]) {
            lx(-elecBayDepth) {
                elec_bay_side_plate();
            }
        }
    }
}

module hume_res_base_plate() {
    translate([humeResXOffset, -incDepth / 2, 0]) {
        polygon(polyRound(humeResBasePoints, fn = 12));
    }


    translate([incLength - humeResXOffset - humeResLength, incDepth / 2, 0]) {
        mirror([0, 1, 0]) {
            polygon(polyRound(humeResBasePoints, fn = 12));
        }
    }
}

module hume_res() {
    translate([0, 0, soilDepth]) {
        lx(humeResHeight) {
            hume_res_base_plate();
        }
    }
}

module ext_block_side_plate() {
    polygon(polyRound(extBlockSidePoints, fn = 12));
}

module ext_block() {
    translate([0, -extBlockDepth / 2, incHeight]) {
        rotate([90, 0, 0]) {
            lx(-extBlockDepth) {
                ext_block_side_plate();
            }
        }
    }
}

ext_block();
hume_res();
elec_bay();
ded_cooler();
top_hatch();
inc_area();
water_res();

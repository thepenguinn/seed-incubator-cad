include <polyround.scad>

include <enclosure_header.scad>

$fn = 100;

/*\def\leafColorPrimaryName{Sage}*/
/*\def\leafColorPrimaryRGB{138, 184, 114}*/
/*\def\leafColorPrimaryHex{\#8AB872}*/
/*\definecolor{leafColorPrimary} {RGB} {\leafColorPrimaryRGB}*/
/*%%*/
/*\def\leafColorSecondaryName{Cactus Spike}*/
/*\def\leafColorSecondaryRGB{204, 224, 153}*/
/*\def\leafColorSecondaryHex{\#CCE099}*/

/*\def\seedColorPrimaryRGB{198, 140, 136}*/
/*\def\seedColorPrimaryHex{\#C68C88}*/
/*\definecolor{seedColorPrimary} {RGB} {\seedColorPrimaryRGB}*/
/*%%*/
/*\def\seedColorSecondaryName{Peach Dunes}*/
/*\def\seedColorSecondaryRGB{180, 104, 98}*/
/*\def\seedColorSecondaryHex{\#B46862}*/


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

module ext_pipe_side_plate() {
    polygon(polyRound(extPipeSidePoints, fn = 12));
}

module ext_pipe_single() {
    translate([0, -incDepth / 2, 0]) {
        rotate([90, 0, 0]) {
            lx(-extPipeCrossSideLength) {
                ext_pipe_side_plate();
            }
        }
    }
}

module ext_pipe() {
    translate([0, 0, soilDepth]) {
        ext_pipe_single();
        mirror([0, 1, 0]) {
            ext_pipe_single();
        }
    }
}

module ext() {
    ext_pipe();
    ext_block();
}

module side_hatch_base_plate() {
    polygon(polyRound(sideHatchBasePoints, fn = 12));
}

module side_hatch() {
    translate([sideHatchXOffset, incDepth / 2, incHeight - sideHatchHeight - sideHatchZOffset]) {
        lx(sideHatchHeight) {
            side_hatch_base_plate();
        }
    }
}

module color_red(opacity = 1) {
    color([0.7, 0.4, 0.38, opacity]) {
        children(0);
    }
}

module color_cactus_green(opacity = 1) {
    color([0.8, 0.87, 0.6, opacity]) {
        children(0);
    }
}

module color_sage_green(opacity = 1) {
    color([0.54, 0.72, 0.44, opacity]) {
        children(0);
    }
}

module inc() {

    color_sage_green() {
        union() {
            side_hatch();
            ext();
            top_hatch();
        }
    }

    color_cactus_green() {
        union() {
            ded_cooler();
            hume_res();
            water_res();
        }
    }

    color_cactus_green(0.5) {
        union() {
            elec_bay();
            inc_area();
        }
    }

}

module ext_both() {
    ext();
    ded_cooler();
}

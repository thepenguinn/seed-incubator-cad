#!/bin/bash

# Image_Size="2160,2160"
Image_Size="640,640"
Projection="ortho"
Colorscheme="Seed-Inc"
View="edges"

Tmp_File="_render_tmp.scad"

Camera_Left="475,0,340,56,0,50,4336.18"
Camera_Right="475,0,340,56,0,130,4336.18"
Camera="-3.20,-37.35,100.67,64.80,0.00,324.10,2035.62"
Base_Camera="0,0,50,64.80,0.00,324.10,2135.62"
Top_Single_Camera="0,0,270,64.80,0.00,324.10,2035.62"
Top_Both_Camera="0,0,300,64.80,0.00,324.10,2735.62"
Elec_Camera="0,0,340,64.80,0.00,324.10,2535.62"
# Camera="-3.20,-37.35,299.67,64.80,0.00,324.10,3035.62"

# openscad --camera=475,0,340,56.9,0,49.8,4336.18 --projection=ortho --colorscheme Transylvania  -o hai.png --view edges enclosure_rough.scad && sxiv hai.png

declare -a Part_Array

Part_Array+=( "back_base" \
    "back_side_hatch" \
    "back_side_panels" \
    "back_side_panel" \
    "elec_bay" \
    "front_back_panels" \
    "front_base" \
    "front_panel" \
    "front_side_panels" \
    "front_side_panel"
)

# $1 -> filename
gen_oscad_script() {
    printf "translate([-500, -500, 0]) {\n"
    printf "    import(\"$1.stl\");\n"
    printf "}\n"
}

for i in $(seq 0 $((${#Part_Array[@]}-1)))
do
    gen_oscad_script "${Part_Array[$i]}" > tmp.scad

    img_name="${Part_Array[$i]}.png"

    case "${Part_Array[$i]}" in
        back_base|front_base)
            Camera="$Base_Camera"
            ;;
        elec_bay)
            Camera="$Elec_Camera"
            ;;
        back_side_panel|front_side_panel|back_side_hatch|front_panel)
            Camera="$Top_Single_Camera"
            ;;
        *)
            Camera="$Top_Both_Camera"
            ;;
    esac

    openscad --camera=$Camera --projection=$Projection --colorscheme=$Colorscheme --imgsize=$Image_Size -o "$img_name" --view $View tmp.scad
    bg_color=$(magick ${img_name} -format "#%[hex:u.p{0,0}]" info:)
    magick ${img_name} -transparent "$bg_color" ${img_name}

done

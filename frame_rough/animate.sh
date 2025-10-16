#!/bin/bash

Selected_Part_Suffix=""
Other_Part_Suffix="%%"

Image_Size="1080,1080"
Projection="ortho"
Colorscheme="Seed-Inc"
View="edges"

Tmp_File="_render_tmp.scad"

Camera_Before="475,0,340,56,0,"
Camera_After=",4336.18"

# openscad --camera=475,0,340,56.9,0,49.8,4336.18 --projection=ortho --colorscheme Transylvania  -o hai.png --view edges enclosure_rough.scad && sxiv hai.png

declare -a Part_Array

# Part_Array+=( "side_hatch" \
# )

Part_Array+=( "ext" \
    "side_hatch" \
    "hume_res" \
    "elec_bay" \
    "ded_cooler" \
    "top_hatch" \
    "inc_area" \
    "water_res"
)

Frame_Number=0

for i in $(seq 0 $((${#Part_Array[@]}-1)))
do
    printf "" > ${Tmp_File}
    printf "include<enclosure_rough_modules.scad>\n\n" >> ${Tmp_File}
    for j in $(seq 0 $((${#Part_Array[@]}-1)))
    do
        if [[ i -eq j ]]; then
            printf "$Selected_Part_Suffix${Part_Array[$j]}();\n" >> ${Tmp_File}
        else
            printf "$Other_Part_Suffix${Part_Array[$j]}();\n" >> ${Tmp_File}
        fi
    done

    for k in $(seq 0 359)
    do
        img_name=$(printf "%0.4d.png" ${Frame_Number})
        Frame_Number=$((Frame_Number+1))
        echo $img_name done
        openscad --camera=${Camera_Before}${k}${Camera_After} --projection=$Projection --colorscheme=$Colorscheme --imgsize=$Image_Size -o "$img_name" --view $View $Tmp_File

        bg_color=$(magick ${img_name} -format "#%[hex:u.p{0,0}]" info:)
        magick ${img_name} -transparent "$bg_color" ${img_name}

        # for l in $(seq 0 9)
        # do
        # done
    done

    exit 0

    # img_name="${Part_Array[$i]}_left.png"
    #
    # openscad --camera=$Camera_Left --projection=$Projection --colorscheme=$Colorscheme --imgsize=$Image_Size -o "$img_name" --view $View $Tmp_File
    # bg_color=$(magick ${img_name} -format "#%[hex:u.p{0,0}]" info:)
    # magick ${img_name} -transparent "$bg_color" ${img_name}
    #
    # img_name="${Part_Array[$i]}_right.png"
    #
    # openscad --camera=$Camera_Right --projection=$Projection --colorscheme=$Colorscheme --imgsize=$Image_Size -o "$img_name" --view $View $Tmp_File
    # bg_color=$(magick ${img_name} -format "#%[hex:u.p{0,0}]" info:)
    # magick ${img_name} -transparent "$bg_color" ${img_name}

done

# for i in $()

# for i in ${Part_Array[@]}
# do
#     printf "include<enclosure_rough_modules.scad>\n${i}();\n"
# done

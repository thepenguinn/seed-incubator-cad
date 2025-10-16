#!/bin/bash

Image_Size="2160,2160"
Projection="p"
Colorscheme="Render-Brown"
View="edges"

Tmp_File="_render_tmp.scad"

# Camera_Left="-26.65,-8.30,0.23,89.70,326.90,297.10,298.94"

# Camera_Left="-3.65,-8.30,3.23,89.70,326.90,297.10,298.94" # real

# Camera_Left="-4.20,-6.20,4.96,48.2,0,295.90,355.7"

# Camera_Left="475,0,340,56,0,50,4336.18"
Camera_Right="475,0,340,56,0,130,4336.18"

# openscad --camera=475,0,340,56.9,0,49.8,4336.18 --projection=ortho --colorscheme Transylvania  -o hai.png --view edges enclosure_rough.scad && sxiv hai.png


img_name="render_ppt.png"

printf "include<enclosure_rough_modules.scad>\n\n" > ${Tmp_File}
printf "inc();\n"                >> $Tmp_File

openscad --camera=$Camera_Right --projection=$Projection --colorscheme=$Colorscheme --imgsize=$Image_Size -o "$img_name" --view $View $Tmp_File
bg_color=$(magick ${img_name} -format "#%[hex:u.p{0,0}]" info:)
magick ${img_name} -transparent "$bg_color" ${img_name}

# img_name="info_panel.png"
#
# printf "include<phone_model_modules.scad>\n" > $Tmp_File
#
# printf "rotate([0, -45, 0]) {\n"            >> $Tmp_File
# printf "    info_section(panel = false);\n" >> $Tmp_File
# printf "}\n"                                >> $Tmp_File

# Colorscheme="Render-Brown"
#
# openscad --render --camera=$Camera_Right --projection=$Projection --colorscheme=$Colorscheme --imgsize=$Image_Size -o "$img_name" --view $View $Tmp_File
# bg_color=$(magick ${img_name} -format "#%[hex:u.p{0,0}]" info:)
# magick ${img_name} -transparent "$bg_color" ${img_name}
#
# magick rest.png info_panel.png -gravity center -composite render_output.png

# img_name="right.png"
#
# openscad --camera=$Camera_Right --projection=$Projection --colorscheme=$Colorscheme --imgsize=$Image_Size -o "$img_name" --view $View sap_model.scad
# bg_color=$(magick ${img_name} -format "#%[hex:u.p{0,0}]" info:)
# magick ${img_name} -transparent "$bg_color" ${img_name}

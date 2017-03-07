set version "2014.4"
set project_name "vivado_zedboard_btrd"
set project_dir "../project"
set ip_dir "../../hardware"
set hdl_dir "../srcs/hdl"
set ui_dir "../srcs/ui"
set constrs_dir "../data"
set scripts_dir ""
set bd_name "zedboard_btrd"
set part "xc7z020clg484-1"
set board_part "em.avnet.com:zed:part0:0.9"

# set up project
create_project $project_name $project_dir -part $part -force
set_property board_part $board_part [current_project]
set_property "target_language" VHDL [current_project]

# set up IP repo
set_property ip_repo_paths $ip_dir [current_fileset]
update_ip_catalog -rebuild

# set up bd design
create_bd_design $bd_name
source zedboard_btrd.tcl
validate_bd_design
save_bd_design
close_bd_design $bd_name

# add hdl sources and xdc constraints to project
add_files -fileset sources_1 -norecurse $hdl_dir/${bd_name}_wrapper.vhd
add_files -fileset constrs_1 -norecurse $constrs_dir/$bd_name.xdc

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

# apply UI file
file mkdir $project_dir/$project_name.srcs/sources_1/bd/$bd_name/ui
file copy -force $ui_dir/bd_9f6d3656.ui $project_dir/$project_name.srcs/sources_1/bd/$bd_name/ui/bd_9f6d3656.ui

# re-open bd design with layout and comments
open_bd_design $project_dir/$project_name.srcs/sources_1/bd/$bd_name/$bd_name.bd


################################################################
# This is a generated script based on design: zedboard_btrd
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2014.4
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   puts "ERROR: This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source zedboard_btrd_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:
#    create_project project_1 myproj -part xc7z020clg484-1
#    set_property BOARD_PART em.avnet.com:zed:part0:0.9 [current_project]


# CHANGE DESIGN NAME HERE
set design_name zedboard_btrd

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
   puts "ERROR: Please open or create a project!"
   return 1
}


# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "ERROR: Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      puts "INFO: Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   puts "INFO: Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   puts "INFO: Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   puts "INFO: Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

puts "INFO: Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   puts $errMsg
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: processing
proc create_hier_cell_processing { parentCell nameHier } {

  if { $parentCell eq "" || $nameHier eq "" } {
     puts "ERROR: create_hier_cell_processing() - Empty argument(s)!"
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_MM2S
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_S2MM
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_CONTROL_BUS
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_LITE

  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -from 0 -to 0 -type rst aresetn
  create_bd_pin -dir O -type intr interrupt
  create_bd_pin -dir I mm2s_fsync
  create_bd_pin -dir O -type intr mm2s_introut
  create_bd_pin -dir O -type intr s2mm_introut
  create_bd_pin -dir I -type clk s_axi_lite_aclk

  # Create instance: axi_vdma_2, and set properties
  set axi_vdma_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.2 axi_vdma_2 ]
  set_property -dict [ list CONFIG.c_m_axi_mm2s_data_width {32} CONFIG.c_m_axi_s2mm_data_width {32} CONFIG.c_m_axis_mm2s_tdata_width {16} CONFIG.c_mm2s_linebuffer_depth {4096} CONFIG.c_mm2s_max_burst_length {16} CONFIG.c_num_fstores {1} CONFIG.c_s2mm_linebuffer_depth {4096} CONFIG.c_s2mm_max_burst_length {16} CONFIG.c_use_mm2s_fsync {1}  ] $axi_vdma_2

  # Create instance: axis_register_slice_0, and set properties
  set axis_register_slice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 axis_register_slice_0 ]

  # Create instance: axis_register_slice_1, and set properties
  set axis_register_slice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 axis_register_slice_1 ]

  # Create instance: image_filter_1, and set properties
  set image_filter_1 [ create_bd_cell -type ip -vlnv xilinx.com:hls:image_filter:1.0 image_filter_1 ]

  # Create interface connections
  connect_bd_intf_net -intf_net axi_interconnect_gp0_M02_AXI [get_bd_intf_pins S_AXI_LITE] [get_bd_intf_pins axi_vdma_2/S_AXI_LITE]
  connect_bd_intf_net -intf_net axi_interconnect_gp0_M06_AXI [get_bd_intf_pins S_AXI_CONTROL_BUS] [get_bd_intf_pins image_filter_1/s_axi_CONTROL_BUS]
  connect_bd_intf_net -intf_net axi_vdma_2_M_AXIS_MM2S [get_bd_intf_pins axi_vdma_2/M_AXIS_MM2S] [get_bd_intf_pins axis_register_slice_1/S_AXIS]
  connect_bd_intf_net -intf_net axi_vdma_2_M_AXI_MM2S [get_bd_intf_pins M_AXI_MM2S] [get_bd_intf_pins axi_vdma_2/M_AXI_MM2S]
  connect_bd_intf_net -intf_net axi_vdma_2_M_AXI_S2MM [get_bd_intf_pins M_AXI_S2MM] [get_bd_intf_pins axi_vdma_2/M_AXI_S2MM]
  connect_bd_intf_net -intf_net axis_register_slice_0_M_AXIS [get_bd_intf_pins axi_vdma_2/S_AXIS_S2MM] [get_bd_intf_pins axis_register_slice_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_register_slice_1_M_AXIS [get_bd_intf_pins axis_register_slice_1/M_AXIS] [get_bd_intf_pins image_filter_1/video_in]
  connect_bd_intf_net -intf_net image_filter_0_video_out [get_bd_intf_pins axis_register_slice_0/S_AXIS] [get_bd_intf_pins image_filter_1/video_out]

  # Create port connections
  connect_bd_net -net axi_vdma_2_mm2s_introut [get_bd_pins mm2s_introut] [get_bd_pins axi_vdma_2/mm2s_introut]
  connect_bd_net -net axi_vdma_2_s2mm_introut [get_bd_pins s2mm_introut] [get_bd_pins axi_vdma_2/s2mm_introut]
  connect_bd_net -net clk_wiz_1_clk_out1 [get_bd_pins s_axi_lite_aclk] [get_bd_pins axi_vdma_2/s_axi_lite_aclk]
  connect_bd_net -net clk_wiz_1_clk_out2 [get_bd_pins aclk] [get_bd_pins axi_vdma_2/m_axi_mm2s_aclk] [get_bd_pins axi_vdma_2/m_axi_s2mm_aclk] [get_bd_pins axi_vdma_2/m_axis_mm2s_aclk] [get_bd_pins axi_vdma_2/s_axis_s2mm_aclk] [get_bd_pins axis_register_slice_0/aclk] [get_bd_pins axis_register_slice_1/aclk] [get_bd_pins image_filter_1/ap_clk]
  connect_bd_net -net image_filter_1_interrupt [get_bd_pins interrupt] [get_bd_pins image_filter_1/interrupt]
  connect_bd_net -net mm2s_fsync_1 [get_bd_pins mm2s_fsync] [get_bd_pins axi_vdma_2/mm2s_fsync]
  connect_bd_net -net proc_sys_reset_1_interconnect_aresetn [get_bd_pins aresetn] [get_bd_pins axi_vdma_2/axi_resetn] [get_bd_pins axis_register_slice_0/aresetn] [get_bd_pins axis_register_slice_1/aresetn] [get_bd_pins image_filter_1/ap_rst_n]
  
  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hdmi_output
proc create_hier_cell_hdmi_output { parentCell nameHier } {

  if { $parentCell eq "" || $nameHier eq "" } {
     puts "ERROR: create_hier_cell_hdmi_output() - Empty argument(s)!"
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 LOGICVC_CTRL
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_axi
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:vid_io_rtl:1.0 vid_io

  # Create pins
  create_bd_pin -dir I -from 0 -to 0 -type rst aresetn
  create_bd_pin -dir I -type clk clk_150mhz
  create_bd_pin -dir I -type clk clk_75mhz
  create_bd_pin -dir O hdmio_clk
  create_bd_pin -dir O -type intr logicvc_int
  create_bd_pin -dir I -from 0 -to 0 logicvc_rst
  create_bd_pin -dir I video_clk

  # Create instance: logicvc_1, and set properties
  set logicvc_1 [ create_bd_cell -type ip -vlnv logicbricks.com:logicbricks:logicvc:4.1 logicvc_1 ]
  set_property -dict [ list CONFIG.C_BUFFER_0_OFFSET {1080} CONFIG.C_BUFFER_1_OFFSET {1080} CONFIG.C_DISPLAY_COLOR_SPACE {1} CONFIG.C_INCREASE_FIFO {4} CONFIG.C_LAYER_0_DATA_WIDTH {24} CONFIG.C_LAYER_1_TYPE {1} CONFIG.C_LAYER_2_DATA_WIDTH {24} CONFIG.C_NUM_OF_LAYERS {3} CONFIG.C_ROW_STRIDE {2048} CONFIG.C_USE_BACKGROUND {1}  ] $logicvc_1

  # Create interface connections
  connect_bd_intf_net -intf_net axi_interconnect_gp0_M05_AXI [get_bd_intf_pins LOGICVC_CTRL] [get_bd_intf_pins logicvc_1/s_axi]
  connect_bd_intf_net -intf_net logicvc_1_m_axi [get_bd_intf_pins m_axi] [get_bd_intf_pins logicvc_1/m_axi]
  connect_bd_intf_net -intf_net logicvc_1_vid_io [get_bd_intf_pins vid_io] [get_bd_intf_pins logicvc_1/vid_io]

  # Create port connections
  connect_bd_net -net clk_wiz_1_clk_out1 [get_bd_pins clk_75mhz] [get_bd_pins logicvc_1/S_AXI_ACLK]
  connect_bd_net -net clk_wiz_1_clk_out2 [get_bd_pins clk_150mhz] [get_bd_pins logicvc_1/M_AXI_ACLK]
  connect_bd_net -net logicvc_1_interrupt [get_bd_pins logicvc_int] [get_bd_pins logicvc_1/interrupt]
  connect_bd_net -net logicvc_1_pix_clk_o [get_bd_pins hdmio_clk] [get_bd_pins logicvc_1/pix_clk_o]
  connect_bd_net -net proc_sys_reset_1_bus_struct_reset [get_bd_pins logicvc_rst] [get_bd_pins logicvc_1/rst]
  connect_bd_net -net proc_sys_reset_1_interconnect_aresetn [get_bd_pins aresetn] [get_bd_pins logicvc_1/M_AXI_ARESETN] [get_bd_pins logicvc_1/S_AXI_ARESETN]
  connect_bd_net -net vclk_1 [get_bd_pins video_clk] [get_bd_pins logicvc_1/vclk]
  
  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: fmc_hdmi_input
proc create_hier_cell_fmc_hdmi_input { parentCell nameHier } {

  if { $parentCell eq "" || $nameHier eq "" } {
     puts "ERROR: create_hier_cell_fmc_hdmi_input() - Empty argument(s)!"
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv avnet.com:interface:avnet_hdmi_rtl:1.0 IO_HDMII
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_S2MM
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_LITE
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 TPG_CTRL
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 VTC_CTRL

  # Create pins
  create_bd_pin -dir I -from 0 -to 0 -type rst axi_resetn
  create_bd_pin -dir I -type clk clk_75mhz
  create_bd_pin -dir I -type clk m_axi_s2mm_aclk
  create_bd_pin -dir O s2mm_fsync_out
  create_bd_pin -dir O -type intr s2mm_introut
  create_bd_pin -dir I -from 0 -to 0 sel
  create_bd_pin -dir I video_clk_1
  create_bd_pin -dir I video_clk_2

  # Create instance: axi_vdma_1, and set properties
  set axi_vdma_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.2 axi_vdma_1 ]
  set_property -dict [ list CONFIG.c_enable_debug_info_11 {1} CONFIG.c_include_mm2s {0} CONFIG.c_m_axi_s2mm_data_width {32} CONFIG.c_num_fstores {1} CONFIG.c_s2mm_linebuffer_depth {4096} CONFIG.c_s2mm_max_burst_length {16}  ] $axi_vdma_1

  # Create instance: clock_mux_1, and set properties
  set clock_mux_1 [ create_bd_cell -type ip -vlnv xilinx.com:user:clock_mux:1.0 clock_mux_1 ]

  # Create instance: fmc_imageon_hdmi_in_1, and set properties
  set fmc_imageon_hdmi_in_1 [ create_bd_cell -type ip -vlnv avnet:fmc_imageon:fmc_imageon_hdmi_in:2.0 fmc_imageon_hdmi_in_1 ]

  # Create instance: v_tc_1, and set properties
  set v_tc_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_tc:6.1 v_tc_1 ]
  set_property -dict [ list CONFIG.VIDEO_MODE {1080p} CONFIG.horizontal_sync_detection {false} CONFIG.vertical_sync_detection {false}  ] $v_tc_1

  # Create instance: v_tpg_1, and set properties
  set v_tpg_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_tpg:6.0 v_tpg_1 ]
  set_property -dict [ list CONFIG.has_vtiming {true} CONFIG.pattern_control {10}  ] $v_tpg_1

  # Create instance: v_vid_in_axi4s_1, and set properties
  set v_vid_in_axi4s_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_vid_in_axi4s:3.0 v_vid_in_axi4s_1 ]
  set_property -dict [ list CONFIG.C_M_AXIS_VIDEO_FORMAT {0}  ] $v_vid_in_axi4s_1

  # Create interface connections
  connect_bd_intf_net -intf_net IO_HDMII_1 [get_bd_intf_pins IO_HDMII] [get_bd_intf_pins fmc_imageon_hdmi_in_1/IO_HDMII]
  connect_bd_intf_net -intf_net axi_interconnect_gp0_M00_AXI [get_bd_intf_pins VTC_CTRL] [get_bd_intf_pins v_tc_1/ctrl]
  connect_bd_intf_net -intf_net axi_interconnect_gp0_M01_AXI [get_bd_intf_pins S_AXI_LITE] [get_bd_intf_pins axi_vdma_1/S_AXI_LITE]
  connect_bd_intf_net -intf_net axi_interconnect_gp0_M04_AXI [get_bd_intf_pins TPG_CTRL] [get_bd_intf_pins v_tpg_1/ctrl]
  connect_bd_intf_net -intf_net axi_vdma_1_M_AXI_S2MM [get_bd_intf_pins M_AXI_S2MM] [get_bd_intf_pins axi_vdma_1/M_AXI_S2MM]
  connect_bd_intf_net -intf_net fmc_imageon_hdmi_in_1_VID_IO_OUT [get_bd_intf_pins fmc_imageon_hdmi_in_1/VID_IO_OUT] [get_bd_intf_pins v_vid_in_axi4s_1/vid_io_in]
  connect_bd_intf_net -intf_net v_tc_1_vtiming_out [get_bd_intf_pins v_tc_1/vtiming_out] [get_bd_intf_pins v_tpg_1/vtiming_in]
  connect_bd_intf_net -intf_net v_tpg_1_video_out [get_bd_intf_pins axi_vdma_1/S_AXIS_S2MM] [get_bd_intf_pins v_tpg_1/video_out]
  connect_bd_intf_net -intf_net v_vid_in_axi4s_1_video_out [get_bd_intf_pins v_tpg_1/video_in] [get_bd_intf_pins v_vid_in_axi4s_1/video_out]
  connect_bd_intf_net -intf_net v_vid_in_axi4s_1_vtiming_out [get_bd_intf_pins v_tc_1/vtiming_in] [get_bd_intf_pins v_vid_in_axi4s_1/vtiming_out]

  # Create port connections
  connect_bd_net -net axi_vdma_1_s2mm_fsync_out [get_bd_pins s2mm_fsync_out] [get_bd_pins axi_vdma_1/s2mm_fsync_out]
  connect_bd_net -net axi_vdma_1_s2mm_introut [get_bd_pins s2mm_introut] [get_bd_pins axi_vdma_1/s2mm_introut]
  connect_bd_net -net clk_in_1_1 [get_bd_pins video_clk_1] [get_bd_pins clock_mux_1/clk_in_1]
  connect_bd_net -net clk_in_2_1 [get_bd_pins video_clk_2] [get_bd_pins clock_mux_1/clk_in_2]
  connect_bd_net -net clk_wiz_1_clk_out1 [get_bd_pins clk_75mhz] [get_bd_pins axi_vdma_1/s_axi_lite_aclk] [get_bd_pins v_tc_1/s_axi_aclk] [get_bd_pins v_tpg_1/s_axi_aclk]
  connect_bd_net -net clk_wiz_1_clk_out2 [get_bd_pins m_axi_s2mm_aclk] [get_bd_pins axi_vdma_1/m_axi_s2mm_aclk]
  connect_bd_net -net clock_mux_1_clk_out [get_bd_pins axi_vdma_1/s_axis_s2mm_aclk] [get_bd_pins clock_mux_1/clk_out] [get_bd_pins fmc_imageon_hdmi_in_1/clk] [get_bd_pins v_tc_1/clk] [get_bd_pins v_tpg_1/aclk] [get_bd_pins v_vid_in_axi4s_1/aclk] [get_bd_pins v_vid_in_axi4s_1/vid_io_in_clk]
  connect_bd_net -net emio_gpio_Dout [get_bd_pins sel] [get_bd_pins clock_mux_1/sel]
  connect_bd_net -net proc_sys_reset_1_interconnect_aresetn [get_bd_pins axi_resetn] [get_bd_pins axi_vdma_1/axi_resetn]
  
  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: emio_gpio
proc create_hier_cell_emio_gpio { parentCell nameHier } {

  if { $parentCell eq "" || $nameHier eq "" } {
     puts "ERROR: create_hier_cell_emio_gpio() - Empty argument(s)!"
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -from 1 -to 0 Din
  create_bd_pin -dir O -from 0 -to 0 iic_rst_b
  create_bd_pin -dir O -from 0 -to 0 video_sel

  # Create instance: iic_rst_b, and set properties
  set iic_rst_b [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 iic_rst_b ]
  set_property -dict [ list CONFIG.DIN_WIDTH {2}  ] $iic_rst_b

  # Create instance: video_sel, and set properties
  set video_sel [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 video_sel ]
  set_property -dict [ list CONFIG.DIN_FROM {1} CONFIG.DIN_TO {1} CONFIG.DIN_WIDTH {2}  ] $video_sel

  # Create port connections
  connect_bd_net -net processing_system7_1_GPIO_O [get_bd_pins Din] [get_bd_pins iic_rst_b/Din] [get_bd_pins video_sel/Din]
  connect_bd_net -net tpg_rst1_dout [get_bd_pins iic_rst_b] [get_bd_pins iic_rst_b/Dout]
  connect_bd_net -net video_sel_Dout [get_bd_pins video_sel] [get_bd_pins video_sel/Dout]
  
  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR ]
  set FIXED_IO [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO ]
  set IIC_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 IIC_0 ]
  set IO_HDMII [ create_bd_intf_port -mode Slave -vlnv avnet.com:interface:avnet_hdmi_rtl:1.0 IO_HDMII ]
  set fmc_imageon_iic [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 fmc_imageon_iic ]
  set hdmio [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:vid_io_rtl:1.0 hdmio ]

  # Create ports
  set fmc_imageon_hdmii_clk [ create_bd_port -dir I -type clk fmc_imageon_hdmii_clk ]
  set fmc_imageon_iic_rst_b [ create_bd_port -dir O -from 0 -to 0 fmc_imageon_iic_rst_b ]
  set hdmio_clk [ create_bd_port -dir O -type clk hdmio_clk ]
  set hdmio_int_b [ create_bd_port -dir I hdmio_int_b ]

  # Create instance: axi_interconnect_gp0, and set properties
  set axi_interconnect_gp0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_gp0 ]
  set_property -dict [ list CONFIG.NUM_MI {8}  ] $axi_interconnect_gp0

  # Create instance: axi_interconnect_hp0, and set properties
  set axi_interconnect_hp0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_hp0 ]
  set_property -dict [ list CONFIG.ENABLE_ADVANCED_OPTIONS {1} CONFIG.M00_HAS_DATA_FIFO {2} CONFIG.M00_HAS_REGSLICE {1} CONFIG.NUM_MI {1} CONFIG.NUM_SI {2} CONFIG.S00_HAS_REGSLICE {1} CONFIG.S01_HAS_REGSLICE {1} CONFIG.STRATEGY {2}  ] $axi_interconnect_hp0

  # Create instance: axi_interconnect_hp2, and set properties
  set axi_interconnect_hp2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_hp2 ]
  set_property -dict [ list CONFIG.ENABLE_ADVANCED_OPTIONS {1} CONFIG.M00_HAS_DATA_FIFO {2} CONFIG.M00_HAS_REGSLICE {1} CONFIG.NUM_MI {1} CONFIG.NUM_SI {2} CONFIG.S00_HAS_REGSLICE {1} CONFIG.S01_HAS_REGSLICE {1} CONFIG.STRATEGY {2} CONFIG.XBAR_DATA_WIDTH {64}  ] $axi_interconnect_hp2

  # Create instance: axi_perf_mon_1, and set properties
  set axi_perf_mon_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_perf_mon:5.0 axi_perf_mon_1 ]
  set_property -dict [ list CONFIG.C_ENABLE_PROFILE {1} CONFIG.C_NUM_MONITOR_SLOTS {3} CONFIG.C_SLOT_0_AXI_PROTOCOL {AXI3} CONFIG.C_SLOT_1_AXI_PROTOCOL {AXI3} CONFIG.C_SLOT_2_AXI_PROTOCOL {AXI3} CONFIG.ENABLE_EXT_TRIGGERS {1}  ] $axi_perf_mon_1

  # Create instance: clk_wiz_1, and set properties
  set clk_wiz_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.1 clk_wiz_1 ]
  set_property -dict [ list CONFIG.CLKOUT1_JITTER {145.943} CONFIG.CLKOUT1_PHASE_ERROR {94.994} CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {50.000} CONFIG.CLKOUT2_JITTER {116.798} CONFIG.CLKOUT2_PHASE_ERROR {94.994} CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {150.000} CONFIG.CLKOUT2_USED {true} CONFIG.NUM_OUT_CLKS {2} CONFIG.PRIM_SOURCE {No_buffer} CONFIG.USE_RESET {false}  ] $clk_wiz_1

  # Create instance: emio_gpio
  create_hier_cell_emio_gpio [current_bd_instance .] emio_gpio

  # Create instance: fmc_hdmi_input
  create_hier_cell_fmc_hdmi_input [current_bd_instance .] fmc_hdmi_input

  # Create instance: hdmi_output
  create_hier_cell_hdmi_output [current_bd_instance .] hdmi_output

  # Create instance: logiclk_1, and set properties
  set logiclk_1 [ create_bd_cell -type ip -vlnv logicbricks.com:logicbricks:logiclk:1.2 logiclk_1 ]
  set_property -dict [ list CONFIG.C_CLK0_DIVIDE {12} CONFIG.C_CLK1_DIVIDE {12} CONFIG.C_CLK2_DIVIDE {12} CONFIG.C_CLK3_DIVIDE {12} CONFIG.C_CLK4_DIVIDE {12} CONFIG.C_CLK5_DIVIDE {12} CONFIG.C_CLK_MULTIPLY {12} CONFIG.C_DRP_CLKFBOUT_MULT {9} CONFIG.C_DRP_CLKOUT0_DIVIDE {6} CONFIG.C_DRP_CLKOUT1_DIVIDE {9} CONFIG.C_DRP_CLKOUT2_DIVIDE {9} CONFIG.C_DRP_CLKOUT3_DIVIDE {9} CONFIG.C_DRP_CLKOUT4_DIVIDE {9} CONFIG.C_DRP_CLKOUT5_DIVIDE {9} CONFIG.C_RST_POLARITY {0} CONFIG.C_USE_CLK_DRP {1}  ] $logiclk_1

  # Create instance: proc_sys_reset_1, and set properties
  set proc_sys_reset_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_1 ]

  # Create instance: processing
  create_hier_cell_processing [current_bd_instance .] processing

  # Create instance: processing_system7_1, and set properties
  set processing_system7_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_1 ]
  set_property -dict [ list CONFIG.PCW_ENET0_ENET0_IO {MIO 16 .. 27} \
CONFIG.PCW_ENET0_GRP_MDIO_ENABLE {1} CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_ENET0_PERIPHERAL_FREQMHZ {100 Mbps} CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100} \
CONFIG.PCW_GPIO_EMIO_GPIO_ENABLE {1} CONFIG.PCW_GPIO_EMIO_GPIO_IO {2} \
CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1} CONFIG.PCW_I2C0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_I2C1_PERIPHERAL_ENABLE {1} CONFIG.PCW_IRQ_F2P_INTR {1} \
CONFIG.PCW_MIO_11_PULLUP {disabled} CONFIG.PCW_MIO_13_PULLUP {disabled} \
CONFIG.PCW_MIO_16_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_16_PULLUP {disabled} \
CONFIG.PCW_MIO_17_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_17_PULLUP {disabled} \
CONFIG.PCW_MIO_18_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_18_PULLUP {disabled} \
CONFIG.PCW_MIO_19_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_19_PULLUP {disabled} \
CONFIG.PCW_MIO_20_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_20_PULLUP {disabled} \
CONFIG.PCW_MIO_21_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_21_PULLUP {disabled} \
CONFIG.PCW_MIO_22_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_22_PULLUP {disabled} \
CONFIG.PCW_MIO_23_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_23_PULLUP {disabled} \
CONFIG.PCW_MIO_24_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_24_PULLUP {disabled} \
CONFIG.PCW_MIO_25_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_25_PULLUP {disabled} \
CONFIG.PCW_MIO_26_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_26_PULLUP {disabled} \
CONFIG.PCW_MIO_27_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_27_PULLUP {disabled} \
CONFIG.PCW_MIO_28_PULLUP {disabled} CONFIG.PCW_MIO_29_PULLUP {disabled} \
CONFIG.PCW_MIO_2_SLEW {slow} CONFIG.PCW_MIO_30_PULLUP {disabled} \
CONFIG.PCW_MIO_31_PULLUP {disabled} CONFIG.PCW_MIO_32_PULLUP {disabled} \
CONFIG.PCW_MIO_33_PULLUP {disabled} CONFIG.PCW_MIO_34_PULLUP {disabled} \
CONFIG.PCW_MIO_35_PULLUP {disabled} CONFIG.PCW_MIO_36_PULLUP {disabled} \
CONFIG.PCW_MIO_37_PULLUP {disabled} CONFIG.PCW_MIO_38_PULLUP {disabled} \
CONFIG.PCW_MIO_39_PULLUP {disabled} CONFIG.PCW_MIO_3_SLEW {slow} \
CONFIG.PCW_MIO_40_PULLUP {disabled} CONFIG.PCW_MIO_41_PULLUP {disabled} \
CONFIG.PCW_MIO_42_PULLUP {disabled} CONFIG.PCW_MIO_43_PULLUP {disabled} \
CONFIG.PCW_MIO_44_PULLUP {disabled} CONFIG.PCW_MIO_45_PULLUP {disabled} \
CONFIG.PCW_MIO_46_PULLUP {disabled} CONFIG.PCW_MIO_47_PULLUP {disabled} \
CONFIG.PCW_MIO_48_PULLUP {disabled} CONFIG.PCW_MIO_49_PULLUP {disabled} \
CONFIG.PCW_MIO_4_SLEW {slow} CONFIG.PCW_MIO_52_PULLUP {disabled} \
CONFIG.PCW_MIO_53_PULLUP {disabled} CONFIG.PCW_MIO_5_SLEW {slow} \
CONFIG.PCW_MIO_6_SLEW {slow} CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V} \
CONFIG.PCW_QSPI_GRP_FBCLK_ENABLE {1} CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_SD0_GRP_CD_ENABLE {1} CONFIG.PCW_SD0_GRP_CD_IO {MIO 47} \
CONFIG.PCW_SD0_GRP_WP_ENABLE {1} CONFIG.PCW_SD0_GRP_WP_IO {MIO 46} \
CONFIG.PCW_SD0_PERIPHERAL_ENABLE {1} CONFIG.PCW_SDIO_PERIPHERAL_FREQMHZ {50} \
CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY0 {0.41} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY1 {0.411} CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY2 {0.341} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY3 {0.358} CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_0 {0.025} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_1 {0.028} CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_2 {-0.009} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_3 {0.061} CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41J128M16 HA-15E} \
CONFIG.PCW_UIPARAM_DDR_TRAIN_DATA_EYE {1} CONFIG.PCW_UIPARAM_DDR_TRAIN_READ_GATE {1} \
CONFIG.PCW_UIPARAM_DDR_TRAIN_WRITE_LEVEL {1} CONFIG.PCW_UIPARAM_DDR_USE_INTERNAL_VREF {1} \
CONFIG.PCW_USB0_PERIPHERAL_ENABLE {1} CONFIG.PCW_USE_FABRIC_INTERRUPT {1} \
CONFIG.PCW_USE_S_AXI_HP0 {1} CONFIG.PCW_USE_S_AXI_HP2 {1} \
 ] $processing_system7_1

  # Create instance: xlconcat_1, and set properties
  set xlconcat_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_1 ]
  set_property -dict [ list CONFIG.NUM_PORTS {7}  ] $xlconcat_1

  # Create interface connections
  connect_bd_intf_net -intf_net IO_HDMII_1 [get_bd_intf_ports IO_HDMII] [get_bd_intf_pins fmc_hdmi_input/IO_HDMII]
  connect_bd_intf_net -intf_net axi_interconnect_gp0_M00_AXI [get_bd_intf_pins axi_interconnect_gp0/M00_AXI] [get_bd_intf_pins fmc_hdmi_input/VTC_CTRL]
  connect_bd_intf_net -intf_net axi_interconnect_gp0_M01_AXI [get_bd_intf_pins axi_interconnect_gp0/M01_AXI] [get_bd_intf_pins fmc_hdmi_input/S_AXI_LITE]
  connect_bd_intf_net -intf_net axi_interconnect_gp0_M02_AXI [get_bd_intf_pins axi_interconnect_gp0/M02_AXI] [get_bd_intf_pins processing/S_AXI_LITE]
  connect_bd_intf_net -intf_net axi_interconnect_gp0_M03_AXI [get_bd_intf_pins axi_interconnect_gp0/M03_AXI] [get_bd_intf_pins axi_perf_mon_1/S_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_gp0_M04_AXI [get_bd_intf_pins axi_interconnect_gp0/M04_AXI] [get_bd_intf_pins fmc_hdmi_input/TPG_CTRL]
  connect_bd_intf_net -intf_net axi_interconnect_gp0_M05_AXI [get_bd_intf_pins axi_interconnect_gp0/M05_AXI] [get_bd_intf_pins hdmi_output/LOGICVC_CTRL]
  connect_bd_intf_net -intf_net axi_interconnect_gp0_M06_AXI [get_bd_intf_pins axi_interconnect_gp0/M06_AXI] [get_bd_intf_pins processing/S_AXI_CONTROL_BUS]
  connect_bd_intf_net -intf_net axi_interconnect_gp0_M07_AXI [get_bd_intf_pins axi_interconnect_gp0/M07_AXI] [get_bd_intf_pins logiclk_1/s_axi]
  connect_bd_intf_net -intf_net axi_interconnect_hp0_M00_AXI [get_bd_intf_pins axi_interconnect_hp0/M00_AXI] [get_bd_intf_pins processing_system7_1/S_AXI_HP0]
connect_bd_intf_net -intf_net axi_interconnect_hp0_M00_AXI [get_bd_intf_pins axi_interconnect_hp0/M00_AXI] [get_bd_intf_pins axi_perf_mon_1/SLOT_0_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_hp2_M00_AXI [get_bd_intf_pins axi_interconnect_hp2/M00_AXI] [get_bd_intf_pins processing_system7_1/S_AXI_HP2]
connect_bd_intf_net -intf_net axi_interconnect_hp2_M00_AXI [get_bd_intf_pins axi_interconnect_hp2/M00_AXI] [get_bd_intf_pins axi_perf_mon_1/SLOT_2_AXI]
  connect_bd_intf_net -intf_net axi_vdma_1_M_AXI_S2MM [get_bd_intf_pins axi_interconnect_hp0/S00_AXI] [get_bd_intf_pins fmc_hdmi_input/M_AXI_S2MM]
  connect_bd_intf_net -intf_net axi_vdma_2_M_AXI_MM2S [get_bd_intf_pins axi_interconnect_hp2/S00_AXI] [get_bd_intf_pins processing/M_AXI_MM2S]
  connect_bd_intf_net -intf_net axi_vdma_2_M_AXI_S2MM [get_bd_intf_pins axi_interconnect_hp2/S01_AXI] [get_bd_intf_pins processing/M_AXI_S2MM]
  connect_bd_intf_net -intf_net logicvc_1_m_axi [get_bd_intf_pins axi_interconnect_hp0/S01_AXI] [get_bd_intf_pins hdmi_output/m_axi]
  connect_bd_intf_net -intf_net logicvc_1_vid_io [get_bd_intf_ports hdmio] [get_bd_intf_pins hdmi_output/vid_io]
  connect_bd_intf_net -intf_net processing_system7_1_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins processing_system7_1/DDR]
  connect_bd_intf_net -intf_net processing_system7_1_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins processing_system7_1/FIXED_IO]
  connect_bd_intf_net -intf_net processing_system7_1_IIC_0 [get_bd_intf_ports IIC_0] [get_bd_intf_pins processing_system7_1/IIC_0]
  connect_bd_intf_net -intf_net processing_system7_1_IIC_1 [get_bd_intf_ports fmc_imageon_iic] [get_bd_intf_pins processing_system7_1/IIC_1]
  connect_bd_intf_net -intf_net processing_system7_1_M_AXI_GP0 [get_bd_intf_pins axi_interconnect_gp0/S00_AXI] [get_bd_intf_pins processing_system7_1/M_AXI_GP0]

  # Create port connections
  connect_bd_net -net axi_perf_mon_1_interrupt [get_bd_pins axi_perf_mon_1/interrupt] [get_bd_pins xlconcat_1/In6]
  connect_bd_net -net axi_vdma_1_s2mm_introut [get_bd_pins fmc_hdmi_input/s2mm_introut] [get_bd_pins xlconcat_1/In4]
  connect_bd_net -net clk_in_2_1 [get_bd_ports fmc_imageon_hdmii_clk] [get_bd_pins fmc_hdmi_input/video_clk_2]
  connect_bd_net -net clk_wiz_0_locked [get_bd_pins clk_wiz_1/locked] [get_bd_pins proc_sys_reset_1/dcm_locked]
  connect_bd_net -net clk_wiz_1_clk_out1 [get_bd_pins axi_interconnect_gp0/ACLK] [get_bd_pins axi_interconnect_gp0/M00_ACLK] [get_bd_pins axi_interconnect_gp0/M01_ACLK] [get_bd_pins axi_interconnect_gp0/M02_ACLK] [get_bd_pins axi_interconnect_gp0/M03_ACLK] [get_bd_pins axi_interconnect_gp0/M04_ACLK] [get_bd_pins axi_interconnect_gp0/M05_ACLK] [get_bd_pins axi_interconnect_gp0/M07_ACLK] [get_bd_pins axi_interconnect_gp0/S00_ACLK] [get_bd_pins axi_perf_mon_1/s_axi_aclk] [get_bd_pins clk_wiz_1/clk_out1] [get_bd_pins fmc_hdmi_input/clk_75mhz] [get_bd_pins hdmi_output/clk_75mhz] [get_bd_pins logiclk_1/S_AXI_ACLK] [get_bd_pins proc_sys_reset_1/slowest_sync_clk] [get_bd_pins processing/s_axi_lite_aclk] [get_bd_pins processing_system7_1/M_AXI_GP0_ACLK]
  connect_bd_net -net clk_wiz_1_clk_out2 [get_bd_pins axi_interconnect_gp0/M06_ACLK] [get_bd_pins axi_interconnect_hp0/ACLK] [get_bd_pins axi_interconnect_hp0/M00_ACLK] [get_bd_pins axi_interconnect_hp0/S00_ACLK] [get_bd_pins axi_interconnect_hp0/S01_ACLK] [get_bd_pins axi_interconnect_hp2/ACLK] [get_bd_pins axi_interconnect_hp2/M00_ACLK] [get_bd_pins axi_interconnect_hp2/S00_ACLK] [get_bd_pins axi_interconnect_hp2/S01_ACLK] [get_bd_pins axi_perf_mon_1/core_aclk] [get_bd_pins axi_perf_mon_1/slot_0_axi_aclk] [get_bd_pins axi_perf_mon_1/slot_1_axi_aclk] [get_bd_pins axi_perf_mon_1/slot_2_axi_aclk] [get_bd_pins clk_wiz_1/clk_out2] [get_bd_pins fmc_hdmi_input/m_axi_s2mm_aclk] [get_bd_pins hdmi_output/clk_150mhz] [get_bd_pins processing/aclk] [get_bd_pins processing_system7_1/S_AXI_HP0_ACLK] [get_bd_pins processing_system7_1/S_AXI_HP2_ACLK]
  connect_bd_net -net emio_gpio_Dout [get_bd_pins emio_gpio/video_sel] [get_bd_pins fmc_hdmi_input/sel]
  connect_bd_net -net fmc_hdmi_input_s2mm_fsync_out [get_bd_pins fmc_hdmi_input/s2mm_fsync_out] [get_bd_pins processing/mm2s_fsync]
  connect_bd_net -net hdmio_init_b_1 [get_bd_ports hdmio_int_b] [get_bd_pins xlconcat_1/In0]
  connect_bd_net -net logiclk_0_clk0_drp [get_bd_pins fmc_hdmi_input/video_clk_1] [get_bd_pins hdmi_output/video_clk] [get_bd_pins logiclk_1/clk0_drp]
  connect_bd_net -net logicvc_1_interrupt [get_bd_pins hdmi_output/logicvc_int] [get_bd_pins xlconcat_1/In5]
  connect_bd_net -net logicvc_1_pix_clk_o [get_bd_ports hdmio_clk] [get_bd_pins hdmi_output/hdmio_clk]
  connect_bd_net -net proc_sys_reset_1_bus_struct_reset [get_bd_pins hdmi_output/logicvc_rst] [get_bd_pins proc_sys_reset_1/bus_struct_reset]
  connect_bd_net -net proc_sys_reset_1_interconnect_aresetn [get_bd_pins axi_interconnect_gp0/ARESETN] [get_bd_pins axi_interconnect_gp0/M00_ARESETN] [get_bd_pins axi_interconnect_gp0/M01_ARESETN] [get_bd_pins axi_interconnect_gp0/M02_ARESETN] [get_bd_pins axi_interconnect_gp0/M03_ARESETN] [get_bd_pins axi_interconnect_gp0/M04_ARESETN] [get_bd_pins axi_interconnect_gp0/M05_ARESETN] [get_bd_pins axi_interconnect_gp0/M06_ARESETN] [get_bd_pins axi_interconnect_gp0/M07_ARESETN] [get_bd_pins axi_interconnect_gp0/S00_ARESETN] [get_bd_pins axi_interconnect_hp0/ARESETN] [get_bd_pins axi_interconnect_hp0/M00_ARESETN] [get_bd_pins axi_interconnect_hp0/S00_ARESETN] [get_bd_pins axi_interconnect_hp0/S01_ARESETN] [get_bd_pins axi_interconnect_hp2/ARESETN] [get_bd_pins axi_interconnect_hp2/M00_ARESETN] [get_bd_pins axi_interconnect_hp2/S00_ARESETN] [get_bd_pins axi_interconnect_hp2/S01_ARESETN] [get_bd_pins axi_perf_mon_1/core_aresetn] [get_bd_pins axi_perf_mon_1/s_axi_aresetn] [get_bd_pins axi_perf_mon_1/slot_0_axi_aresetn] [get_bd_pins axi_perf_mon_1/slot_1_axi_aresetn] [get_bd_pins axi_perf_mon_1/slot_2_axi_aresetn] [get_bd_pins fmc_hdmi_input/axi_resetn] [get_bd_pins hdmi_output/aresetn] [get_bd_pins logiclk_1/S_AXI_ARESETN] [get_bd_pins proc_sys_reset_1/interconnect_aresetn] [get_bd_pins processing/aresetn]
  connect_bd_net -net processing_interrupt [get_bd_pins processing/interrupt] [get_bd_pins xlconcat_1/In1]
  connect_bd_net -net processing_mm2s_introut [get_bd_pins processing/mm2s_introut] [get_bd_pins xlconcat_1/In2]
  connect_bd_net -net processing_s2mm_introut [get_bd_pins processing/s2mm_introut] [get_bd_pins xlconcat_1/In3]
  connect_bd_net -net processing_system7_1_FCLK_CLK0 [get_bd_pins clk_wiz_1/clk_in1] [get_bd_pins logiclk_1/osc_clk] [get_bd_pins processing_system7_1/FCLK_CLK0]
  connect_bd_net -net processing_system7_1_FCLK_RESET0_N [get_bd_pins logiclk_1/rst] [get_bd_pins proc_sys_reset_1/ext_reset_in] [get_bd_pins processing_system7_1/FCLK_RESET0_N]
  connect_bd_net -net processing_system7_1_GPIO_O [get_bd_pins emio_gpio/Din] [get_bd_pins processing_system7_1/GPIO_O]
  connect_bd_net -net tpg_rst1_dout [get_bd_ports fmc_imageon_iic_rst_b] [get_bd_pins emio_gpio/iic_rst_b]
  connect_bd_net -net xlconcat_1_dout [get_bd_pins processing_system7_1/IRQ_F2P] [get_bd_pins xlconcat_1/dout]

  # Create address segments
  create_bd_addr_seg -range 0x10000 -offset 0x400F0000 [get_bd_addr_spaces processing_system7_1/Data] [get_bd_addr_segs axi_perf_mon_1/S_AXI/Reg] SEG_axi_perf_mon_1_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x40090000 [get_bd_addr_spaces processing_system7_1/Data] [get_bd_addr_segs fmc_hdmi_input/axi_vdma_1/S_AXI_LITE/Reg] SEG_axi_vdma_1_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x400B0000 [get_bd_addr_spaces processing_system7_1/Data] [get_bd_addr_segs processing/axi_vdma_2/S_AXI_LITE/Reg] SEG_axi_vdma_2_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x400D0000 [get_bd_addr_spaces processing_system7_1/Data] [get_bd_addr_segs processing/image_filter_1/s_axi_CONTROL_BUS/Reg] SEG_image_filter_1_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x40020000 [get_bd_addr_spaces processing_system7_1/Data] [get_bd_addr_segs logiclk_1/s_axi/reg0] SEG_logiclk_0_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x40030000 [get_bd_addr_spaces processing_system7_1/Data] [get_bd_addr_segs hdmi_output/logicvc_1/s_axi/reg0] SEG_logicvc_1_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x40070000 [get_bd_addr_spaces processing_system7_1/Data] [get_bd_addr_segs fmc_hdmi_input/v_tc_1/ctrl/Reg] SEG_v_tc_1_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x40080000 [get_bd_addr_spaces processing_system7_1/Data] [get_bd_addr_segs fmc_hdmi_input/v_tpg_1/ctrl/Reg] SEG_v_tpg_1_Reg
  create_bd_addr_seg -range 0x20000000 -offset 0x0 [get_bd_addr_spaces fmc_hdmi_input/axi_vdma_1/Data_S2MM] [get_bd_addr_segs processing_system7_1/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_1_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x20000000 -offset 0x0 [get_bd_addr_spaces hdmi_output/logicvc_1/videoData] [get_bd_addr_segs processing_system7_1/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_1_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x20000000 -offset 0x0 [get_bd_addr_spaces processing/axi_vdma_2/Data_MM2S] [get_bd_addr_segs processing_system7_1/S_AXI_HP2/HP2_DDR_LOWOCM] SEG_processing_system7_1_HP2_DDR_LOWOCM
  create_bd_addr_seg -range 0x20000000 -offset 0x0 [get_bd_addr_spaces processing/axi_vdma_2/Data_S2MM] [get_bd_addr_segs processing_system7_1/S_AXI_HP2/HP2_DDR_LOWOCM] SEG_processing_system7_1_HP2_DDR_LOWOCM
  

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""



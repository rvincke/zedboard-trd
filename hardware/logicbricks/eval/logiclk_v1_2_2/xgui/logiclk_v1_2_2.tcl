#Definitional proc to organize widgets for parameters.

proc init_gui { IPINST } {

    set Component_Name [ ipgui::add_param $IPINST -parent $IPINST -name Component_Name ]
    set canvas_spec [ipgui::get_canvasspec -of $IPINST]
        set_property ip_logo "xgui/logicBricks.png" $canvas_spec

    # Formerly designated as tabgroup1
    set C_IP_MAJOR_REVISION [ipgui::add_param $IPINST -parent $IPINST -name C_IP_MAJOR_REVISION]
    set C_IP_MINOR_REVISION [ipgui::add_param $IPINST -parent $IPINST -name C_IP_MINOR_REVISION]
    set C_IP_PATCH_LEVEL [ipgui::add_param $IPINST -parent $IPINST -name C_IP_PATCH_LEVEL]

    set Page0 [ ipgui::add_page $IPINST  -name "IP core license and version" -layout vertical]
        set tabgroup0 [ipgui::add_group $IPINST -parent $Page0 -name {IP License} -layout vertical]
            set C_IP_LICENSE_TYPE [ipgui::add_param $IPINST -parent $tabgroup0 -name C_IP_LICENSE_TYPE]

    set Page1 [ ipgui::add_page $IPINST  -name "Registers interface" -layout vertical]
        set tabgroup2 [ipgui::add_group $IPINST -parent $Page1 -name {General} -layout vertical]
            set C_REGS_INTERFACE [ipgui::add_param $IPINST -parent $tabgroup2 -name C_REGS_INTERFACE]
        set tabgroup3 [ipgui::add_group $IPINST -parent $Page1 -name {Registers address space} -layout vertical]
            set C_REGS_HIGHADDR [ipgui::add_param $IPINST -parent $tabgroup3 -name C_REGS_HIGHADDR]
            set C_REGS_BASEADDR [ipgui::add_param $IPINST -parent $tabgroup3 -name C_REGS_BASEADDR]
        set tabgroup4 [ipgui::add_group $IPINST -parent $Page1 -name {AXI4_Lite Interface} -layout vertical]
            set C_S_AXI_DATA_WIDTH [ipgui::add_param $IPINST -parent $tabgroup4 -name C_S_AXI_DATA_WIDTH]
                set_property tooltip {AXI4-Lite interface data bus width.} $C_S_AXI_DATA_WIDTH
            set C_S_AXI_ADDR_WIDTH [ipgui::add_param $IPINST -parent $tabgroup4 -name C_S_AXI_ADDR_WIDTH]
                set_property tooltip {AXI4-Lite interface address bus width.} $C_S_AXI_ADDR_WIDTH

    set Page2 [ ipgui::add_page $IPINST  -name "User" -layout vertical]
        set tabgroup5 [ipgui::add_group $IPINST -parent $Page2 -name {Clock General Settings} -layout vertical]
            set C_OSC_CLK_FREQ_HZ [ipgui::add_param $IPINST -parent $tabgroup5 -name C_OSC_CLK_FREQ_HZ]
                set_property tooltip {Oscillator frequency in Hz.} $C_OSC_CLK_FREQ_HZ
            set C_RST_POLARITY [ipgui::add_param $IPINST -parent $tabgroup5 -widget comboBox -name C_RST_POLARITY]
                set_property tooltip {Input reset polarity.} $C_RST_POLARITY

    set Page3 [ ipgui::add_page $IPINST  -name "PLL 1" -layout vertical]
        set tabgroup6 [ipgui::add_group $IPINST -parent $Page3 -name {PLL 1 Settings} -layout vertical]
            set C_CLK_MULTIPLY [ipgui::add_param $IPINST -parent $tabgroup6 -name C_CLK_MULTIPLY]
                set_property tooltip {Specifies the multiplication value for all CLK clock outputs.} $C_CLK_MULTIPLY
            set C_CLK0_DIVIDE [ipgui::add_param $IPINST -parent $tabgroup6 -name C_CLK0_DIVIDE]
                set_property tooltip {Specifies the divide value for clock output 0.} $C_CLK0_DIVIDE
            set C_CLK1_DIVIDE [ipgui::add_param $IPINST -parent $tabgroup6 -name C_CLK1_DIVIDE]
                set_property tooltip {Specifies the divide value for clock output 1.} $C_CLK1_DIVIDE
            set C_CLK2_DIVIDE [ipgui::add_param $IPINST -parent $tabgroup6 -name C_CLK2_DIVIDE]
                set_property tooltip {Specifies the divide value for clock output 2.} $C_CLK2_DIVIDE
            set C_CLK3_DIVIDE [ipgui::add_param $IPINST -parent $tabgroup6 -name C_CLK3_DIVIDE]
                set_property tooltip {Specifies the divide value for clock output 3.} $C_CLK3_DIVIDE
            set C_CLK4_DIVIDE [ipgui::add_param $IPINST -parent $tabgroup6 -name C_CLK4_DIVIDE]
                set_property tooltip {Specifies the divide value for clock output 4.} $C_CLK4_DIVIDE
            set C_CLK5_DIVIDE [ipgui::add_param $IPINST -parent $tabgroup6 -name C_CLK5_DIVIDE]
                set_property tooltip {Specifies the divide value for clock output 5.} $C_CLK5_DIVIDE

    set Page4 [ ipgui::add_page $IPINST  -name "DRP PLL" -layout vertical]			
        set tabgroup7 [ipgui::add_group $IPINST -parent $Page4 -name {DRP General} -layout vertical]
            set C_USE_CLK_DRP [ipgui::add_param $IPINST -parent $tabgroup7 -widget comboBox -name C_USE_CLK_DRP]
                set_property tooltip {When set, enables the DRP module.} $C_USE_CLK_DRP
            set C_USE_VLINK_CLK [ipgui::add_param $IPINST -parent $tabgroup7 -widget comboBox -name C_USE_VLINK_CLK]
                set_property tooltip {When set, clk0_drp is output from BUFIO for 7 series FPGAs or BUFPLL for Spartan 6 FPGAs and can be used for logiVLINK.} $C_USE_VLINK_CLK
            set C_DRP_BANDWIDTH [ipgui::add_param $IPINST -parent $tabgroup7 -name C_DRP_BANDWIDTH]
                set_property tooltip {Specifies the PLL programming algorithm affecting the jitter, phase margin and other characteristics of the PLL.} $C_DRP_BANDWIDTH
            set C_DRP_DIVCLK_DIVIDE [ipgui::add_param $IPINST -parent $tabgroup7 -name C_DRP_DIVCLK_DIVIDE]
                set_property tooltip {Specifies the divide ratio for all clock outputs with respect to the input clock.} $C_DRP_DIVCLK_DIVIDE
            set C_DRP_CLKFBOUT_MULT [ipgui::add_param $IPINST -parent $tabgroup7 -name C_DRP_CLKFBOUT_MULT]
                set_property tooltip {Specifies the multiplication value for all DRP clock outputs.} $C_DRP_CLKFBOUT_MULT
            set C_DRP_CLKFBOUT_PHASE [ipgui::add_param $IPINST -parent $tabgroup7 -name C_DRP_CLKFBOUT_PHASE]
                set_property tooltip {Specifies the phase offset in degrees of the clock feedback output.} $C_DRP_CLKFBOUT_PHASE
        set tabgroup8 [ipgui::add_group $IPINST -parent $Page4 -name {DRP CLOCKOUT0} -layout vertical]
            set C_DRP_CLKOUT0_DUTY [ipgui::add_param $IPINST -parent $tabgroup8 -name C_DRP_CLKOUT0_DUTY]
                set_property tooltip {Specifies the Duty Cycle for DRP CLKOUT0 in percentage.} $C_DRP_CLKOUT0_DUTY
            set C_DRP_CLKOUT0_PHASE [ipgui::add_param $IPINST -parent $tabgroup8 -name C_DRP_CLKOUT0_PHASE]
                set_property tooltip {Specifies the phase offset in degrees of the DRP CLKOUT0.} $C_DRP_CLKOUT0_PHASE
            set C_DRP_CLKOUT0_DIVIDE [ipgui::add_param $IPINST -parent $tabgroup8 -name C_DRP_CLKOUT0_DIVIDE]
                set_property tooltip {Specifies the amount to divide the DRP CLKOUT0 if a different frequency is desired.} $C_DRP_CLKOUT0_DIVIDE
        set tabgroup9 [ipgui::add_group $IPINST -parent $Page4 -name {DRP CLOCKOUT1} -layout vertical]
            set C_DRP_CLKOUT1_DUTY [ipgui::add_param $IPINST -parent $tabgroup9 -name C_DRP_CLKOUT1_DUTY]
                set_property tooltip {Specifies the Duty Cycle for DRP CLKOUT1 in percentage.} $C_DRP_CLKOUT1_DUTY
            set C_DRP_CLKOUT1_PHASE [ipgui::add_param $IPINST -parent $tabgroup9 -name C_DRP_CLKOUT1_PHASE]
                set_property tooltip {Specifies the phase offset in degrees of the DRP CLKOUT1.} $C_DRP_CLKOUT1_PHASE
            set C_DRP_CLKOUT1_DIVIDE [ipgui::add_param $IPINST -parent $tabgroup9 -name C_DRP_CLKOUT1_DIVIDE]
                set_property tooltip {Specifies the amount to divide the DRP CLKOUT1 if a different frequency is desired.} $C_DRP_CLKOUT1_DIVIDE
        set tabgroup10 [ipgui::add_group $IPINST -parent $Page4 -name {DRP CLOCKOUT2} -layout vertical]
            set C_DRP_CLKOUT2_DUTY [ipgui::add_param $IPINST -parent $tabgroup10 -name C_DRP_CLKOUT2_DUTY]
                set_property tooltip {Specifies the Duty Cycle for DRP CLKOUT2 in percentage.} $C_DRP_CLKOUT2_DUTY
            set C_DRP_CLKOUT2_PHASE [ipgui::add_param $IPINST -parent $tabgroup10 -name C_DRP_CLKOUT2_PHASE]
                set_property tooltip {Specifies the phase offset in degrees of the DRP CLKOUT2.} $C_DRP_CLKOUT2_PHASE
            set C_DRP_CLKOUT2_DIVIDE [ipgui::add_param $IPINST -parent $tabgroup10 -name C_DRP_CLKOUT2_DIVIDE]
                set_property tooltip {Specifies the amount to divide the DRP CLKOUT2 if a different frequency is desired.} $C_DRP_CLKOUT2_DIVIDE
        set tabgroup11 [ipgui::add_group $IPINST -parent $Page4 -name {DRP CLOCKOUT3} -layout vertical]
            set C_DRP_CLKOUT3_DUTY [ipgui::add_param $IPINST -parent $tabgroup11 -name C_DRP_CLKOUT3_DUTY]
                set_property tooltip {Specifies the Duty Cycle for DRP CLKOUT3 in percentage.} $C_DRP_CLKOUT3_DUTY
            set C_DRP_CLKOUT3_PHASE [ipgui::add_param $IPINST -parent $tabgroup11 -name C_DRP_CLKOUT3_PHASE]
                set_property tooltip {Specifies the phase offset in degrees of the DRP CLKOUT3.} $C_DRP_CLKOUT3_PHASE
            set C_DRP_CLKOUT3_DIVIDE [ipgui::add_param $IPINST -parent $tabgroup11 -name C_DRP_CLKOUT3_DIVIDE]
                set_property tooltip {Specifies the amount to divide the DRP CLKOUT3 if a different frequency is desired.} $C_DRP_CLKOUT3_DIVIDE
        set tabgroup12 [ipgui::add_group $IPINST -parent $Page4 -name {DRP CLOCKOUT4} -layout vertical]
            set C_DRP_CLKOUT4_DUTY [ipgui::add_param $IPINST -parent $tabgroup12 -name C_DRP_CLKOUT4_DUTY]
                set_property tooltip {Specifies the Duty Cycle for DRP CLKOUT4 in percentage.} $C_DRP_CLKOUT4_DUTY
            set C_DRP_CLKOUT4_PHASE [ipgui::add_param $IPINST -parent $tabgroup12 -name C_DRP_CLKOUT4_PHASE]
                set_property tooltip {Specifies the phase offset in degrees of the DRP CLKOUT4.} $C_DRP_CLKOUT4_PHASE
            set C_DRP_CLKOUT4_DIVIDE [ipgui::add_param $IPINST -parent $tabgroup12 -name C_DRP_CLKOUT4_DIVIDE]
                set_property tooltip {Specifies the amount to divide the DRP CLKOUT4 if a different frequency is desired.} $C_DRP_CLKOUT4_DIVIDE
        set tabgroup13 [ipgui::add_group $IPINST -parent $Page4 -name {DRP CLOCKOUT5} -layout vertical]
            set C_DRP_CLKOUT5_DUTY [ipgui::add_param $IPINST -parent $tabgroup13 -name C_DRP_CLKOUT5_DUTY]
                set_property tooltip {Specifies the Duty Cycle for DRP CLKOUT5 in percentage.} $C_DRP_CLKOUT5_DUTY
            set C_DRP_CLKOUT5_PHASE [ipgui::add_param $IPINST -parent $tabgroup13 -name C_DRP_CLKOUT5_PHASE]
                set_property tooltip {Specifies the phase offset in degrees of the DRP CLKOUT5.} $C_DRP_CLKOUT5_PHASE
            set C_DRP_CLKOUT5_DIVIDE [ipgui::add_param $IPINST -parent $tabgroup13 -name C_DRP_CLKOUT5_DIVIDE]
                set_property tooltip {Specifies the amount to divide the DRP CLKOUT5 if a different frequency is desired.} $C_DRP_CLKOUT5_DIVIDE

    # Hidden parameters
    set_property visible false $C_IP_MAJOR_REVISION
    set_property visible false $C_IP_MINOR_REVISION
    set_property visible false $C_IP_PATCH_LEVEL
}

proc update_PARAM_VALUE.C_IP_LICENSE_TYPE { PARAM_VALUE.C_IP_LICENSE_TYPE } {
	# Procedure called to update C_IP_LICENSE_TYPE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_IP_LICENSE_TYPE { PARAM_VALUE.C_IP_LICENSE_TYPE } {
	# Procedure called to validate C_IP_LICENSE_TYPE
	return true
}

proc update_PARAM_VALUE.C_IP_MAJOR_REVISION { PARAM_VALUE.C_IP_MAJOR_REVISION } {
	# Procedure called to update C_IP_MAJOR_REVISION when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_IP_MAJOR_REVISION { PARAM_VALUE.C_IP_MAJOR_REVISION } {
	# Procedure called to validate C_IP_MAJOR_REVISION
	return true
}

proc update_PARAM_VALUE.C_IP_MINOR_REVISION { PARAM_VALUE.C_IP_MINOR_REVISION } {
	# Procedure called to update C_IP_MINOR_REVISION when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_IP_MINOR_REVISION { PARAM_VALUE.C_IP_MINOR_REVISION } {
	# Procedure called to validate C_IP_MINOR_REVISION
	return true
}

proc update_PARAM_VALUE.C_IP_PATCH_LEVEL { PARAM_VALUE.C_IP_PATCH_LEVEL } {
	# Procedure called to update C_IP_PATCH_LEVEL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_IP_PATCH_LEVEL { PARAM_VALUE.C_IP_PATCH_LEVEL } {
	# Procedure called to validate C_IP_PATCH_LEVEL
	return true
}

proc update_PARAM_VALUE.C_DRP_CLKOUT2_DUTY { PARAM_VALUE.C_DRP_CLKOUT2_DUTY } {
	# Procedure called to update C_DRP_CLKOUT2_DUTY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DRP_CLKOUT2_DUTY { PARAM_VALUE.C_DRP_CLKOUT2_DUTY } {
	# Procedure called to validate C_DRP_CLKOUT2_DUTY
	return true
}

proc update_PARAM_VALUE.C_DRP_CLKOUT2_PHASE { PARAM_VALUE.C_DRP_CLKOUT2_PHASE } {
	# Procedure called to update C_DRP_CLKOUT2_PHASE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DRP_CLKOUT2_PHASE { PARAM_VALUE.C_DRP_CLKOUT2_PHASE } {
	# Procedure called to validate C_DRP_CLKOUT2_PHASE
	return true
}

proc update_PARAM_VALUE.C_DRP_CLKOUT2_DIVIDE { PARAM_VALUE.C_DRP_CLKOUT2_DIVIDE } {
	# Procedure called to update C_DRP_CLKOUT2_DIVIDE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DRP_CLKOUT2_DIVIDE { PARAM_VALUE.C_DRP_CLKOUT2_DIVIDE } {
	# Procedure called to validate C_DRP_CLKOUT2_DIVIDE
	return true
}

proc update_PARAM_VALUE.C_DRP_CLKOUT3_DUTY { PARAM_VALUE.C_DRP_CLKOUT3_DUTY } {
	# Procedure called to update C_DRP_CLKOUT3_DUTY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DRP_CLKOUT3_DUTY { PARAM_VALUE.C_DRP_CLKOUT3_DUTY } {
	# Procedure called to validate C_DRP_CLKOUT3_DUTY
	return true
}

proc update_PARAM_VALUE.C_DRP_CLKOUT3_PHASE { PARAM_VALUE.C_DRP_CLKOUT3_PHASE } {
	# Procedure called to update C_DRP_CLKOUT3_PHASE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DRP_CLKOUT3_PHASE { PARAM_VALUE.C_DRP_CLKOUT3_PHASE } {
	# Procedure called to validate C_DRP_CLKOUT3_PHASE
	return true
}

proc update_PARAM_VALUE.C_DRP_CLKOUT3_DIVIDE { PARAM_VALUE.C_DRP_CLKOUT3_DIVIDE } {
	# Procedure called to update C_DRP_CLKOUT3_DIVIDE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DRP_CLKOUT3_DIVIDE { PARAM_VALUE.C_DRP_CLKOUT3_DIVIDE } {
	# Procedure called to validate C_DRP_CLKOUT3_DIVIDE
	return true
}

proc update_PARAM_VALUE.C_DRP_CLKOUT4_DUTY { PARAM_VALUE.C_DRP_CLKOUT4_DUTY } {
	# Procedure called to update C_DRP_CLKOUT4_DUTY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DRP_CLKOUT4_DUTY { PARAM_VALUE.C_DRP_CLKOUT4_DUTY } {
	# Procedure called to validate C_DRP_CLKOUT4_DUTY
	return true
}

proc update_PARAM_VALUE.C_DRP_CLKOUT4_PHASE { PARAM_VALUE.C_DRP_CLKOUT4_PHASE } {
	# Procedure called to update C_DRP_CLKOUT4_PHASE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DRP_CLKOUT4_PHASE { PARAM_VALUE.C_DRP_CLKOUT4_PHASE } {
	# Procedure called to validate C_DRP_CLKOUT4_PHASE
	return true
}

proc update_PARAM_VALUE.C_DRP_CLKOUT4_DIVIDE { PARAM_VALUE.C_DRP_CLKOUT4_DIVIDE } {
	# Procedure called to update C_DRP_CLKOUT4_DIVIDE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DRP_CLKOUT4_DIVIDE { PARAM_VALUE.C_DRP_CLKOUT4_DIVIDE } {
	# Procedure called to validate C_DRP_CLKOUT4_DIVIDE
	return true
}

proc update_PARAM_VALUE.C_DRP_CLKOUT5_DUTY { PARAM_VALUE.C_DRP_CLKOUT5_DUTY } {
	# Procedure called to update C_DRP_CLKOUT5_DUTY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DRP_CLKOUT5_DUTY { PARAM_VALUE.C_DRP_CLKOUT5_DUTY } {
	# Procedure called to validate C_DRP_CLKOUT5_DUTY
	return true
}

proc update_PARAM_VALUE.C_DRP_CLKOUT5_PHASE { PARAM_VALUE.C_DRP_CLKOUT5_PHASE } {
	# Procedure called to update C_DRP_CLKOUT5_PHASE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DRP_CLKOUT5_PHASE { PARAM_VALUE.C_DRP_CLKOUT5_PHASE } {
	# Procedure called to validate C_DRP_CLKOUT5_PHASE
	return true
}

proc update_PARAM_VALUE.C_DRP_CLKOUT5_DIVIDE { PARAM_VALUE.C_DRP_CLKOUT5_DIVIDE } {
	# Procedure called to update C_DRP_CLKOUT5_DIVIDE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DRP_CLKOUT5_DIVIDE { PARAM_VALUE.C_DRP_CLKOUT5_DIVIDE } {
	# Procedure called to validate C_DRP_CLKOUT5_DIVIDE
	return true
}

proc update_PARAM_VALUE.C_REGS_INTERFACE { PARAM_VALUE.C_REGS_INTERFACE } {
	# Procedure called to update C_REGS_INTERFACE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_REGS_INTERFACE { PARAM_VALUE.C_REGS_INTERFACE } {
	# Procedure called to validate C_REGS_INTERFACE
	return true
}

proc update_PARAM_VALUE.C_REGS_HIGHADDR { PARAM_VALUE.C_REGS_HIGHADDR } {
	# Procedure called to update C_REGS_HIGHADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_REGS_HIGHADDR { PARAM_VALUE.C_REGS_HIGHADDR } {
	# Procedure called to validate C_REGS_HIGHADDR
	return true
}

proc update_PARAM_VALUE.C_REGS_BASEADDR { PARAM_VALUE.C_REGS_BASEADDR } {
	# Procedure called to update C_REGS_BASEADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_REGS_BASEADDR { PARAM_VALUE.C_REGS_BASEADDR } {
	# Procedure called to validate C_REGS_BASEADDR
	return true
}

proc update_PARAM_VALUE.C_S_AXI_DATA_WIDTH { PARAM_VALUE.C_S_AXI_DATA_WIDTH } {
	# Procedure called to update C_S_AXI_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_DATA_WIDTH { PARAM_VALUE.C_S_AXI_DATA_WIDTH } {
	# Procedure called to validate C_S_AXI_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S_AXI_ADDR_WIDTH { PARAM_VALUE.C_S_AXI_ADDR_WIDTH } {
	# Procedure called to update C_S_AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_ADDR_WIDTH { PARAM_VALUE.C_S_AXI_ADDR_WIDTH } {
	# Procedure called to validate C_S_AXI_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_CLK5_DIVIDE { PARAM_VALUE.C_CLK5_DIVIDE } {
	# Procedure called to update C_CLK5_DIVIDE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_CLK5_DIVIDE { PARAM_VALUE.C_CLK5_DIVIDE } {
	# Procedure called to validate C_CLK5_DIVIDE
	return true
}

proc update_PARAM_VALUE.C_CLK4_DIVIDE { PARAM_VALUE.C_CLK4_DIVIDE } {
	# Procedure called to update C_CLK4_DIVIDE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_CLK4_DIVIDE { PARAM_VALUE.C_CLK4_DIVIDE } {
	# Procedure called to validate C_CLK4_DIVIDE
	return true
}

proc update_PARAM_VALUE.C_CLK3_DIVIDE { PARAM_VALUE.C_CLK3_DIVIDE } {
	# Procedure called to update C_CLK3_DIVIDE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_CLK3_DIVIDE { PARAM_VALUE.C_CLK3_DIVIDE } {
	# Procedure called to validate C_CLK3_DIVIDE
	return true
}

proc update_PARAM_VALUE.C_CLK2_DIVIDE { PARAM_VALUE.C_CLK2_DIVIDE } {
	# Procedure called to update C_CLK2_DIVIDE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_CLK2_DIVIDE { PARAM_VALUE.C_CLK2_DIVIDE } {
	# Procedure called to validate C_CLK2_DIVIDE
	return true
}

proc update_PARAM_VALUE.C_CLK1_DIVIDE { PARAM_VALUE.C_CLK1_DIVIDE } {
	# Procedure called to update C_CLK1_DIVIDE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_CLK1_DIVIDE { PARAM_VALUE.C_CLK1_DIVIDE } {
	# Procedure called to validate C_CLK1_DIVIDE
	return true
}

proc update_PARAM_VALUE.C_CLK0_DIVIDE { PARAM_VALUE.C_CLK0_DIVIDE } {
	# Procedure called to update C_CLK0_DIVIDE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_CLK0_DIVIDE { PARAM_VALUE.C_CLK0_DIVIDE } {
	# Procedure called to validate C_CLK0_DIVIDE
	return true
}

proc update_PARAM_VALUE.C_CLK_MULTIPLY { PARAM_VALUE.C_CLK_MULTIPLY } {
	# Procedure called to update C_CLK_MULTIPLY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_CLK_MULTIPLY { PARAM_VALUE.C_CLK_MULTIPLY } {
	# Procedure called to validate C_CLK_MULTIPLY
	return true
}

proc update_PARAM_VALUE.C_OSC_CLK_FREQ_HZ { PARAM_VALUE.C_OSC_CLK_FREQ_HZ } {
	# Procedure called to update C_OSC_CLK_FREQ_HZ when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_OSC_CLK_FREQ_HZ { PARAM_VALUE.C_OSC_CLK_FREQ_HZ } {
	# Procedure called to validate C_OSC_CLK_FREQ_HZ
	return true
}

proc update_PARAM_VALUE.C_RST_POLARITY { PARAM_VALUE.C_RST_POLARITY } {
	# Procedure called to update C_RST_POLARITY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_RST_POLARITY { PARAM_VALUE.C_RST_POLARITY } {
	# Procedure called to validate C_RST_POLARITY
	return true
}

proc update_PARAM_VALUE.C_DRP_DIVCLK_DIVIDE { PARAM_VALUE.C_DRP_DIVCLK_DIVIDE } {
	# Procedure called to update C_DRP_DIVCLK_DIVIDE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DRP_DIVCLK_DIVIDE { PARAM_VALUE.C_DRP_DIVCLK_DIVIDE } {
	# Procedure called to validate C_DRP_DIVCLK_DIVIDE
	return true
}

proc update_PARAM_VALUE.C_DRP_CLKFBOUT_MULT { PARAM_VALUE.C_DRP_CLKFBOUT_MULT } {
	# Procedure called to update C_DRP_CLKFBOUT_MULT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DRP_CLKFBOUT_MULT { PARAM_VALUE.C_DRP_CLKFBOUT_MULT } {
	# Procedure called to validate C_DRP_CLKFBOUT_MULT
	return true
}

proc update_PARAM_VALUE.C_DRP_BANDWIDTH { PARAM_VALUE.C_DRP_BANDWIDTH } {
	# Procedure called to update C_DRP_BANDWIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DRP_BANDWIDTH { PARAM_VALUE.C_DRP_BANDWIDTH } {
	# Procedure called to validate C_DRP_BANDWIDTH
	return true
}

proc update_PARAM_VALUE.C_DRP_CLKFBOUT_PHASE { PARAM_VALUE.C_DRP_CLKFBOUT_PHASE } {
	# Procedure called to update C_DRP_CLKFBOUT_PHASE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DRP_CLKFBOUT_PHASE { PARAM_VALUE.C_DRP_CLKFBOUT_PHASE } {
	# Procedure called to validate C_DRP_CLKFBOUT_PHASE
	return true
}

proc update_PARAM_VALUE.C_USE_CLK_DRP { PARAM_VALUE.C_USE_CLK_DRP } {
	# Procedure called to update C_USE_CLK_DRP when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_USE_CLK_DRP { PARAM_VALUE.C_USE_CLK_DRP } {
	# Procedure called to validate C_USE_CLK_DRP
	return true
}

proc update_PARAM_VALUE.C_USE_VLINK_CLK { PARAM_VALUE.C_USE_VLINK_CLK } {
	# Procedure called to update C_USE_VLINK_CLK when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_USE_VLINK_CLK { PARAM_VALUE.C_USE_VLINK_CLK } {
	# Procedure called to validate C_USE_VLINK_CLK
	return true
}

proc update_PARAM_VALUE.C_DRP_CLKOUT0_DUTY { PARAM_VALUE.C_DRP_CLKOUT0_DUTY } {
	# Procedure called to update C_DRP_CLKOUT0_DUTY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DRP_CLKOUT0_DUTY { PARAM_VALUE.C_DRP_CLKOUT0_DUTY } {
	# Procedure called to validate C_DRP_CLKOUT0_DUTY
	return true
}

proc update_PARAM_VALUE.C_DRP_CLKOUT0_PHASE { PARAM_VALUE.C_DRP_CLKOUT0_PHASE } {
	# Procedure called to update C_DRP_CLKOUT0_PHASE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DRP_CLKOUT0_PHASE { PARAM_VALUE.C_DRP_CLKOUT0_PHASE } {
	# Procedure called to validate C_DRP_CLKOUT0_PHASE
	return true
}

proc update_PARAM_VALUE.C_DRP_CLKOUT0_DIVIDE { PARAM_VALUE.C_DRP_CLKOUT0_DIVIDE } {
	# Procedure called to update C_DRP_CLKOUT0_DIVIDE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DRP_CLKOUT0_DIVIDE { PARAM_VALUE.C_DRP_CLKOUT0_DIVIDE } {
	# Procedure called to validate C_DRP_CLKOUT0_DIVIDE
	return true
}

proc update_PARAM_VALUE.C_DRP_CLKOUT1_DUTY { PARAM_VALUE.C_DRP_CLKOUT1_DUTY } {
	# Procedure called to update C_DRP_CLKOUT1_DUTY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DRP_CLKOUT1_DUTY { PARAM_VALUE.C_DRP_CLKOUT1_DUTY } {
	# Procedure called to validate C_DRP_CLKOUT1_DUTY
	return true
}

proc update_PARAM_VALUE.C_DRP_CLKOUT1_PHASE { PARAM_VALUE.C_DRP_CLKOUT1_PHASE } {
	# Procedure called to update C_DRP_CLKOUT1_PHASE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DRP_CLKOUT1_PHASE { PARAM_VALUE.C_DRP_CLKOUT1_PHASE } {
	# Procedure called to validate C_DRP_CLKOUT1_PHASE
	return true
}

proc update_PARAM_VALUE.C_DRP_CLKOUT1_DIVIDE { PARAM_VALUE.C_DRP_CLKOUT1_DIVIDE } {
	# Procedure called to update C_DRP_CLKOUT1_DIVIDE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DRP_CLKOUT1_DIVIDE { PARAM_VALUE.C_DRP_CLKOUT1_DIVIDE } {
	# Procedure called to validate C_DRP_CLKOUT1_DIVIDE
	return true
}


proc update_MODELPARAM_VALUE.C_IP_LICENSE_TYPE { MODELPARAM_VALUE.C_IP_LICENSE_TYPE PARAM_VALUE.C_IP_LICENSE_TYPE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_IP_LICENSE_TYPE}] ${MODELPARAM_VALUE.C_IP_LICENSE_TYPE}
}

proc update_MODELPARAM_VALUE.C_IP_MAJOR_REVISION { MODELPARAM_VALUE.C_IP_MAJOR_REVISION PARAM_VALUE.C_IP_MAJOR_REVISION } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_IP_MAJOR_REVISION}] ${MODELPARAM_VALUE.C_IP_MAJOR_REVISION}
}

proc update_MODELPARAM_VALUE.C_IP_MINOR_REVISION { MODELPARAM_VALUE.C_IP_MINOR_REVISION PARAM_VALUE.C_IP_MINOR_REVISION } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_IP_MINOR_REVISION}] ${MODELPARAM_VALUE.C_IP_MINOR_REVISION}
}

proc update_MODELPARAM_VALUE.C_IP_PATCH_LEVEL { MODELPARAM_VALUE.C_IP_PATCH_LEVEL PARAM_VALUE.C_IP_PATCH_LEVEL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_IP_PATCH_LEVEL}] ${MODELPARAM_VALUE.C_IP_PATCH_LEVEL}
}

proc update_MODELPARAM_VALUE.C_REGS_INTERFACE { MODELPARAM_VALUE.C_REGS_INTERFACE PARAM_VALUE.C_REGS_INTERFACE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_REGS_INTERFACE}] ${MODELPARAM_VALUE.C_REGS_INTERFACE}
}

proc update_MODELPARAM_VALUE.C_REGS_BASEADDR { MODELPARAM_VALUE.C_REGS_BASEADDR PARAM_VALUE.C_REGS_BASEADDR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_REGS_BASEADDR}] ${MODELPARAM_VALUE.C_REGS_BASEADDR}
}

proc update_MODELPARAM_VALUE.C_REGS_HIGHADDR { MODELPARAM_VALUE.C_REGS_HIGHADDR PARAM_VALUE.C_REGS_HIGHADDR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_REGS_HIGHADDR}] ${MODELPARAM_VALUE.C_REGS_HIGHADDR}
}

proc update_MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH PARAM_VALUE.C_S_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH PARAM_VALUE.C_S_AXI_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_RST_POLARITY { MODELPARAM_VALUE.C_RST_POLARITY PARAM_VALUE.C_RST_POLARITY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_RST_POLARITY}] ${MODELPARAM_VALUE.C_RST_POLARITY}
}

proc update_MODELPARAM_VALUE.C_OSC_CLK_FREQ_HZ { MODELPARAM_VALUE.C_OSC_CLK_FREQ_HZ PARAM_VALUE.C_OSC_CLK_FREQ_HZ } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_OSC_CLK_FREQ_HZ}] ${MODELPARAM_VALUE.C_OSC_CLK_FREQ_HZ}
}

proc update_MODELPARAM_VALUE.C_CLK_MULTIPLY { MODELPARAM_VALUE.C_CLK_MULTIPLY PARAM_VALUE.C_CLK_MULTIPLY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_CLK_MULTIPLY}] ${MODELPARAM_VALUE.C_CLK_MULTIPLY}
}

proc update_MODELPARAM_VALUE.C_CLK0_DIVIDE { MODELPARAM_VALUE.C_CLK0_DIVIDE PARAM_VALUE.C_CLK0_DIVIDE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_CLK0_DIVIDE}] ${MODELPARAM_VALUE.C_CLK0_DIVIDE}
}

proc update_MODELPARAM_VALUE.C_CLK1_DIVIDE { MODELPARAM_VALUE.C_CLK1_DIVIDE PARAM_VALUE.C_CLK1_DIVIDE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_CLK1_DIVIDE}] ${MODELPARAM_VALUE.C_CLK1_DIVIDE}
}

proc update_MODELPARAM_VALUE.C_CLK2_DIVIDE { MODELPARAM_VALUE.C_CLK2_DIVIDE PARAM_VALUE.C_CLK2_DIVIDE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_CLK2_DIVIDE}] ${MODELPARAM_VALUE.C_CLK2_DIVIDE}
}

proc update_MODELPARAM_VALUE.C_CLK3_DIVIDE { MODELPARAM_VALUE.C_CLK3_DIVIDE PARAM_VALUE.C_CLK3_DIVIDE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_CLK3_DIVIDE}] ${MODELPARAM_VALUE.C_CLK3_DIVIDE}
}

proc update_MODELPARAM_VALUE.C_CLK4_DIVIDE { MODELPARAM_VALUE.C_CLK4_DIVIDE PARAM_VALUE.C_CLK4_DIVIDE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_CLK4_DIVIDE}] ${MODELPARAM_VALUE.C_CLK4_DIVIDE}
}

proc update_MODELPARAM_VALUE.C_CLK5_DIVIDE { MODELPARAM_VALUE.C_CLK5_DIVIDE PARAM_VALUE.C_CLK5_DIVIDE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_CLK5_DIVIDE}] ${MODELPARAM_VALUE.C_CLK5_DIVIDE}
}

proc update_MODELPARAM_VALUE.C_USE_VLINK_CLK { MODELPARAM_VALUE.C_USE_VLINK_CLK PARAM_VALUE.C_USE_VLINK_CLK } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_USE_VLINK_CLK}] ${MODELPARAM_VALUE.C_USE_VLINK_CLK}
}

proc update_MODELPARAM_VALUE.C_USE_CLK_DRP { MODELPARAM_VALUE.C_USE_CLK_DRP PARAM_VALUE.C_USE_CLK_DRP } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_USE_CLK_DRP}] ${MODELPARAM_VALUE.C_USE_CLK_DRP}
}

proc update_MODELPARAM_VALUE.C_DRP_CLKFBOUT_PHASE { MODELPARAM_VALUE.C_DRP_CLKFBOUT_PHASE PARAM_VALUE.C_DRP_CLKFBOUT_PHASE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DRP_CLKFBOUT_PHASE}] ${MODELPARAM_VALUE.C_DRP_CLKFBOUT_PHASE}
}

proc update_MODELPARAM_VALUE.C_DRP_BANDWIDTH { MODELPARAM_VALUE.C_DRP_BANDWIDTH PARAM_VALUE.C_DRP_BANDWIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DRP_BANDWIDTH}] ${MODELPARAM_VALUE.C_DRP_BANDWIDTH}
}

proc update_MODELPARAM_VALUE.C_DRP_CLKFBOUT_MULT { MODELPARAM_VALUE.C_DRP_CLKFBOUT_MULT PARAM_VALUE.C_DRP_CLKFBOUT_MULT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DRP_CLKFBOUT_MULT}] ${MODELPARAM_VALUE.C_DRP_CLKFBOUT_MULT}
}

proc update_MODELPARAM_VALUE.C_DRP_DIVCLK_DIVIDE { MODELPARAM_VALUE.C_DRP_DIVCLK_DIVIDE PARAM_VALUE.C_DRP_DIVCLK_DIVIDE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DRP_DIVCLK_DIVIDE}] ${MODELPARAM_VALUE.C_DRP_DIVCLK_DIVIDE}
}

proc update_MODELPARAM_VALUE.C_DRP_CLKOUT0_DIVIDE { MODELPARAM_VALUE.C_DRP_CLKOUT0_DIVIDE PARAM_VALUE.C_DRP_CLKOUT0_DIVIDE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DRP_CLKOUT0_DIVIDE}] ${MODELPARAM_VALUE.C_DRP_CLKOUT0_DIVIDE}
}

proc update_MODELPARAM_VALUE.C_DRP_CLKOUT0_PHASE { MODELPARAM_VALUE.C_DRP_CLKOUT0_PHASE PARAM_VALUE.C_DRP_CLKOUT0_PHASE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DRP_CLKOUT0_PHASE}] ${MODELPARAM_VALUE.C_DRP_CLKOUT0_PHASE}
}

proc update_MODELPARAM_VALUE.C_DRP_CLKOUT0_DUTY { MODELPARAM_VALUE.C_DRP_CLKOUT0_DUTY PARAM_VALUE.C_DRP_CLKOUT0_DUTY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DRP_CLKOUT0_DUTY}] ${MODELPARAM_VALUE.C_DRP_CLKOUT0_DUTY}
}

proc update_MODELPARAM_VALUE.C_DRP_CLKOUT1_DIVIDE { MODELPARAM_VALUE.C_DRP_CLKOUT1_DIVIDE PARAM_VALUE.C_DRP_CLKOUT1_DIVIDE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DRP_CLKOUT1_DIVIDE}] ${MODELPARAM_VALUE.C_DRP_CLKOUT1_DIVIDE}
}

proc update_MODELPARAM_VALUE.C_DRP_CLKOUT1_PHASE { MODELPARAM_VALUE.C_DRP_CLKOUT1_PHASE PARAM_VALUE.C_DRP_CLKOUT1_PHASE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DRP_CLKOUT1_PHASE}] ${MODELPARAM_VALUE.C_DRP_CLKOUT1_PHASE}
}

proc update_MODELPARAM_VALUE.C_DRP_CLKOUT1_DUTY { MODELPARAM_VALUE.C_DRP_CLKOUT1_DUTY PARAM_VALUE.C_DRP_CLKOUT1_DUTY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DRP_CLKOUT1_DUTY}] ${MODELPARAM_VALUE.C_DRP_CLKOUT1_DUTY}
}

proc update_MODELPARAM_VALUE.C_DRP_CLKOUT2_DIVIDE { MODELPARAM_VALUE.C_DRP_CLKOUT2_DIVIDE PARAM_VALUE.C_DRP_CLKOUT2_DIVIDE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DRP_CLKOUT2_DIVIDE}] ${MODELPARAM_VALUE.C_DRP_CLKOUT2_DIVIDE}
}

proc update_MODELPARAM_VALUE.C_DRP_CLKOUT2_PHASE { MODELPARAM_VALUE.C_DRP_CLKOUT2_PHASE PARAM_VALUE.C_DRP_CLKOUT2_PHASE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DRP_CLKOUT2_PHASE}] ${MODELPARAM_VALUE.C_DRP_CLKOUT2_PHASE}
}

proc update_MODELPARAM_VALUE.C_DRP_CLKOUT2_DUTY { MODELPARAM_VALUE.C_DRP_CLKOUT2_DUTY PARAM_VALUE.C_DRP_CLKOUT2_DUTY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DRP_CLKOUT2_DUTY}] ${MODELPARAM_VALUE.C_DRP_CLKOUT2_DUTY}
}

proc update_MODELPARAM_VALUE.C_DRP_CLKOUT3_DIVIDE { MODELPARAM_VALUE.C_DRP_CLKOUT3_DIVIDE PARAM_VALUE.C_DRP_CLKOUT3_DIVIDE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DRP_CLKOUT3_DIVIDE}] ${MODELPARAM_VALUE.C_DRP_CLKOUT3_DIVIDE}
}

proc update_MODELPARAM_VALUE.C_DRP_CLKOUT3_PHASE { MODELPARAM_VALUE.C_DRP_CLKOUT3_PHASE PARAM_VALUE.C_DRP_CLKOUT3_PHASE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DRP_CLKOUT3_PHASE}] ${MODELPARAM_VALUE.C_DRP_CLKOUT3_PHASE}
}

proc update_MODELPARAM_VALUE.C_DRP_CLKOUT3_DUTY { MODELPARAM_VALUE.C_DRP_CLKOUT3_DUTY PARAM_VALUE.C_DRP_CLKOUT3_DUTY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DRP_CLKOUT3_DUTY}] ${MODELPARAM_VALUE.C_DRP_CLKOUT3_DUTY}
}

proc update_MODELPARAM_VALUE.C_DRP_CLKOUT4_DIVIDE { MODELPARAM_VALUE.C_DRP_CLKOUT4_DIVIDE PARAM_VALUE.C_DRP_CLKOUT4_DIVIDE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DRP_CLKOUT4_DIVIDE}] ${MODELPARAM_VALUE.C_DRP_CLKOUT4_DIVIDE}
}

proc update_MODELPARAM_VALUE.C_DRP_CLKOUT4_PHASE { MODELPARAM_VALUE.C_DRP_CLKOUT4_PHASE PARAM_VALUE.C_DRP_CLKOUT4_PHASE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DRP_CLKOUT4_PHASE}] ${MODELPARAM_VALUE.C_DRP_CLKOUT4_PHASE}
}

proc update_MODELPARAM_VALUE.C_DRP_CLKOUT4_DUTY { MODELPARAM_VALUE.C_DRP_CLKOUT4_DUTY PARAM_VALUE.C_DRP_CLKOUT4_DUTY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DRP_CLKOUT4_DUTY}] ${MODELPARAM_VALUE.C_DRP_CLKOUT4_DUTY}
}

proc update_MODELPARAM_VALUE.C_DRP_CLKOUT5_DIVIDE { MODELPARAM_VALUE.C_DRP_CLKOUT5_DIVIDE PARAM_VALUE.C_DRP_CLKOUT5_DIVIDE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DRP_CLKOUT5_DIVIDE}] ${MODELPARAM_VALUE.C_DRP_CLKOUT5_DIVIDE}
}

proc update_MODELPARAM_VALUE.C_DRP_CLKOUT5_PHASE { MODELPARAM_VALUE.C_DRP_CLKOUT5_PHASE PARAM_VALUE.C_DRP_CLKOUT5_PHASE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DRP_CLKOUT5_PHASE}] ${MODELPARAM_VALUE.C_DRP_CLKOUT5_PHASE}
}

proc update_MODELPARAM_VALUE.C_DRP_CLKOUT5_DUTY { MODELPARAM_VALUE.C_DRP_CLKOUT5_DUTY PARAM_VALUE.C_DRP_CLKOUT5_DUTY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DRP_CLKOUT5_DUTY}] ${MODELPARAM_VALUE.C_DRP_CLKOUT5_DUTY}
}


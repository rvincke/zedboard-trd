// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2014.2
// Copyright (C) 2014 Xilinx Inc. All rights reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module image_filter_image_filter_Block_codeRepl_proc99 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        return_r,
        return_r_ap_vld,
        cols
);

parameter    ap_const_logic_1 = 1'b1;
parameter    ap_const_logic_0 = 1'b0;
parameter    ap_ST_st1_fsm_0 = 1'b0;
parameter    ap_const_lv12_0 = 12'b000000000000;
parameter    ap_true = 1'b1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
output  [11:0] return_r;
output   return_r_ap_vld;
input  [31:0] cols;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg[11:0] return_r;
reg return_r_ap_vld;
reg    ap_done_reg = 1'b0;
reg   [0:0] ap_CS_fsm = 1'b0;
reg    ap_sig_bdd_27;
wire   [11:0] tmp_fu_30_p1;
reg   [11:0] return_r_preg = 12'b000000000000;
reg   [0:0] ap_NS_fsm;




/// the current state (ap_CS_fsm) of the state machine. ///
always @ (posedge ap_clk)
begin : ap_ret_ap_CS_fsm
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_st1_fsm_0;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

/// ap_done_reg assign process. ///
always @ (posedge ap_clk)
begin : ap_ret_ap_done_reg
    if (ap_rst == 1'b1) begin
        ap_done_reg <= ap_const_logic_0;
    end else begin
        if ((ap_const_logic_1 == ap_continue)) begin
            ap_done_reg <= ap_const_logic_0;
        end else if (((ap_ST_st1_fsm_0 == ap_CS_fsm) & ~ap_sig_bdd_27)) begin
            ap_done_reg <= ap_const_logic_1;
        end
    end
end

/// return_r_preg assign process. ///
always @ (posedge ap_clk)
begin : ap_ret_return_r_preg
    if (ap_rst == 1'b1) begin
        return_r_preg <= ap_const_lv12_0;
    end else begin
        if (((ap_ST_st1_fsm_0 == ap_CS_fsm) & ~ap_sig_bdd_27)) begin
            return_r_preg <= tmp_fu_30_p1;
        end
    end
end

/// ap_done assign process. ///
always @ (ap_done_reg or ap_CS_fsm or ap_sig_bdd_27)
begin
    if (((ap_const_logic_1 == ap_done_reg) | ((ap_ST_st1_fsm_0 == ap_CS_fsm) & ~ap_sig_bdd_27))) begin
        ap_done = ap_const_logic_1;
    end else begin
        ap_done = ap_const_logic_0;
    end
end

/// ap_idle assign process. ///
always @ (ap_start or ap_CS_fsm)
begin
    if ((~(ap_const_logic_1 == ap_start) & (ap_ST_st1_fsm_0 == ap_CS_fsm))) begin
        ap_idle = ap_const_logic_1;
    end else begin
        ap_idle = ap_const_logic_0;
    end
end

/// ap_ready assign process. ///
always @ (ap_CS_fsm or ap_sig_bdd_27)
begin
    if (((ap_ST_st1_fsm_0 == ap_CS_fsm) & ~ap_sig_bdd_27)) begin
        ap_ready = ap_const_logic_1;
    end else begin
        ap_ready = ap_const_logic_0;
    end
end

/// return_r assign process. ///
always @ (ap_CS_fsm or ap_sig_bdd_27 or tmp_fu_30_p1 or return_r_preg)
begin
    if (((ap_ST_st1_fsm_0 == ap_CS_fsm) & ~ap_sig_bdd_27)) begin
        return_r = tmp_fu_30_p1;
    end else begin
        return_r = return_r_preg;
    end
end

/// return_r_ap_vld assign process. ///
always @ (ap_CS_fsm or ap_sig_bdd_27)
begin
    if (((ap_ST_st1_fsm_0 == ap_CS_fsm) & ~ap_sig_bdd_27)) begin
        return_r_ap_vld = ap_const_logic_1;
    end else begin
        return_r_ap_vld = ap_const_logic_0;
    end
end
/// the next state (ap_NS_fsm) of the state machine. ///
always @ (ap_CS_fsm or ap_sig_bdd_27)
begin
    case (ap_CS_fsm)
        ap_ST_st1_fsm_0 : 
        begin
            ap_NS_fsm = ap_ST_st1_fsm_0;
        end
        default : 
        begin
            ap_NS_fsm = 'bx;
        end
    endcase
end


/// ap_sig_bdd_27 assign process. ///
always @ (ap_start or ap_done_reg)
begin
    ap_sig_bdd_27 = ((ap_start == ap_const_logic_0) | (ap_done_reg == ap_const_logic_1));
end
assign tmp_fu_30_p1 = cols[11:0];


endmodule //image_filter_image_filter_Block_codeRepl_proc99


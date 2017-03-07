// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2014.2
// Copyright (C) 2014 Xilinx Inc. All rights reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module image_filter_AXIvideo2Mat_16_1080_1920_16_s (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        AXI_video_strm_V_data_V_dout,
        AXI_video_strm_V_data_V_empty_n,
        AXI_video_strm_V_data_V_read,
        AXI_video_strm_V_keep_V_dout,
        AXI_video_strm_V_keep_V_empty_n,
        AXI_video_strm_V_keep_V_read,
        AXI_video_strm_V_strb_V_dout,
        AXI_video_strm_V_strb_V_empty_n,
        AXI_video_strm_V_strb_V_read,
        AXI_video_strm_V_user_V_dout,
        AXI_video_strm_V_user_V_empty_n,
        AXI_video_strm_V_user_V_read,
        AXI_video_strm_V_last_V_dout,
        AXI_video_strm_V_last_V_empty_n,
        AXI_video_strm_V_last_V_read,
        AXI_video_strm_V_id_V_dout,
        AXI_video_strm_V_id_V_empty_n,
        AXI_video_strm_V_id_V_read,
        AXI_video_strm_V_dest_V_dout,
        AXI_video_strm_V_dest_V_empty_n,
        AXI_video_strm_V_dest_V_read,
        img_rows_V_read,
        img_cols_V_read,
        img_data_stream_0_V_din,
        img_data_stream_0_V_full_n,
        img_data_stream_0_V_write,
        img_data_stream_1_V_din,
        img_data_stream_1_V_full_n,
        img_data_stream_1_V_write
);

parameter    ap_const_logic_1 = 1'b1;
parameter    ap_const_logic_0 = 1'b0;
parameter    ap_ST_st1_fsm_0 = 3'b000;
parameter    ap_ST_st2_fsm_1 = 3'b1;
parameter    ap_ST_st3_fsm_2 = 3'b10;
parameter    ap_ST_st4_fsm_3 = 3'b11;
parameter    ap_ST_pp1_stg0_fsm_4 = 3'b100;
parameter    ap_ST_st7_fsm_5 = 3'b101;
parameter    ap_ST_st8_fsm_6 = 3'b110;
parameter    ap_const_lv1_0 = 1'b0;
parameter    ap_const_lv12_0 = 12'b000000000000;
parameter    ap_const_lv1_1 = 1'b1;
parameter    ap_const_lv12_1 = 12'b1;
parameter    ap_const_lv32_8 = 32'b1000;
parameter    ap_const_lv32_F = 32'b1111;
parameter    ap_const_lv16_1 = 16'b1;
parameter    ap_true = 1'b1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input  [15:0] AXI_video_strm_V_data_V_dout;
input   AXI_video_strm_V_data_V_empty_n;
output   AXI_video_strm_V_data_V_read;
input  [1:0] AXI_video_strm_V_keep_V_dout;
input   AXI_video_strm_V_keep_V_empty_n;
output   AXI_video_strm_V_keep_V_read;
input  [1:0] AXI_video_strm_V_strb_V_dout;
input   AXI_video_strm_V_strb_V_empty_n;
output   AXI_video_strm_V_strb_V_read;
input  [0:0] AXI_video_strm_V_user_V_dout;
input   AXI_video_strm_V_user_V_empty_n;
output   AXI_video_strm_V_user_V_read;
input  [0:0] AXI_video_strm_V_last_V_dout;
input   AXI_video_strm_V_last_V_empty_n;
output   AXI_video_strm_V_last_V_read;
input  [0:0] AXI_video_strm_V_id_V_dout;
input   AXI_video_strm_V_id_V_empty_n;
output   AXI_video_strm_V_id_V_read;
input  [0:0] AXI_video_strm_V_dest_V_dout;
input   AXI_video_strm_V_dest_V_empty_n;
output   AXI_video_strm_V_dest_V_read;
input  [11:0] img_rows_V_read;
input  [11:0] img_cols_V_read;
output  [7:0] img_data_stream_0_V_din;
input   img_data_stream_0_V_full_n;
output   img_data_stream_0_V_write;
output  [7:0] img_data_stream_1_V_din;
input   img_data_stream_1_V_full_n;
output   img_data_stream_1_V_write;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg img_data_stream_0_V_write;
reg img_data_stream_1_V_write;
reg    ap_done_reg = 1'b0;
reg   [2:0] ap_CS_fsm = 3'b000;
reg   [11:0] p_1_reg_199;
reg   [0:0] eol_1_reg_210;
reg   [15:0] axi_data_V_1_reg_221;
reg   [0:0] eol_reg_232;
reg    ap_sig_bdd_83;
reg   [15:0] tmp_data_V_reg_407;
wire    AXI_video_strm_V_id_V0_status;
reg   [0:0] tmp_last_V_reg_415;
wire   [11:0] i_V_fu_339_p2;
reg   [11:0] i_V_reg_430;
wire   [0:0] exitcond2_fu_345_p2;
reg   [0:0] exitcond2_reg_435;
reg    ap_reg_ppiten_pp1_it0 = 1'b0;
wire   [0:0] brmerge_fu_370_p2;
reg    ap_sig_bdd_118;
reg    ap_reg_ppiten_pp1_it1 = 1'b0;
wire   [11:0] j_V_fu_350_p2;
reg   [0:0] sof_1_load_reg_444;
wire   [0:0] not_sof_2_fu_359_p2;
reg   [0:0] not_sof_2_reg_449;
reg    ap_sig_bdd_137;
wire   [0:0] exitcond1_fu_334_p2;
reg   [0:0] axi_last_V_3_reg_279;
reg   [0:0] axi_last_V1_reg_168;
reg   [15:0] axi_data_V_3_reg_291;
reg   [15:0] axi_data_V1_reg_178;
reg   [11:0] p_s_reg_188;
reg   [0:0] axi_last_V_2_phi_fu_248_p4;
reg   [15:0] p_Val2_s_phi_fu_260_p4;
reg   [0:0] eol_2_phi_fu_272_p4;
wire   [0:0] eol_1_mux_fu_375_p2;
reg   [0:0] eol_3_reg_303;
reg    AXI_video_strm_V_id_V0_update;
reg   [0:0] sof_1_fu_120;
wire   [0:0] tmp_user_V_fu_325_p1;
reg   [2:0] ap_NS_fsm;
reg    ap_sig_bdd_298;




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
        end else if (((ap_ST_st4_fsm_3 == ap_CS_fsm) & ~(ap_const_lv1_0 == exitcond1_fu_334_p2))) begin
            ap_done_reg <= ap_const_logic_1;
        end
    end
end

/// ap_reg_ppiten_pp1_it0 assign process. ///
always @ (posedge ap_clk)
begin : ap_ret_ap_reg_ppiten_pp1_it0
    if (ap_rst == 1'b1) begin
        ap_reg_ppiten_pp1_it0 <= ap_const_logic_0;
    end else begin
        if (((ap_ST_pp1_stg0_fsm_4 == ap_CS_fsm) & ~(ap_sig_bdd_118 & (ap_const_logic_1 == ap_reg_ppiten_pp1_it1)) & ~(exitcond2_fu_345_p2 == ap_const_lv1_0))) begin
            ap_reg_ppiten_pp1_it0 <= ap_const_logic_0;
        end else if (((ap_ST_st4_fsm_3 == ap_CS_fsm) & (ap_const_lv1_0 == exitcond1_fu_334_p2))) begin
            ap_reg_ppiten_pp1_it0 <= ap_const_logic_1;
        end
    end
end

/// ap_reg_ppiten_pp1_it1 assign process. ///
always @ (posedge ap_clk)
begin : ap_ret_ap_reg_ppiten_pp1_it1
    if (ap_rst == 1'b1) begin
        ap_reg_ppiten_pp1_it1 <= ap_const_logic_0;
    end else begin
        if (((ap_ST_pp1_stg0_fsm_4 == ap_CS_fsm) & ~(ap_sig_bdd_118 & (ap_const_logic_1 == ap_reg_ppiten_pp1_it1)))) begin
            ap_reg_ppiten_pp1_it1 <= ap_reg_ppiten_pp1_it0;
        end else if (((ap_ST_st4_fsm_3 == ap_CS_fsm) & (ap_const_lv1_0 == exitcond1_fu_334_p2))) begin
            ap_reg_ppiten_pp1_it1 <= ap_const_logic_0;
        end
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if ((ap_ST_st3_fsm_2 == ap_CS_fsm)) begin
        axi_data_V1_reg_178 <= tmp_data_V_reg_407;
    end else if ((ap_ST_st8_fsm_6 == ap_CS_fsm)) begin
        axi_data_V1_reg_178 <= axi_data_V_3_reg_291;
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if (((ap_ST_pp1_stg0_fsm_4 == ap_CS_fsm) & (exitcond2_reg_435 == ap_const_lv1_0) & (ap_const_logic_1 == ap_reg_ppiten_pp1_it1) & ~(ap_sig_bdd_118 & (ap_const_logic_1 == ap_reg_ppiten_pp1_it1)))) begin
        axi_data_V_1_reg_221 <= p_Val2_s_phi_fu_260_p4;
    end else if (((ap_ST_st4_fsm_3 == ap_CS_fsm) & (ap_const_lv1_0 == exitcond1_fu_334_p2))) begin
        axi_data_V_1_reg_221 <= axi_data_V1_reg_178;
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if (((ap_ST_pp1_stg0_fsm_4 == ap_CS_fsm) & (ap_const_logic_1 == ap_reg_ppiten_pp1_it1) & ~(ap_sig_bdd_118 & (ap_const_logic_1 == ap_reg_ppiten_pp1_it1)) & ~(exitcond2_reg_435 == ap_const_lv1_0))) begin
        axi_data_V_3_reg_291 <= axi_data_V_1_reg_221;
    end else if (((ap_ST_st7_fsm_5 == ap_CS_fsm) & (ap_const_lv1_0 == eol_3_reg_303) & ~ap_sig_bdd_137)) begin
        axi_data_V_3_reg_291 <= AXI_video_strm_V_data_V_dout;
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if ((ap_ST_st3_fsm_2 == ap_CS_fsm)) begin
        axi_last_V1_reg_168 <= tmp_last_V_reg_415;
    end else if ((ap_ST_st8_fsm_6 == ap_CS_fsm)) begin
        axi_last_V1_reg_168 <= axi_last_V_3_reg_279;
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if (((ap_ST_pp1_stg0_fsm_4 == ap_CS_fsm) & (ap_const_logic_1 == ap_reg_ppiten_pp1_it1) & ~(ap_sig_bdd_118 & (ap_const_logic_1 == ap_reg_ppiten_pp1_it1)) & ~(exitcond2_reg_435 == ap_const_lv1_0))) begin
        axi_last_V_3_reg_279 <= eol_1_reg_210;
    end else if (((ap_ST_st7_fsm_5 == ap_CS_fsm) & (ap_const_lv1_0 == eol_3_reg_303) & ~ap_sig_bdd_137)) begin
        axi_last_V_3_reg_279 <= AXI_video_strm_V_last_V_dout;
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if (((ap_ST_pp1_stg0_fsm_4 == ap_CS_fsm) & (exitcond2_reg_435 == ap_const_lv1_0) & (ap_const_logic_1 == ap_reg_ppiten_pp1_it1) & ~(ap_sig_bdd_118 & (ap_const_logic_1 == ap_reg_ppiten_pp1_it1)))) begin
        eol_1_reg_210 <= axi_last_V_2_phi_fu_248_p4;
    end else if (((ap_ST_st4_fsm_3 == ap_CS_fsm) & (ap_const_lv1_0 == exitcond1_fu_334_p2))) begin
        eol_1_reg_210 <= axi_last_V1_reg_168;
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if (((ap_ST_pp1_stg0_fsm_4 == ap_CS_fsm) & (ap_const_logic_1 == ap_reg_ppiten_pp1_it1) & ~(ap_sig_bdd_118 & (ap_const_logic_1 == ap_reg_ppiten_pp1_it1)) & ~(exitcond2_reg_435 == ap_const_lv1_0))) begin
        eol_3_reg_303 <= eol_reg_232;
    end else if (((ap_ST_st7_fsm_5 == ap_CS_fsm) & (ap_const_lv1_0 == eol_3_reg_303) & ~ap_sig_bdd_137)) begin
        eol_3_reg_303 <= AXI_video_strm_V_last_V_dout;
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if (((ap_ST_pp1_stg0_fsm_4 == ap_CS_fsm) & (exitcond2_reg_435 == ap_const_lv1_0) & (ap_const_logic_1 == ap_reg_ppiten_pp1_it1) & ~(ap_sig_bdd_118 & (ap_const_logic_1 == ap_reg_ppiten_pp1_it1)))) begin
        eol_reg_232 <= eol_2_phi_fu_272_p4;
    end else if (((ap_ST_st4_fsm_3 == ap_CS_fsm) & (ap_const_lv1_0 == exitcond1_fu_334_p2))) begin
        eol_reg_232 <= ap_const_lv1_0;
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if (((ap_ST_pp1_stg0_fsm_4 == ap_CS_fsm) & (ap_const_logic_1 == ap_reg_ppiten_pp1_it0) & ~(ap_sig_bdd_118 & (ap_const_logic_1 == ap_reg_ppiten_pp1_it1)) & (exitcond2_fu_345_p2 == ap_const_lv1_0))) begin
        p_1_reg_199 <= j_V_fu_350_p2;
    end else if (((ap_ST_st4_fsm_3 == ap_CS_fsm) & (ap_const_lv1_0 == exitcond1_fu_334_p2))) begin
        p_1_reg_199 <= ap_const_lv12_0;
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if ((ap_ST_st3_fsm_2 == ap_CS_fsm)) begin
        p_s_reg_188 <= ap_const_lv12_0;
    end else if ((ap_ST_st8_fsm_6 == ap_CS_fsm)) begin
        p_s_reg_188 <= i_V_reg_430;
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if (((ap_ST_pp1_stg0_fsm_4 == ap_CS_fsm) & (ap_const_logic_1 == ap_reg_ppiten_pp1_it0) & ~(ap_sig_bdd_118 & (ap_const_logic_1 == ap_reg_ppiten_pp1_it1)) & (exitcond2_fu_345_p2 == ap_const_lv1_0))) begin
        sof_1_fu_120 <= ap_const_lv1_0;
    end else if ((ap_ST_st3_fsm_2 == ap_CS_fsm)) begin
        sof_1_fu_120 <= ap_const_lv1_1;
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if (((ap_ST_pp1_stg0_fsm_4 == ap_CS_fsm) & (ap_const_logic_1 == ap_reg_ppiten_pp1_it0) & ~(ap_sig_bdd_118 & (ap_const_logic_1 == ap_reg_ppiten_pp1_it1)))) begin
        exitcond2_reg_435 <= exitcond2_fu_345_p2;
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if ((ap_ST_st4_fsm_3 == ap_CS_fsm)) begin
        i_V_reg_430 <= i_V_fu_339_p2;
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if (((ap_ST_pp1_stg0_fsm_4 == ap_CS_fsm) & (ap_const_logic_1 == ap_reg_ppiten_pp1_it0) & ~(ap_sig_bdd_118 & (ap_const_logic_1 == ap_reg_ppiten_pp1_it1)) & (exitcond2_fu_345_p2 == ap_const_lv1_0))) begin
        not_sof_2_reg_449 <= not_sof_2_fu_359_p2;
        sof_1_load_reg_444 <= sof_1_fu_120;
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if (((ap_ST_st2_fsm_1 == ap_CS_fsm) & ~(AXI_video_strm_V_id_V0_status == ap_const_logic_0))) begin
        tmp_data_V_reg_407 <= AXI_video_strm_V_data_V_dout;
        tmp_last_V_reg_415 <= AXI_video_strm_V_last_V_dout;
    end
end

/// AXI_video_strm_V_id_V0_update assign process. ///
always @ (ap_CS_fsm or AXI_video_strm_V_id_V0_status or exitcond2_reg_435 or brmerge_fu_370_p2 or ap_sig_bdd_118 or ap_reg_ppiten_pp1_it1 or ap_sig_bdd_137 or eol_3_reg_303)
begin
    if ((((ap_ST_st2_fsm_1 == ap_CS_fsm) & ~(AXI_video_strm_V_id_V0_status == ap_const_logic_0)) | ((ap_ST_st7_fsm_5 == ap_CS_fsm) & (ap_const_lv1_0 == eol_3_reg_303) & ~ap_sig_bdd_137) | ((ap_ST_pp1_stg0_fsm_4 == ap_CS_fsm) & (exitcond2_reg_435 == ap_const_lv1_0) & (ap_const_lv1_0 == brmerge_fu_370_p2) & (ap_const_logic_1 == ap_reg_ppiten_pp1_it1) & ~(ap_sig_bdd_118 & (ap_const_logic_1 == ap_reg_ppiten_pp1_it1))))) begin
        AXI_video_strm_V_id_V0_update = ap_const_logic_1;
    end else begin
        AXI_video_strm_V_id_V0_update = ap_const_logic_0;
    end
end

/// ap_done assign process. ///
always @ (ap_done_reg or ap_CS_fsm or exitcond1_fu_334_p2)
begin
    if (((ap_const_logic_1 == ap_done_reg) | ((ap_ST_st4_fsm_3 == ap_CS_fsm) & ~(ap_const_lv1_0 == exitcond1_fu_334_p2)))) begin
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
always @ (ap_CS_fsm or exitcond1_fu_334_p2)
begin
    if (((ap_ST_st4_fsm_3 == ap_CS_fsm) & ~(ap_const_lv1_0 == exitcond1_fu_334_p2))) begin
        ap_ready = ap_const_logic_1;
    end else begin
        ap_ready = ap_const_logic_0;
    end
end

/// axi_last_V_2_phi_fu_248_p4 assign process. ///
always @ (AXI_video_strm_V_last_V_dout or eol_1_reg_210 or brmerge_fu_370_p2 or ap_sig_bdd_298)
begin
    if (ap_sig_bdd_298) begin
        if (~(ap_const_lv1_0 == brmerge_fu_370_p2)) begin
            axi_last_V_2_phi_fu_248_p4 = eol_1_reg_210;
        end else if ((ap_const_lv1_0 == brmerge_fu_370_p2)) begin
            axi_last_V_2_phi_fu_248_p4 = AXI_video_strm_V_last_V_dout;
        end else begin
            axi_last_V_2_phi_fu_248_p4 = ap_const_lv1_1;
        end
    end else begin
        axi_last_V_2_phi_fu_248_p4 = ap_const_lv1_1;
    end
end

/// eol_2_phi_fu_272_p4 assign process. ///
always @ (AXI_video_strm_V_last_V_dout or brmerge_fu_370_p2 or eol_1_mux_fu_375_p2 or ap_sig_bdd_298)
begin
    if (ap_sig_bdd_298) begin
        if (~(ap_const_lv1_0 == brmerge_fu_370_p2)) begin
            eol_2_phi_fu_272_p4 = eol_1_mux_fu_375_p2;
        end else if ((ap_const_lv1_0 == brmerge_fu_370_p2)) begin
            eol_2_phi_fu_272_p4 = AXI_video_strm_V_last_V_dout;
        end else begin
            eol_2_phi_fu_272_p4 = ap_const_lv1_1;
        end
    end else begin
        eol_2_phi_fu_272_p4 = ap_const_lv1_1;
    end
end

/// img_data_stream_0_V_write assign process. ///
always @ (ap_CS_fsm or exitcond2_reg_435 or ap_sig_bdd_118 or ap_reg_ppiten_pp1_it1)
begin
    if (((ap_ST_pp1_stg0_fsm_4 == ap_CS_fsm) & (exitcond2_reg_435 == ap_const_lv1_0) & (ap_const_logic_1 == ap_reg_ppiten_pp1_it1) & ~(ap_sig_bdd_118 & (ap_const_logic_1 == ap_reg_ppiten_pp1_it1)))) begin
        img_data_stream_0_V_write = ap_const_logic_1;
    end else begin
        img_data_stream_0_V_write = ap_const_logic_0;
    end
end

/// img_data_stream_1_V_write assign process. ///
always @ (ap_CS_fsm or exitcond2_reg_435 or ap_sig_bdd_118 or ap_reg_ppiten_pp1_it1)
begin
    if (((ap_ST_pp1_stg0_fsm_4 == ap_CS_fsm) & (exitcond2_reg_435 == ap_const_lv1_0) & (ap_const_logic_1 == ap_reg_ppiten_pp1_it1) & ~(ap_sig_bdd_118 & (ap_const_logic_1 == ap_reg_ppiten_pp1_it1)))) begin
        img_data_stream_1_V_write = ap_const_logic_1;
    end else begin
        img_data_stream_1_V_write = ap_const_logic_0;
    end
end

/// p_Val2_s_phi_fu_260_p4 assign process. ///
always @ (AXI_video_strm_V_data_V_dout or axi_data_V_1_reg_221 or brmerge_fu_370_p2 or ap_sig_bdd_298)
begin
    if (ap_sig_bdd_298) begin
        if (~(ap_const_lv1_0 == brmerge_fu_370_p2)) begin
            p_Val2_s_phi_fu_260_p4 = axi_data_V_1_reg_221;
        end else if ((ap_const_lv1_0 == brmerge_fu_370_p2)) begin
            p_Val2_s_phi_fu_260_p4 = AXI_video_strm_V_data_V_dout;
        end else begin
            p_Val2_s_phi_fu_260_p4 = ap_const_lv16_1;
        end
    end else begin
        p_Val2_s_phi_fu_260_p4 = ap_const_lv16_1;
    end
end
/// the next state (ap_NS_fsm) of the state machine. ///
always @ (ap_CS_fsm or ap_sig_bdd_83 or AXI_video_strm_V_id_V0_status or ap_reg_ppiten_pp1_it0 or ap_sig_bdd_118 or ap_reg_ppiten_pp1_it1 or ap_sig_bdd_137 or exitcond1_fu_334_p2 or eol_3_reg_303 or tmp_user_V_fu_325_p1)
begin
    case (ap_CS_fsm)
        ap_ST_st1_fsm_0 : 
        begin
            if (~ap_sig_bdd_83) begin
                ap_NS_fsm = ap_ST_st2_fsm_1;
            end else begin
                ap_NS_fsm = ap_ST_st1_fsm_0;
            end
        end
        ap_ST_st2_fsm_1 : 
        begin
            if ((~(AXI_video_strm_V_id_V0_status == ap_const_logic_0) & (ap_const_lv1_0 == tmp_user_V_fu_325_p1))) begin
                ap_NS_fsm = ap_ST_st2_fsm_1;
            end else if ((~(AXI_video_strm_V_id_V0_status == ap_const_logic_0) & ~(ap_const_lv1_0 == tmp_user_V_fu_325_p1))) begin
                ap_NS_fsm = ap_ST_st3_fsm_2;
            end else begin
                ap_NS_fsm = ap_ST_st2_fsm_1;
            end
        end
        ap_ST_st3_fsm_2 : 
        begin
            ap_NS_fsm = ap_ST_st4_fsm_3;
        end
        ap_ST_st4_fsm_3 : 
        begin
            if (~(ap_const_lv1_0 == exitcond1_fu_334_p2)) begin
                ap_NS_fsm = ap_ST_st1_fsm_0;
            end else begin
                ap_NS_fsm = ap_ST_pp1_stg0_fsm_4;
            end
        end
        ap_ST_pp1_stg0_fsm_4 : 
        begin
            if (~((ap_ST_pp1_stg0_fsm_4 == ap_CS_fsm) & (ap_const_logic_1 == ap_reg_ppiten_pp1_it1) & ~(ap_sig_bdd_118 & (ap_const_logic_1 == ap_reg_ppiten_pp1_it1)) & ~(ap_const_logic_1 == ap_reg_ppiten_pp1_it0))) begin
                ap_NS_fsm = ap_ST_pp1_stg0_fsm_4;
            end else if (((ap_ST_pp1_stg0_fsm_4 == ap_CS_fsm) & (ap_const_logic_1 == ap_reg_ppiten_pp1_it1) & ~(ap_sig_bdd_118 & (ap_const_logic_1 == ap_reg_ppiten_pp1_it1)) & ~(ap_const_logic_1 == ap_reg_ppiten_pp1_it0))) begin
                ap_NS_fsm = ap_ST_st7_fsm_5;
            end else begin
                ap_NS_fsm = ap_ST_pp1_stg0_fsm_4;
            end
        end
        ap_ST_st7_fsm_5 : 
        begin
            if (((ap_const_lv1_0 == eol_3_reg_303) & ~ap_sig_bdd_137)) begin
                ap_NS_fsm = ap_ST_st7_fsm_5;
            end else if ((~ap_sig_bdd_137 & ~(ap_const_lv1_0 == eol_3_reg_303))) begin
                ap_NS_fsm = ap_ST_st8_fsm_6;
            end else begin
                ap_NS_fsm = ap_ST_st7_fsm_5;
            end
        end
        ap_ST_st8_fsm_6 : 
        begin
            ap_NS_fsm = ap_ST_st4_fsm_3;
        end
        default : 
        begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign AXI_video_strm_V_data_V_read = AXI_video_strm_V_id_V0_update;
assign AXI_video_strm_V_dest_V_read = AXI_video_strm_V_id_V0_update;
assign AXI_video_strm_V_id_V0_status = (AXI_video_strm_V_data_V_empty_n & AXI_video_strm_V_keep_V_empty_n & AXI_video_strm_V_strb_V_empty_n & AXI_video_strm_V_user_V_empty_n & AXI_video_strm_V_last_V_empty_n & AXI_video_strm_V_id_V_empty_n & AXI_video_strm_V_dest_V_empty_n);
assign AXI_video_strm_V_id_V_read = AXI_video_strm_V_id_V0_update;
assign AXI_video_strm_V_keep_V_read = AXI_video_strm_V_id_V0_update;
assign AXI_video_strm_V_last_V_read = AXI_video_strm_V_id_V0_update;
assign AXI_video_strm_V_strb_V_read = AXI_video_strm_V_id_V0_update;
assign AXI_video_strm_V_user_V_read = AXI_video_strm_V_id_V0_update;

/// ap_sig_bdd_118 assign process. ///
always @ (img_data_stream_0_V_full_n or img_data_stream_1_V_full_n or AXI_video_strm_V_id_V0_status or exitcond2_reg_435 or brmerge_fu_370_p2)
begin
    ap_sig_bdd_118 = (((AXI_video_strm_V_id_V0_status == ap_const_logic_0) & (exitcond2_reg_435 == ap_const_lv1_0) & (ap_const_lv1_0 == brmerge_fu_370_p2)) | ((exitcond2_reg_435 == ap_const_lv1_0) & (img_data_stream_0_V_full_n == ap_const_logic_0)) | ((exitcond2_reg_435 == ap_const_lv1_0) & (img_data_stream_1_V_full_n == ap_const_logic_0)));
end

/// ap_sig_bdd_137 assign process. ///
always @ (AXI_video_strm_V_id_V0_status or eol_3_reg_303)
begin
    ap_sig_bdd_137 = ((AXI_video_strm_V_id_V0_status == ap_const_logic_0) & (ap_const_lv1_0 == eol_3_reg_303));
end

/// ap_sig_bdd_298 assign process. ///
always @ (ap_CS_fsm or exitcond2_reg_435 or ap_reg_ppiten_pp1_it1)
begin
    ap_sig_bdd_298 = ((ap_ST_pp1_stg0_fsm_4 == ap_CS_fsm) & (exitcond2_reg_435 == ap_const_lv1_0) & (ap_const_logic_1 == ap_reg_ppiten_pp1_it1));
end

/// ap_sig_bdd_83 assign process. ///
always @ (ap_start or ap_done_reg)
begin
    ap_sig_bdd_83 = ((ap_start == ap_const_logic_0) | (ap_done_reg == ap_const_logic_1));
end
assign brmerge_fu_370_p2 = (sof_1_load_reg_444 | eol_reg_232);
assign eol_1_mux_fu_375_p2 = (eol_1_reg_210 | not_sof_2_reg_449);
assign exitcond1_fu_334_p2 = (p_s_reg_188 == img_rows_V_read? 1'b1: 1'b0);
assign exitcond2_fu_345_p2 = (p_1_reg_199 == img_cols_V_read? 1'b1: 1'b0);
assign i_V_fu_339_p2 = (p_s_reg_188 + ap_const_lv12_1);
assign img_data_stream_0_V_din = p_Val2_s_phi_fu_260_p4[7:0];
assign img_data_stream_1_V_din = {{p_Val2_s_phi_fu_260_p4[ap_const_lv32_F : ap_const_lv32_8]}};
assign j_V_fu_350_p2 = (p_1_reg_199 + ap_const_lv12_1);
assign not_sof_2_fu_359_p2 = (sof_1_fu_120 ^ ap_const_lv1_1);
assign tmp_user_V_fu_325_p1 = AXI_video_strm_V_user_V_dout;


endmodule //image_filter_AXIvideo2Mat_16_1080_1920_16_s

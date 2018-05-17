#!/usr/bin/python3
#
# Copyright 2018 Ettus Research, a National Instruments Company
#
# SPDX-License-Identifier: LGPL-3.0-or-later
#

create_project tmp_proj -part xc7k410tffg900-3 -in_memory
add_files {ctrl_crossbar_top.v ../axis_ctrl_crossbar_2d_mesh.v ../mesh_2d_dor_router_multi_sw.v ../axis_switch.v ../axis_ingress_vc_buff.v ../mesh_node_mapping.vh ../mesh_2d_dor_router_single_sw.v ../torus_2d_dor_router_single_sw.v ../torus_2d_dor_router_multi_sw.v}
add_files {../../fifo/axi_fifo_flop.v ../../fifo/axi_fifo_flop2.v ../../fifo/axi_fifo.v ../../fifo/axi_mux_select.v ../../fifo/axi_fifo_bram.v ../../fifo/axi_fifo_cascade.v ../../fifo/axi_mux.v ../../fifo/axi_fifo_short.v ../../fifo/axi_demux.v ../../fifo/axi_packet_gate.v}
set_property top ctrl_crossbar_top [current_fileset]
synth_design
create_clock -name clk -period 2.0 [get_ports clk]
report_utilization -file router_util.rpt
report_timing_summary -file router_timing.rpt
write_checkpoint -force router_synth.dcp
close_project
exit
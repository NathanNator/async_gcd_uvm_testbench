`timescale 1ns/1ps

module tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import gcd_const_pkg::*;
  import gcd_test_pkg::*;

  logic lr, la, rr, ra;
  logic [DATA_WIDTH-1:0] a;
  logic [DATA_WIDTH-1:0] b;
  wire [DATA_WIDTH-1:0] gcd;
  logic rst; 

  lc_if #(INPUT_DATA_WIDTH) lc_in_vif(); 
  lc_if #(OUTPUT_DATA_WIDTH) lc_out_vif();

  assign rst = lc_in_vif.rst;
  assign lr = lc_in_vif.req;
  assign lc_in_vif.ack = la;
  assign {a,b} = lc_in_vif.data;

  assign lc_out_vif.req = rr;
  assign ra = lc_out_vif.ack;
  assign lc_out_vif.data = gcd;

  gcd #(
    .DATA_WIDTH(DATA_WIDTH))
  DUT (
    .lr(lr), 
    .la(la), 
    .a(a), 
    .b(b), 
    .rr(rr), 
    .ra(ra), 
    .gcd(gcd), 
    .rst(rst)
  );

  initial begin 

    uvm_config_db#(virtual lc_if #(INPUT_DATA_WIDTH))::set(uvm_root::get(),"*","lc_in_vif",lc_in_vif);
    uvm_config_db#(virtual lc_if #(OUTPUT_DATA_WIDTH))::set(uvm_root::get(),"*","lc_out_vif",lc_out_vif);

    run_test();
  end
  
endmodule 


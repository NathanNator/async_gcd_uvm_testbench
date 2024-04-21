package gcd_const_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  localparam DATA_WIDTH = 32; 
  localparam INPUT_DATA_WIDTH = DATA_WIDTH*2; 
  localparam OUTPUT_DATA_WIDTH = DATA_WIDTH; 

endpackage: gcd_const_pkg
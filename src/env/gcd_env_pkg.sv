package gcd_env_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import lc_agent_pkg::*; 
  import gcd_const_pkg::*; 

  `include "gcd_env_cfg.svh"
  `include "gcd_predictor.svh"
  `include "gcd_coverage_collector.svh"
  `include "gcd_sb.svh"
  `include "gcd_env.svh"

  `include "sequences/gcd_base_seq.svh"
  `include "sequences/gcd_write_seq.svh"

endpackage: gcd_env_pkg
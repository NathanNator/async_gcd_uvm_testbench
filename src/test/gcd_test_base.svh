class gcd_test_base extends uvm_test;
  `uvm_component_utils(gcd_test_base)

  gcd_env env;
  gcd_env_cfg env_cfg;

  function new(string name = "gcd_test_base",uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = gcd_env::type_id::create("env", this);
    env_cfg = gcd_env_cfg::type_id::create("env_cfg", this);

    env_cfg.init_cfg(UVM_ACTIVE);

    env_cfg.has_scoreboard = 1; 
    env.env_cfg = env_cfg;
  endfunction : build_phase

  virtual function void end_of_elaboration_phase (uvm_phase phase);
    uvm_top.print_topology();
  endfunction

endclass : gcd_test_base
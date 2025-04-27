//------------------------------------------------------------------------------
// CLASS: lc_agent
//------------------------------------------------------------------------------
class lc_agent #(int D_WIDTH=32) extends uvm_agent;
  `uvm_component_param_utils (lc_agent #(D_WIDTH))

  typedef lc_cfg #(D_WIDTH) lc_cfg_t;
  typedef lc_driver #(D_WIDTH) lc_driver_t;
  typedef lc_monitor #(D_WIDTH) lc_monitor_t;
  typedef uvm_sequencer #(lc_sequence_item #(D_WIDTH)) lc_sequencer_t;

  lc_cfg_t        cfg; 
  lc_driver_t     driver;
  lc_monitor_t    monitor;
  lc_sequencer_t  sequencer;

  uvm_analysis_port #(lc_sequence_item #(D_WIDTH)) ap; 

  // constructor
  function new (string name = "lc_tx_agent", uvm_component parent = null);
    super.new (name, parent);
  endfunction: new

  // build_phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(cfg == null) begin 
      if (!uvm_config_db #(lc_cfg_t)::get(this,"*","lc_cfg", cfg))
        `uvm_fatal("FATAL MSG", "Configuration object is not set properly");
    end

    if(cfg.active == UVM_ACTIVE) begin
      driver = lc_driver_t::type_id::create("driver", this);
      driver.cfg = cfg; 
      sequencer = lc_sequencer_t::type_id::create("sequencer", this);
    end

    monitor = lc_monitor_t::type_id::create("monitor", this);
    monitor.cfg = cfg;

    ap = new("ap", this);

  endfunction: build_phase

  // connect_phase
  virtual function void connect_phase(uvm_phase phase);

    if(cfg.active == UVM_ACTIVE) begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end

    ap = monitor.mon_analysis_port; 
    
  endfunction: connect_phase

endclass: lc_agent
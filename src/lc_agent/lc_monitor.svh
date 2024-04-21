//------------------------------------------------------------------------------
// CLASS: lc_monitor
//------------------------------------------------------------------------------
class lc_monitor #(int D_WIDTH=32) extends uvm_monitor;
  `uvm_component_param_utils(lc_monitor #(D_WIDTH))

  typedef virtual lc_if #(D_WIDTH) lc_if_t;
  typedef lc_cfg #(D_WIDTH) lc_cfg_t;
  typedef lc_sequence_item #(D_WIDTH) lc_sequence_item_t;

  lc_if_t  vif;
  lc_cfg_t cfg; 

  uvm_analysis_port #(lc_sequence_item_t) mon_analysis_port;

	// constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction: new

	// build_phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(cfg == null) begin 
      if (!uvm_config_db #(lc_cfg_t)::get(this,"*","lc_cfg", cfg))
        `uvm_fatal("FATAL MSG", "Configuration object is not set properly");
    end 
   
    vif = cfg.vif; 

    mon_analysis_port = new("mon_analysis_port", this);
  endfunction: build_phase

  // run phase
  virtual task run_phase(uvm_phase phase);

    if(cfg.is_send_req) 
      send_req();
    else 
      recv_req();

  endtask: run_phase

  virtual task send_req();

    lc_sequence_item_t mon_item = lc_sequence_item_t::type_id::create("mon_item");

    forever begin
      
      // Sample DUT information that is being write 
      @(posedge vif.ack) begin 
        mon_item.data = vif.data;  
        mon_analysis_port.write(mon_item);
      end 

    end 

  endtask: send_req

  virtual task recv_req();

    lc_sequence_item_t mon_item = lc_sequence_item_t::type_id::create("mon_item");

    forever begin
      
      // Sample DUT information that is being write 
      @(posedge vif.req) begin 
        #(5ns); mon_item.data = vif.data;  
        mon_analysis_port.write(mon_item);
      end 

    end 

  endtask: recv_req

endclass: lc_monitor
//------------------------------------------------------------------------------
// CLASS: lc_driver
//------------------------------------------------------------------------------
class lc_driver #(parameter D_WIDTH=32) extends uvm_driver #(lc_sequence_item #(D_WIDTH));
  `uvm_component_param_utils(lc_driver #(D_WIDTH))

  typedef virtual lc_if #(D_WIDTH) lc_if_t;
  typedef lc_cfg #(D_WIDTH) lc_cfg_t;

  lc_if_t vif;
  lc_cfg_t cfg; 

  int reset_time = 30ns;

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
  endfunction: build_phase

  virtual task reset_dut();

    vif.rst <= 0;
    vif.req <= 0;
    vif.data <= 0;

    #(reset_time);
    vif.rst <= 1;

    #(reset_time);
    vif.rst <= 0;

    #(reset_time);

  endtask: reset_dut

  // run phase
  virtual task run_phase(uvm_phase phase);

    if(cfg.is_send_req) 
      send_req();
    else 
      recv_req();
    
  endtask: run_phase

  virtual task send_req();

    lc_sequence_item #(D_WIDTH) item;

    reset_dut();
    
    seq_item_port.get_next_item(item);
    vif.data <= item.data;
    vif.req <= 1;

    forever begin

      @(posedge vif.ack) begin
        #(1ns); vif.req = 0;
        seq_item_port.item_done(item);
      end

      @(negedge vif.ack) begin 
        seq_item_port.get_next_item(item);
        vif.data <= item.data;
        #(1ns); vif.req = 1; 
      end 

    end

  endtask: send_req

  virtual task recv_req();

    forever begin

      fork 
        @(posedge vif.req) begin
          #(5ns); vif.ack = 1; 
        end 

        @(negedge vif.req) begin
          #(1ns) vif.ack = 0; 
        end
      join 

    end

  endtask: recv_req

endclass: lc_driver
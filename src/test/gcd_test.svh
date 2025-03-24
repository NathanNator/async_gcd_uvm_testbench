class gcd_test extends gcd_test_base;
  `uvm_component_utils(gcd_test)

  int num_of_interations = 1000;

  function new(string name = "gcd_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  task run_phase(uvm_phase phase);

    // Create and instantiate the sequence
    gcd_write_seq write_seq = gcd_write_seq::type_id::create("write_seq");
    
    phase.raise_objection (this);

    for(int i = 0; i < num_of_interations; i++) begin
      write_seq.start(env.lc_in_tx_agent.sequencer);
    end 

    phase.phase_done.set_drain_time(this, 30000ns);
    phase.drop_objection (this);

  endtask

endclass : gcd_test
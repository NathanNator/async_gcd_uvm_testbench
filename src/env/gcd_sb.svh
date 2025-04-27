//------------------------------------------------------------------------------
// CLASS: gcd_sb
//------------------------------------------------------------------------------
class gcd_sb extends uvm_scoreboard;
  `uvm_component_utils(gcd_sb)

  typedef lc_sequence_item #(OUTPUT_DATA_WIDTH) lc_sequence_item_out_t; 

  uvm_tlm_analysis_fifo #(lc_sequence_item_out_t) acutal_gcd_out_af;  
  uvm_tlm_analysis_fifo #(lc_sequence_item_out_t) expected_gcd_out_af;  

  local int compare_count = 0; 

  // constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction: new

  // build_phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    acutal_gcd_out_af = new ("acutal_gcd_out_af", this);
    expected_gcd_out_af = new ("expected_gcd_out_af", this);

  endfunction: build_phase

  // run_phase
  virtual task run_phase (uvm_phase phase);
    super.run_phase (phase);
    
    fork 
      process_outputs();
    join
  
  endtask: run_phase

  // check_phase
  virtual function void check_phase(uvm_phase phase);

    if(!acutal_gcd_out_af.is_empty)
      `uvm_error (get_type_name(), $sformatf ("%s is not empty", acutal_gcd_out_af.get_name()))

    if(!expected_gcd_out_af.is_empty)
      `uvm_error (get_type_name(), $sformatf ("%s is not empty", expected_gcd_out_af.get_name()))


  endfunction: check_phase

  virtual task process_outputs();

    lc_sequence_item expected_output_item;
    lc_sequence_item acutal_output_item; 

    forever begin
      
      fork
        expected_gcd_out_af.get(acutal_output_item);
        acutal_gcd_out_af.get(expected_output_item);        
      join 

      if(expected_output_item.data != acutal_output_item.data) begin
        `uvm_error(get_type_name(), $sformatf("%0d does not match %0d", expected_output_item.data, acutal_output_item.data));
      end 
      else begin 
        $display("************************************");
        `uvm_info(get_type_name(), $sformatf ("GCD Output Match. Compare Count: %0d", ++compare_count), UVM_DEBUG)
        $display("GCD Output Match. Compare Count: %0d", ++compare_count);
        $display("************************************");
      end 
      
    end 

  endtask: process_outputs

endclass: gcd_sb
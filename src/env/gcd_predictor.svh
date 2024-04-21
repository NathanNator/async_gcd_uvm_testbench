//------------------------------------------------------------------------------
// CLASS: gcd_predictor
//------------------------------------------------------------------------------
class gcd_predictor extends uvm_component;
  `uvm_component_utils(gcd_predictor)

  typedef lc_sequence_item #(.D_WIDTH(INPUT_DATA_WIDTH)) lc_sequence_input_item_t;
  typedef lc_sequence_item #(.D_WIDTH(OUTPUT_DATA_WIDTH)) lc_sequence_output_item_t;

  uvm_tlm_analysis_fifo#(lc_sequence_input_item_t) acutal_ab_in_af; 

  uvm_analysis_port #(lc_sequence_output_item_t) expected_gcd_out_ap;

  // constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction: new

  // build_phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    acutal_ab_in_af = new ("acutal_ab_in_af", this);
    expected_gcd_out_ap = new ("expected_gcd_out_ap", this);

  endfunction: build_phase

  // run_phase
  virtual task run_phase (uvm_phase phase);
		super.run_phase (phase);
    
    fork 
      process_inputs();
    join_none
  
  endtask: run_phase

  // check_phase
  virtual function void check_phase(uvm_phase phase);

    if(!acutal_ab_in_af.is_empty)
      `uvm_error (get_type_name(), $sformatf ("%s is not empty", acutal_ab_in_af.get_name()))

  endfunction: check_phase

  task process_inputs();

    lc_sequence_input_item_t actual_item;
    lc_sequence_output_item_t expected_item;

    forever begin

      actual_item = lc_sequence_input_item_t::type_id::create("actual_item");
      expected_item = lc_sequence_output_item_t::type_id::create("expected_item");

      acutal_ab_in_af.get(actual_item);

      GCD(.a(actual_item.data[INPUT_DATA_WIDTH-1:DATA_WIDTH]), 
          .b(actual_item.data[DATA_WIDTH-1:0]), 
          .gcd(expected_item.data));

      expected_gcd_out_ap.write(expected_item);

    end 

  endtask: process_inputs

  task GCD(input longint a, input longint b, output longint gcd);

    while(a != b) begin
      if(a > b)
        a = a - b; 
      else 
        b = b - a;
    end 

    gcd = a; 

  endtask: GCD

endclass: gcd_predictor
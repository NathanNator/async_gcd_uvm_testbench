`uvm_analysis_imp_decl (_in)
`uvm_analysis_imp_decl (_out)

//------------------------------------------------------------------------------
// CLASS: gcd_coverage_collector
//------------------------------------------------------------------------------
class gcd_coverage_collector extends uvm_component;
  `uvm_component_utils(gcd_coverage_collector)
  
  typedef lc_sequence_item #(INPUT_DATA_WIDTH) lc_sequence_item_in_t; 
  typedef lc_sequence_item #(OUTPUT_DATA_WIDTH) lc_sequence_item_out_t; 

  uvm_analysis_imp_in #(lc_sequence_item_in_t, gcd_coverage_collector) analysis_export_in;
  uvm_analysis_imp_out #(lc_sequence_item_out_t, gcd_coverage_collector) analysis_export_out;

  lc_sequence_item_in_t input_item;
  lc_sequence_item_out_t output_item;

  covergroup cg_dut_inputs_a;
    INPUT_A: coverpoint input_item.data[INPUT_DATA_WIDTH-1:DATA_WIDTH];
  endgroup 

  covergroup cg_dut_inputs_b;
    INPUT_B: coverpoint input_item.data[DATA_WIDTH-1:0];
  endgroup 

  covergroup cg_dut_outputs;
    OUTPUT: coverpoint output_item.data{
      bins GCD_01_to_10 = {[1:10]};
      bins GCD_11_to_20 = {[11:20]};
      bins GCD_21_to_30 = {[21:30]};
      bins GCD_31_to_40 = {[31:40]};
      bins GCD_41_to_50 = {[41:50]};
      bins GCD_51_to_60 = {[51:60]};
      bins GCD_61_to_70 = {[61:70]};
      bins GCD_71_to_80 = {[71:80]};
      bins GCD_81_to_80 = {[81:90]};
      bins GCD_91_to_100 = {[91:100]};
      ignore_bins other = {[100:$]};
    }
  endgroup 

  // constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);

    cg_dut_inputs_a = new();
    cg_dut_inputs_b = new();
    cg_dut_outputs = new();
    
  endfunction: new

  // build_phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    analysis_export_in = new("analysis_export_in", this);
    analysis_export_out = new("analysis_export_out", this);

  endfunction: build_phase

  virtual function void write_in(lc_sequence_item_in_t input_item);
    this.input_item = input_item;
    cg_dut_inputs_a.sample();
    cg_dut_inputs_b.sample();
  endfunction
  
  virtual function void write_out(lc_sequence_item_out_t output_item);
    this.output_item = output_item;
    cg_dut_outputs.sample();
  endfunction

endclass: gcd_coverage_collector
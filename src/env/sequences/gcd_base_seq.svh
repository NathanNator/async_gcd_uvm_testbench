//------------------------------------------------------------------------------
// CLASS: gcd_base_seq
//------------------------------------------------------------------------------
class gcd_base_seq extends uvm_sequence #(lc_sequence_item #(INPUT_DATA_WIDTH));
  `uvm_object_utils (gcd_base_seq)

  // This is standard code for all components
  function new (string name = "gcd_base_seq");
    super.new(name);
  endfunction: new

endclass
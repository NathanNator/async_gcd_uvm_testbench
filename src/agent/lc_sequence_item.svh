//------------------------------------------------------------------------------
// CLASS: lc_sequence_item
//------------------------------------------------------------------------------
class lc_sequence_item #(int D_WIDTH=32) extends uvm_sequence_item;
  `uvm_object_param_utils(lc_sequence_item #(D_WIDTH))

  rand bit [D_WIDTH-1:0] data;

  // constructor
  function new(string name = "lc_sequence_item");
    super.new(name);
  endfunction: new
  
endclass

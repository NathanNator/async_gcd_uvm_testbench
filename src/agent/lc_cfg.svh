//------------------------------------------------------------------------------
// CLASS: lc_cfg
//------------------------------------------------------------------------------
class lc_cfg #(parameter D_WIDTH=32) extends uvm_object;
  `uvm_object_param_utils(lc_cfg #(D_WIDTH))

  // Virtual Interfaces
  virtual lc_if #(D_WIDTH) vif;

  uvm_active_passive_enum active = UVM_ACTIVE;

  bit is_send_req; 

  // constructor
  function new(string name = "lc_cfg");
    super.new(name);
  endfunction: new

endclass: lc_cfg
    

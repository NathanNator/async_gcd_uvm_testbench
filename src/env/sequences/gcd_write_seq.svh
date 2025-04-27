//------------------------------------------------------------------------------
// CLASS: gcd_write_seq
//------------------------------------------------------------------------------
class gcd_write_seq extends gcd_base_seq;
  `uvm_object_utils (gcd_write_seq)

  typedef lc_sequence_item #(INPUT_DATA_WIDTH) lc_sequence_item_t;

  // This is standard code for all components
  function new (string name = "gcd_write_seq");
    super.new (name);
  endfunction: new

  virtual task body();
    
    lc_sequence_item_t input_seq_item = lc_sequence_item_t::type_id::create("input_seq_item");
    
    wait_for_grant();                      //wait for grant
    assert(input_seq_item.randomize());    //randomize the req               
    send_request(input_seq_item);          //send req to driver
    wait_for_item_done();                  //wait for item done from driver

  endtask: body

endclass
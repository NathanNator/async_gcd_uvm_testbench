//------------------------------------------------------------------------------
// CLASS: gcd_env_cfg
//------------------------------------------------------------------------------
class gcd_env_cfg extends uvm_object;
  `uvm_object_utils(gcd_env_cfg)

  typedef lc_cfg #(INPUT_DATA_WIDTH) lc_in_tx_cfg_t; 
  typedef lc_cfg #(OUTPUT_DATA_WIDTH) lc_out_rx_cfg_t; 

  typedef virtual lc_if #(INPUT_DATA_WIDTH) lc_in_if_t; 
  typedef virtual lc_if #(OUTPUT_DATA_WIDTH) lc_out_if_t; 

  lc_in_tx_cfg_t lc_in_tx_cfg;
  lc_out_rx_cfg_t lc_out_rx_cfg;

  lc_in_if_t lc_in_vif;
  lc_out_if_t lc_out_vif;

  bit has_scoreboard = 1;

  // constructor
  function new(string name = "gcd_env_cfg");
    super.new(name);
  endfunction: new

  function void init_cfg(uvm_active_passive_enum active=UVM_ACTIVE);

    lc_in_tx_cfg = lc_in_tx_cfg_t::type_id::create("lc_in_tx_cfg");
    lc_out_rx_cfg = lc_out_rx_cfg_t::type_id::create("lc_out_rx_cfg_t");

    if (!uvm_config_db #(lc_in_if_t)::get(null, "", "lc_in_vif", lc_in_vif)) begin
      `uvm_error (get_type_name (), "lc_in_tx_cfg interface not found")
    end
    lc_in_tx_cfg.vif = lc_in_vif;

    if (!uvm_config_db #(lc_out_if_t)::get(null, "", "lc_out_vif", lc_out_vif)) begin
      `uvm_error (get_type_name (), "lc_out_rx_cfg interface not found")
    end
    lc_out_rx_cfg.vif = lc_out_vif;

    lc_in_tx_cfg.is_send_req = 1;
    lc_in_tx_cfg.active = active;

    lc_out_rx_cfg.is_send_req = 0;
    lc_out_rx_cfg.active = active;

  endfunction: init_cfg


endclass: gcd_env_cfg
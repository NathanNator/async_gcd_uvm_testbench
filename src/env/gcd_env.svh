class gcd_env extends uvm_env;
  `uvm_component_utils(gcd_env)

  typedef lc_agent #(INPUT_DATA_WIDTH) lc_input_tx_agent_t;
  typedef lc_agent #(OUTPUT_DATA_WIDTH) lc_output_agent_t;
    
  gcd_env_cfg env_cfg; 

  lc_input_tx_agent_t lc_in_tx_agent;
  lc_output_agent_t lc_out_rx_agent;
  
  gcd_predictor predictor; 

  gcd_sb sb; 

  // new - constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction: new

  // build_phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(env_cfg == null) begin 
      if (! uvm_config_db #(gcd_env_cfg) :: get (this, "", "gcd_env_cfg", env_cfg)) begin
        `uvm_error (get_type_name (), "gcd_env_cfg not found")
      end
    end 

    lc_in_tx_agent = lc_input_tx_agent_t::type_id::create("lc_in_tx_agent", this);
    lc_in_tx_agent.cfg = env_cfg.lc_in_tx_cfg;

    lc_out_rx_agent = lc_output_agent_t::type_id::create("lc_out_rx_agent", this);
    lc_out_rx_agent.cfg = env_cfg.lc_out_rx_cfg;

    if(env_cfg.has_scoreboard) begin 
      predictor = gcd_predictor::type_id::create("predictor", this);
      sb = gcd_sb::type_id::create("sb", this);
    end 

  endfunction: build_phase

  // connect_phase
  virtual function void connect_phase (uvm_phase phase);

    // Connect between different environments, agents, analysis ports, and scoreboard here
    lc_in_tx_agent.ap.connect(predictor.acutal_ab_in_af.analysis_export);

    if(env_cfg.has_scoreboard) begin 
      predictor.expected_gcd_out_ap.connect(sb.expected_gcd_out_af.analysis_export);
      lc_out_rx_agent.ap.connect(sb.acutal_gcd_out_af.analysis_export);
    end 

  endfunction: connect_phase

  virtual function void end_of_elaboration_phase (uvm_phase phase);
    super.end_of_elaboration_phase(phase);

    lc_in_tx_agent.ap.debug_connected_to();
    lc_out_rx_agent.ap.debug_connected_to();

    if(env_cfg.has_scoreboard) begin 
      predictor.expected_gcd_out_ap.debug_connected_to();
      sb.expected_gcd_out_af.analysis_export.debug_provided_to();
      sb.acutal_gcd_out_af.analysis_export.debug_provided_to();
    end 
    
  endfunction: end_of_elaboration_phase

endclass: gcd_env
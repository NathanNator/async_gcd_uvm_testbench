interface lc_if #(parameter D_WIDTH=32);
  logic               rst; 
  logic               req;
  logic               ack;
  logic [D_WIDTH-1:0] data;
endinterface

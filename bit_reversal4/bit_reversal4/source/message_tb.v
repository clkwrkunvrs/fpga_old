module message_tb ();
   
  reg clk, rst;
  wire [7:0] tx_data;
  reg new_tx_data;
  reg tx_busy, new_rx_data;
  reg [7:0] rx_data;
  
  

 
   
 message_printer DUT (
    .clk(clk),
    .rst(rst),
    .tx_data(tx_data),
    .new_tx_data(new_tx_data),
    .tx_busy(tx_busy),
    .new_rx_data(new_rx_data),
    .rx_data(rx_data)
  );
   
   
  initial begin
    clk = 1'b0;
    rst = 1'b1;
    repeat(4) #10 clk = ~clk;
    rst = 1'b0;
    forever #10 clk = ~clk; // generate a clock
  end
  
  initial begin
		tx_busy = 0;
	 new_rx_data = 0;
	 rx_data = "0";
    @(negedge rst); begin
    new_rx_data = 1;
    rx_data = "0";
    end
    repeat(300) @(posedge clk); begin
    new_rx_data = 1;
    rx_data = "1";
    end
    repeat(300) @(posedge clk); begin
    
    new_rx_data = 1;
    rx_data = "1";
    end
    $finish;
    end
    
   
endmodule
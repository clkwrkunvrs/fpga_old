//version 2016-07-15
module message_printer (
    input clk,
    output [7:0] tx_data,
    output reg new_tx_data,
    input tx_busy,
	 input [7:0] rx_data,
	 input new_rx_data,
    input rst,
	 output state,
	 output [3:0] counter,
	 output bytes,
	 output [3:0] addr
    //need to have one register for output that has its value passed into it by another register

  );
    localparam STATE_SIZE = 1;
    localparam IDLE = 0,
    PRINT_MESSAGE = 1;
    //wire [23:0] bit_to_ram;
    reg byte_out_d, byte_out_q;
    //wire byte_out;

    //use counter in this module for incrementation in message_ram
    //assign counter = counter_q;
    //assign byte_out = byte_out_q;
    localparam MESSAGE_LEN = 10;
    reg state_d, state_q;
    reg [3:0] addr_d, addr_q;
    reg [3:0]counter_q, counter_d;
  assign state = state_q;
  assign counter = counter_q;
  assign bytes = byte_out_q;
  assign addr = addr_q;
message_ram message_ram1 (
  .clk(clk),
  .addr(addr_q),
  //connect the keyboard input of this module to the message_ram "byte_in"
  .byte_in(byte_out_q),
  .data(tx_data),
  .counter(counter),
  .new_rx_data(new_rx_data),
  .rst(rst)
  );


    always @(*) begin
	 if(new_rx_data && state_d == 0)
	 begin
			if (rx_data == "0")
			begin
				byte_out_d = 0;
				counter_d = counter_q + 1;
				//new_tx_data = 1;
			end

			else if(rx_data == "1")
			begin
				byte_out_d = 1;
				counter_d = counter_q + 1;
			end
			
			else
			begin
				byte_out_d = byte_out_q;
				counter_d = counter_q;
			end
	end

	//default values
	/*else
	begin
		//addr_d = addr_q;
		//state_d = state_q;
		new_tx_data = 1'b0;
	end*/
	end
	
	always @(counter_q) begin
	if (counter_d == 4'd8) state_d = 1'b1;
	else state_d = state_q;
	end
	
	always @(*) begin
	if (state_d && !tx_busy)
	begin
       new_tx_data = 1'b1;
	    addr_d = addr_q + 1'd1;

		  if (counter_q >= 10)
			counter_d = 4'd0;
		  else counter_d = counter_q;
		  
		  if (addr_q >= 10) begin
		  addr_d = 0;
		  //state_d = 0;
		  end
		  else begin 
		  addr_q = addr_q;
		  //state_d = state_q;
		  end
		end
	
	else
   begin
	//state_d = state_q;
	new_tx_data = 1'b0;
	addr_d = addr_q;
	end
	end
   

 assign bit_to_ram = byte_out_d;

  always @(posedge clk) begin
    if (rst) begin
      state_q <= 1'd0;
      counter_q <= 4'd0;
      byte_out_q <= 1'd0;
		addr_q <= 4'd0;
     end
     else begin
      state_q <= state_d;
      counter_q <= counter_d;
      byte_out_q <= byte_out_d;
      addr_q <= addr_d;
	 end
    end
endmodule

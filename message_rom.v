module message_rom (
    input clk,
    //keyboard input from message_printer module
    input [7:0] bits_in,
    input [3:0] addr,
    output [7:0] data
  );
 
  wire [7:0] rom_data [9:0];

  integer i = 0;

  reg [7:0] data_d, data_q;
 
  assign data = data_q;
 
  always @(*) begin
    if (addr > 4'd10)
      data_d = " ";
    else
    //assign bits to message_rom
      for (i = 0; i < 8; i = i + 1) begin
    assign rom_data[i] = bits_in[i];
      end
  //assign these at the end of the output    
  assign rom_data[8] = "\n";
  assign rom_data[9] = "\r";
 //not my code but theres a counter in message_printer that counts to 8 (i set the value of message length, perhaps it needs
 //to count to 10?
      data_d = rom_data[addr];
  end
 
  always @(posedge clk) begin
    data_q <= data_d;
  end
 
endmodule
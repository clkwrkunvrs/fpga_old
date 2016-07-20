//version 2016-07-04
module message_rom_7 (
    input clk,
    //keyboard input from message_printer module
    input [63:0] bits_in,
    input [3:0] addr,
    output [7:0] data
  );
//changed this to a 10-by-10 instead of 10-by-8 bc compiler kept flagging that line 41 ("assign rom_data[8]...") was out of range. strangely i didn't get that error for line 42.
  wire [7:0] rom_data [9:0];

//How can I verify that bits_in has been filled? maybe say if those bits are not null?
  
  
  assign rom_data[0] = bits_in[63:56];
  assign rom_data[1] = bits_in[55:48];
  assign rom_data[2] = bits_in[47:40];
  assign rom_data[3] = bits_in[39:32];
  assign rom_data[4] = bits_in[31:24];
  assign rom_data[5] = bits_in[23:16];
  assign rom_data[6] = bits_in[15:8];
  assign rom_data[7] = bits_in[7:0];
  assign rom_data[8] = "\n";
  assign rom_data[9] = "\r";
  


  reg [7:0] data_d, data_q;
  assign data = data_q;
  
  always @(*) begin
    if (addr > 4'd9)
      data_d = " ";
    else
      data_d = rom_data[addr];
  end
 
  always @(posedge clk) begin
    data_q <= data_d;
  end
 
endmodule
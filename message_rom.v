module message_rom (
    input clk,
    //keyboard input from message_printer module
    input [63:0] bits_in,
    input [3:0] addr,
    output [7:0] data
  );
 //changed this to a 10-by-10 instead of 10-by-8 bc compiler kept flagging that line 41 ("assign rom_data[8]...") was out of range. strangely i didn't get that error for line 42.
  wire [9:0] rom_data [0:9];
  integer m = 0;

//variable for for loop to rebuild the 8 by 9 array for keyboard input addresses
  genvar j, k;
//index to bits_to_rom (here the bits_in input)
  //genvar m = 0;

  reg [7:0] data_d, data_q;
  
  //message_printer message_printer (
  
 
  assign data = data_q; 
 
 //assign bits to rom_data
   
 /*generate
 //integer m;
 //assign m = 0;
    for (j = 0; j < 8; j = j + 1) begin:row
    for (k = 0; k < 8; k = k + 1) begin:column
     assign rom_data[j][k] = bits_in[m];
     //Verilog doesn't like this m assignment statement for some reason
     assign m = m + 1;
      end
      end
      endgenerate*/
      
  //alternative method to rebuild the 2d array into rom_data
  generate
  for (j = 0;j < 8; j = j + 1) begin:rebuild_array
  assign rom_data[j] = bits_in[8 * j + 7:8 * j];
  end
  endgenerate
  //assign these at the end of the output    
  assign rom_data[8][7:0] = "\n";
  assign rom_data[9][7:0] = "\r";
 
  always @(*) begin
    if (addr > 4'd9)
      data_d = " ";
    else

 //not my code but theres a counter in message_printer that counts to 8 (i set the value of message length, perhaps it needs
 //to count to 10?
      data_d = rom_data[addr];
  end
 
  always @(posedge clk) begin
    data_q <= data_d;
  end
 
endmodule
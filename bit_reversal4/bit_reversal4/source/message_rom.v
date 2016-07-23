//version 2016-07-15
module message_rom (
    input clk,
    //keyboard input from message_printer module
    input [63:0] bits_in,
    input [3:0] addr,
    input rst,
    output [7:0] data
  );
//changed this to a 10-by-10 instead of 10-by-8 bc compiler kept flagging that line 41 ("assign rom_data[8]...") was out of range. strangely i didn't get that error for line 42.
 // wire [7:0] rom_data_q [9:0];
  reg [7:0] rom_data_d [0:9];
  reg [7:0] rom_data_q [0:9];
  wire [7:0] rom_wire [0:9];
  //reg [7:0] rom_data_q [9:0];
  reg [3:0] ctr_d, ctr_q;
  reg [7:0] data_d, data_q;
  //reg [63:0] reverse_bits_d, reverse_bits_q;
  //reg [3:0] array_d, array_q;

//How can I verify that bits_in has been filled? maybe say if those bits are not null?
  //initial begin
   //rom_data_d[8] = "\n";
   //rom_data_d[9] = "\r";
  //reverse_bits_d[63:0] <= 64'd0;
  //end
  
  always @(bits_in or ctr_q) begin
  ctr_d = ctr_q + 1;
    rom_data_d[9] = "\r";
    rom_data_d[8] = "\n";
    rom_data_d[7] = rom_data_q[7];
    rom_data_d[6] = rom_data_q[6];
    rom_data_d[5] = rom_data_q[5];
    rom_data_d[4] = rom_data_q[4];
    rom_data_d[3] = rom_data_q[3];
    rom_data_d[2] = rom_data_q[2];
    rom_data_d[1] = rom_data_q[1];
    rom_data_d[0] = rom_data_q[0];
  rom_data_d[ctr_q] = bits_in[63 - 8 * ctr_q -: 8];
  
  /*  reverse_bits_d = reverse_bits_q;
    ctr_d = ctr_q + 1;
  reverse_bits_d[8 * ctr_q + 7 +: 8] = bits_in[63 - 8 * ctr_q +:8];
  //assign rom_data
  //assign rom_data_d[ctr_q] = bits_in[63 - 8 * ctr_q +:8];
  //assign rom_data[ctr_q] = bits_in[55:48];
  //assign rom_data[ctr_q] = bits_in[47:40];
  //assign rom_data[ctr_q] = bits_in[39:32];
  //assign rom_data[ctr_q] = bits_in[31:24];
  //assign rom_data[ctr_q] = bits_in[23:16];
  //assign rom_data[ctr_q] = bits_in[15:8];
  //assign rom_data[ctr_q] = bits_in[7:0];*/
  /*if ((reverse_bits[63] == 1'b1) || (reverse_bits[63] == 1'b0)) begin
  deassign reverse_bits;
  end*/
  //if (ctr_d == 4'd8) begin
    //deassign reverse_bits;
    //end
    ctr_d = (ctr_d == 4'd8) ? 0 : ctr_q;
    //if (ctr_d == 4'd8 ? ctr_d = 0 : ctr_d = ctr_q) 
     // end
  /*
  assign rom_data[0] = reverse_bits_d[7-:8];
  assign rom_data[1] = reverse_bits_d[15-:8];
  assign rom_data[2] = reverse_bits_d[23-:8];
  assign rom_data[3] = reverse_bits_d[31-:8];
  assign rom_data[4] = reverse_bits_d[39-:8];
  assign rom_data[5] = reverse_bits_d[47-:8];
  assign rom_data[6] = reverse_bits_d[55-:8];
  assign rom_data[7] = reverse_bits_d[63-:8];*/
 end
 
 assign rom_wire[0] = rom_data_q[0];
 assign rom_wire[1] = rom_data_q[1];
 assign rom_wire[2] = rom_data_q[2];
 assign rom_wire[3] = rom_data_q[3];
 assign rom_wire[4] = rom_data_q[4];
 assign rom_wire[5] = rom_data_q[5];
 assign rom_wire[6] = rom_data_q[6];
 assign rom_wire[7] = rom_data_q[7];
 assign rom_wire[8] = rom_data_q[8];
 assign rom_wire[9] = rom_data_q[9]; 
  assign data = data_q;
  
  always @(*) begin
    if (addr > 4'd9)
      data_d = " ";
    else
      data_d = rom_wire[addr];
  end
 
  always @(posedge clk) begin : test
    if (rst) begin
    data_q <= 4'd0;
    ctr_q <= 4'd0;
   // reverse_bits_q <= 63'd0;
   rom_data_q[9] <= 8'd0;
   rom_data_q[8] <= 8'd0;
   rom_data_q[7] <= 8'd0;
   rom_data_q[6] <= 8'd0;
   rom_data_q[5] <= 8'd0;
   rom_data_q[4] <= 8'd0;
   rom_data_q[3] <= 8'd0;
   rom_data_q[2] <= 8'd0;
   rom_data_q[1] <= 8'd0;
   rom_data_q[0] <= 8'd0;
    end
    else begin
    rom_data_q[9] <= rom_data_d[9];
    rom_data_q[8] <= rom_data_d[8];
    rom_data_q[7] <= rom_data_d[7];
    rom_data_q[6] <= rom_data_d[6];
    rom_data_q[5] <= rom_data_d[5];
    rom_data_q[4] <= rom_data_d[4];
    rom_data_q[3] <= rom_data_d[3];
    rom_data_q[2] <= rom_data_d[2];
    rom_data_q[1] <= rom_data_d[1];
    rom_data_q[0] <= rom_data_d[0];
    data_q <= data_d;
    ctr_q <= ctr_d;
    //reverse_bits_q <= reverse_bits_d;
    end
  end
 
endmodule
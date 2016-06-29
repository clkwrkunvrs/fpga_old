module message_printer (
    input clk,
    input rst,
    output [7:0] tx_data,
    output reg new_tx_data,
    input tx_busy,
    input [7:0] rx_data,
    input new_rx_data,
    output reg [63:0] bit_to_rom
    //output [7:0] bit_to_rom
    
  );
    localparam STATE_SIZE = 1;
    localparam IDLE = 0,
    PRINT_MESSAGE = 1;
 
    localparam MESSAGE_LEN = 10; 
   //bits is the output to the message_rom module where the data is read to be output into 
  //reg [7:0] bits [7:0];
  //with alternative for implementation to build then flatten the array
    reg [7:0] bits [0:7];
    reg [7:0] bits_copy [0:7];
    reg [3:0] ctr_d, ctr_q;
    reg [STATE_SIZE-1:0] state_d, state_q;
    reg [3:0] addr_d, addr_q;  
  //counter_full determines when 8 bits have been input from keyboard
  //check verifies that keyboard input is a "1" or "0"  
    integer check = 0, counter_full = 0,
          i = 0, m = 0, l = 0, p = 0, q = 0;
  //variables to increment loop to "flatten" 'bits' and put it into bit_to_rom. j = row, k = column          
    genvar j, k;
 
  message_rom message_rom (
  .clk(clk),
  .addr(addr_q),
  //connect the keyboard input of this module to the message_rom "bi
  .bits_in(bit_to_rom),
  .data(tx_data)
  );
 
    always @(*) begin
    state_d = state_q; // default values
    addr_d = addr_q;   // needed to prevent latches
    new_tx_data = 1'b0;
 
    case (state_q)
      IDLE: begin
        addr_d = 4'd0;
        
    // *****MY CODE*****  //    
    //bc this in in an always@ * block, there may be timing issues
    if (counter_full == 0)  begin
    
    //if a "1" or "0" is typed in the keybaord, set check to true;
    if(new_rx_data && rx_data == "0") check = 1;
    else if(new_rx_data && rx_data == "1") check = 1;
    else check = 0;
      
    //when check is true (keyboard input is 1 or 0), store keyboard input bit-by-bit in bit_d      
    if (check) begin 
      bits[i][7:0] = rx_data; 
      i = i + 1;
      ctr_d = ctr_q + 1'b1;
      end
     end  
    
    //after array reversal, change state to PRINT_MESSAGE and print the keyboard input in reverse order to gtkterm
        if (counter_full == 1) begin 
          state_d = PRINT_MESSAGE;
          //reset counter_full
          counter_full = 0;
      end
      end
      PRINT_MESSAGE: begin
        if (!tx_busy) begin
          new_tx_data = 1'b1;
          addr_d = addr_q + 1'b1;
          if (addr_q == MESSAGE_LEN-1)
            state_d = IDLE;
        end
      end
      default: state_d = IDLE;
    endcase
  end
 
  always @(posedge clk) begin
    if (rst) begin
      state_q <= IDLE;
      ctr_q <= 4'b0;
   
     end else begin
      state_q <= state_d;
      ctr_q <= ctr_d; 
      
      //if the counter is full, i.e. the keyboard has typed 8 1s and 0s, reverse the array then flatten it.  Also set counter_full to 1 and reset the counter. (I know that's counterintuitive but see the always @* block)
     if (ctr_d == 8) begin
     //reset the bit input counter
     ctr_q <= 4'b0;
      
    //*******REVERSE ARRAY BY COPYING IT INTO ANOTHER IN REVERSE ORDER
       for (p = 0; p < 8; p = p + 1) begin
        bits_copy[p] <= bits[7 - p];
      end
      
     
     //flatten the array
     for (q = 0; q < 8; q = q + 1) begin
       bit_to_rom[8 * q +: 8] = bits_copy[q];
       //when the array is flattened, set the input bit (actually byte since keyboard inputs come in 8 bits) counter to full
       if (q == 8) begin
         counter_full <= 1;
         end
       end
      /*this was an attempt to flatten the array but it gives me "p is not a constant" error bc you can't select a range or something like that.  It's bc of the ":".
      for (p = 0; p < 8; p = p + 1) begin
     bit_to_rom[(8 * p) + 7:8 * p] <= bits_copy[p];
    end*/
    //increment counter once more for sequential logic
      end
      end
     addr_q <= addr_d; 
      end
      /*if 8 bits have been accepted from the keyboard, reverse the array
  //Really it would be easy to not reverse the array and just output
  //the array in reverse order to gtkterm.  COMPILER SAID IT DOESN'T SUPPORT CONCURRENT AND NON-CONCURRENT OPS ON "bits"
    bits[0] <= bits[7];
    bits[1] <= bits[6];
    bits[2] <= bits[5];
    bits[3] <= bits[4];
    bits[4] <= bits[3];
    bits[5] <= bits[2];
    bits[6] <= bits[1];
    bits[7] <= bits[0];
    //bits[8] <= bits[1];
    //bits[9] <= bits[0];
    */

 
 /*haven't yet figured out how to reverse bits concurrently so i just copied the input bits into another array in reverse order
 //this is certainly not the most efficient method but i'm just trying to make things work at the moment   
 for (l = 0; l < 8; l = l + 1) begin
  // for (i = 7; i > - 1; i = i - 1) begin
    i = 7;
      bits_copy[l] = bits[i];
     i = i - 1;
  end
 
  //loop to flatten the array
    for (j = 0; j < 8; j = j + 1) begin
     bit_to_rom[8 * j + 7:8 * j] = bits_copy[j];
    end*/
   
    //now that array is reversed, increment counter_full once more to allow the state to change to PRINT_MESSAGE below
    //counter_full <= 2;      
 
    
 
 
 //flatten the array and prep it to be sent to message_rom
/* generate
  
  for (j = 0; j < 8; j = j + 1) begin
    for (k = 0; k < 8; k = k + 1) begin
    assign bit_to_rom[m] = bits[j][k];
    assign m = m + 1;
    end
    end
endgenerate */


 
endmodule


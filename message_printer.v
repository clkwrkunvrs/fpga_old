module message_printer (
    input clk,
    input rst,
    output [7:0] tx_data,
    output reg new_tx_data,
    input tx_busy,
    input [7:0] rx_data,
    input new_rx_data
    //output [7:0] bit_to_rom
    
  );
  
   //bits is the output to the message_rom module where the data is read to be output into 
  reg [7:0] bits [7:0];
  //counter to determine when 8 bits have been input from keyboard
  reg [3:0] ctr_d, ctr_q;
  reg [71:0] bit_to_rom;
  
  integer check = 0, counter_full = 0,
          i = 0, m = 0;
  //variables to increment loop to "flatten" 'bits' and put it into bit_to_rom. j = row, k = column          
  genvar j, k;
  

       
  localparam STATE_SIZE = 1;
  localparam IDLE = 0,
    PRINT_MESSAGE = 1;
 
  localparam MESSAGE_LEN = 10;
 
  reg [STATE_SIZE-1:0] state_d, state_q;
 
  reg [3:0] addr_d, addr_q;
 
  message_rom message_rom (
  .clk(clk),
  .addr(addr_q),
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
    if (counter_full != 1)  begin
    
    //if a "1" or "0" is typed in the keybaord, set check to true;
    if(rx_data == "0") 
      check = 1;
    else if(rx_data == "1")
      check = 1;
    else
      check = 0;
      
    //when check is true (keyboard input is 1 or 0), store keyboard input bit-by-bit in bit_d      
    if (check) 
      bits[i][7:0] = rx_data; 
      i = i + 1;
      ctr_d = ctr_q + 1'b1;


      
    //counter to determine 8 inputs have been entered
    if (ctr_d == 8)
      counter_full = 1;
      end    
      //***my code end***//
        
    //If the counter is full, reverse the array first    
        if (counter_full) begin
  //if 8 bits have been accepted from the keyboard, reverse the array
  //Really it would be easy to not reverse the array and just output
  //the array in reverse order to gtkterm.
    bits[0] <= bits[9];
    bits[1] <= bits[8];
    bits[2] <= bits[7];
    bits[3] <= bits[6];
    bits[4] <= bits[5];
    bits[5] <= bits[4];
    bits[6] <= bits[3];
    bits[7] <= bits[2];
    bits[8] <= bits[1];
    bits[9] <= bits[0];
    
    //now that array is reversed, increment counter_full once more to allow the state to change to PRINT_MESSAGE below
    counter_full <= 2;      
    end
    
    //after array reversal, change state to PRINT_MESSAGE
        if (counter_full == 2) 
          state_d = PRINT_MESSAGE;
          //reset counter_full
          counter_full = 0;
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
    end
 
    addr_q <= addr_d;
 
      end

//flatten the array and prep it to be sent to message_rom
 generate
  
  for (j = 0; j < 8; j = j + 1) begin
    for (k = 0; k < 8; k = k + 1) begin
    assign bit_to_rom[m] = bits[j][k];
    assign m = m + 1;
    end
    end
endgenerate
 
endmodule


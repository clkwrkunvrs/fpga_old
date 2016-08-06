//version 2016-07-15
module message_printer (
    input clk,
    output [7:0] tx_data,
    output reg new_tx_data,
    input tx_busy,
    input [7:0] rx_data,
    input new_rx_data,
    input rst
    //need to have one register for output that has its value passed into it by another register
   
  );
    localparam STATE_SIZE = 1;
    localparam IDLE = 0,
    PRINT_MESSAGE = 1;
    wire [23:0] bit_to_rom;
    reg [23:0] bit_to_rom_d, bit_to_rom_q;
    
 
    localparam MESSAGE_LEN = 5; 
    reg [STATE_SIZE-1:0] state_d, state_q;
    reg [2:0] addr_d, addr_q;  
    reg [1:0]counter_q, counter_d;
     
  message_rom message_rom (
  .clk(clk),
  .addr(addr_q),
  //connect the keyboard input of this module to the message_rom "bits_in"
  .bits_in(bit_to_rom),
  .data(tx_data)
  );
  
 
    always @(*) begin
    state_d = state_q; // default values
    addr_d = addr_q;   // needed to prevent latches
    new_tx_data = 1'b0;
    bit_to_rom_d = bit_to_rom_q;
    counter_d = counter_q;
 
    case (state_q)
    //What puts the state into IDLE in the first place?
      IDLE: begin
        addr_d = 4'd0;
        
       
       
    //if a "1" or "0" is typed in the keybaord, assign the input to bit_to_rom
    if(new_rx_data && rx_data == "0") begin
     //default
    //bit_to_rom_d = bit_to_rom_q;
    //send this byte to rom
    bit_to_rom_d[8 * counter_q + 7-:8] = "0";
    counter_d = counter_q + 1'b1;
    end        
    
    else if(new_rx_data && rx_data == "1") begin
    //default
    //bit_to_rom_d = bit_to_rom_q;
    //send this byte to rom
    bit_to_rom_d[8 * counter_q + 7-:8] = "1";
    counter_d = counter_q + 1'b1;
    end
    
    else begin
      bit_to_rom_d = bit_to_rom_q;
      counter_d = counter_q;
    end
    
    if(counter_d == 2'd3) begin
     state_d = PRINT_MESSAGE;
     counter_d = 2'd0;
     end
     else begin
     state_d = IDLE;
     counter_d = counter_q;
     end
      end
      
      PRINT_MESSAGE: begin
        if (!tx_busy) begin
          //bit_to_rom_d = bit_to_rom_q;
          //counter_d = counter_q;
          new_tx_data = 1'b1;
          addr_d = addr_q + 1'b1;
          if (addr_q == MESSAGE_LEN-1) begin
            state_d = IDLE;
            end
         //else begin
          //bit_to_rom_d = bit_to_rom_q;
          //counter_d = counter_q;
          //end   
        end
      end
      
      default: begin
      state_d = IDLE;
      //bit_to_rom_d = bit_to_rom_q;
      //counter_d = counter_q;
      end
      
    endcase
  end
 
 assign bit_to_rom = bit_to_rom_d;
 
  always @(posedge clk) begin
    if (rst) begin
      state_q <= IDLE;
      counter_q <= 2'd0;
      bit_to_rom_q <= 23'd0;
     end 
     else begin
      state_q <= state_d;
      counter_q <= counter_d;
      bit_to_rom_q <= bit_to_rom_d;
      end
     addr_q <= addr_d; 
    end
endmodule


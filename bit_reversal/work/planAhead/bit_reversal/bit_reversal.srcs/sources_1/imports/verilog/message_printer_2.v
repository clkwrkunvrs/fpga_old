//version 2016-07-04
module message_printer_2 (
    input clk,
    input rst,
    output [7:0] tx_data,
    output reg new_tx_data,
    input tx_busy,
    input [7:0] rx_data,
    input new_rx_data,
    output reg [63:0] bit_to_rom
  );
    localparam STATE_SIZE = 1;
    localparam IDLE = 0,
    PRINT_MESSAGE = 1;
 
    localparam MESSAGE_LEN = 10; 
    reg [STATE_SIZE-1:0] state_d, state_q;
    reg [3:0] addr_d, addr_q;  
    integer counter = 0;
 
  message_rom_7 message_rom (
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
 
    case (state_q)
    //What puts the state into IDLE in the first place?
      IDLE: begin
        addr_d = 4'd0;
    //if a "1" or "0" is typed in the keybaord, assign the input to bit_to_rom
    if(new_rx_data && rx_data == "0") begin
    bit_to_rom[8 * counter + 7:counter * 8] = "0";
    counter = counter + 1;
    new_rx_data = 0;
    end
    else if(new_rx_data && rx_data == "1") begin
    bit_to_rom[8 * counter + 7:counter * 8] = "1";
    counter = counter + 1;
    new_rx_data = 0;
    end
    if(counter == 8) begin
     state_d = PRINT_MESSAGE;
     counter = 0;
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
   
     end else begin
      state_q <= state_d;

      end
     addr_q <= addr_d; 
    end
endmodule


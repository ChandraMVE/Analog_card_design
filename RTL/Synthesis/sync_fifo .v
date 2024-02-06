module sync_fifo( 
   input clk,
   input rst_n,
   input write_en,
   input [15:0] data_in,
   output full_o,
   input read_en,
   output reg [15:0] data_out,
   output empty_o);                     // Initialization of inputs and outputs

 parameter depth=15;                    
 reg [15:0] mem [0:depth-1];
 reg [3:0] wr_ptr;
 reg [3:0] rd_ptr;
 reg [4:0] count;                      // Initialization of registers

assign full_o= (count==depth);         // assigning the full_o, after writing all data inputs to memory full_o signal becomes high
assign empty_o= (count==0);            // assigning the empty_o, after reading all data inputs from the memory emty_o signal becomes high   

//-----------Handle with write process----------//

always@(posedge clk or negedge rst_n) begin
  if (!rst_n) begin                         // if rst_n=0 , write pointer=0   
   wr_ptr <=4'd0;                            
    end  else begin
     if(write_en==1)								// if write_en=1, 16 bit data starts to writing in to the memory bit by bit 
       begin
     mem [wr_ptr] <= data_in;
     wr_ptr <= wr_ptr+1;
     end
  end 
end 

//-----------Handle with read process----------//

always@(posedge clk or negedge rst_n) begin
  if (!rst_n) begin                // if rst_n=0. rd_ptr=0
   rd_ptr <=4'd0;      
    end  else begin
     if(read_en==1)               // if read_en=1 16 bit data starts to reading from the memory and fetching out through data_out   
       begin
     data_out <= mem[rd_ptr]; 
     rd_ptr <= rd_ptr+1;
     end
  end 
end 

//-----------Handle with count ----------//

always@(posedge clk or negedge rst_n) begin
  if (!rst_n) begin       // if rst_n=0. count=0
  count <= 5'd0;                 
   end else begin 
case ({write_en,read_en})  
2'b10: count <=count+1;      // when write_en=1, counter incremented by 1  from 0 to 15  
2'b01: count <= count-1;     // when read_en=1, counter decremented by 1 from 15 to 0  
2'b11: count <= count;       // when both write_en and read_en=1 counter=0
2'b00: count <= count;       // when both write_en and read_en=0 counter=0
default: count <=count;      
endcase

  end

end
endmodule                   // end of the program 




 

   



  `timescale 1ns / 1ps

  `define clk_period 10

module sync_fifo_tb;
reg clk, rst_n;
reg write_en, read_en;
reg [15:0] data_in;
wire [15:0] data_out;
wire full_o, empty_o;

sync_fifo F1 (.clk(clk), 
	       .rst_n(rst_n), 
	       .write_en(write_en),
      	       .read_en(read_en),
               .data_in(data_in),
               .data_out(data_out),
               .full_o(full_o),
	       .empty_o(empty_o));
     
       initial clk=1'b1;
       always #(`clk_period/2) clk=~clk;
       integer i;
       initial begin
        rst_n=1'b1;
        write_en=1'b0;
        read_en=1'b0;
        data_in=16'd0;
     
 # (`clk_period);		//reset system
   rst_n=1'b0;
 # (`clk_period);    		//  finish reset
    rst_n=1'b1;
       
//------write data-------//
write_en=1'b1;
read_en=1'b0;
for (i=0; i<16; i=i+1) begin 
 data_in=i;
 #(`clk_period);
 end

// ---read data -------//

write_en=1'b0;
read_en=1'b1;
for (i=0; i<16; i=i+1) begin 
  #(`clk_period);
   end

//------write data-------//
write_en=1'b1;
read_en=1'b0;
for (i=0; i<16; i=i+1) begin 
 data_in=i;
 #(`clk_period);
 end  
 #(`clk_period);
 #(`clk_period);
 #(`clk_period);
    $stop;
 end 
 endmodule 
        


  

 
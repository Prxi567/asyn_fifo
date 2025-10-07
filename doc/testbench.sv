
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "pkg.sv"
`include "a_interface.sv"
`include "design.sv"

module top;
  
  import uvm_pkg::*;  
  import pkg::*;
  
  bit wclk;
  bit rclk;
  bit rrst_n;
  bit wrst_n;
  
  always #5 wclk = ~wclk;
  always #10 rclk = ~rclk;
  
  initial begin 
    wclk = 0;
    rclk = 0;
    rrst_n = 0;
    wrst_n = 0;
    
    #10 rrst_n = 1;
    wrst_n = 1;
  end
  
  
  a_interface intf(wclk,rclk,wrst_n,rrst_n);
  
  FIFO dut( .rdata(intf.rdata),
           .wfull(intf.wfull),
           .rempty(intf.rempty),
           .wdata(intf.wdata),
           .winc(intf.winc),
           .wclk(wclk),
           .wrst_n(wrst_n),
           .rinc(intf.rinc),
           .rclk(rclk),
           .rrst_n(rrst_n));
  
  initial begin 
    uvm_config_db #(virtual a_interface)::set(null,"*","key",intf);
  end
  
  initial begin 
    run_test("test");
    #10000 $finish;
  end
endmodule

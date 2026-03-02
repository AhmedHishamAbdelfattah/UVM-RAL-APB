`timescale 1ns/1ps
`include "my_uvm_pkg.sv"   // Include your package file

import uvm_pkg::*;          // UVM library
import my_uvm_pkg::*;       // Your classes

module tb_new;

  // Instantiate interface
  top_if vif();

  // Instantiate DUT
  top dut (
    .pclk(vif.pclk),
    .presetn(vif.presetn),
    .paddr(vif.paddr),
    .pwdata(vif.pwdata),
    .psel(vif.psel),
    .pwrite(vif.pwrite),
    .penable(vif.penable),
    .prdata(vif.prdata)
  );

  // Clock generation
  initial vif.pclk = 0;
  always #10 vif.pclk = ~vif.pclk;

  // Run UVM test
  initial begin
    // Set interface in UVM config DB
    uvm_config_db#(virtual top_if)::set(null, "*", "vif", vif);

    // Run the test named "test" (must match class name in my_test.sv)
    run_test("test");
  end

endmodule
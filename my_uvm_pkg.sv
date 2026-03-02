package my_uvm_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  //  Base classes first
  `include "transaction.sv"
  `include "Reg_Block.sv"
  `include "my_sequence.sv"

  //  Components that depend on transaction
  `include "my_driver.sv"
  `include "my_monitor.sv"
  `include "my_scoreboard.sv"
  `include "my_agent.sv"
  `include "my_adapter.sv"

  //  Environment depends on everything above
  `include "my_env.sv"

  //  Test class
  `include "my_test.sv"

endpackage
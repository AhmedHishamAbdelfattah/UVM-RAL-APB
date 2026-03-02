// `include "uvm_macros.svh"
// import uvm_pkg::*;
 
///////////////////transaction class

class transaction extends uvm_sequence_item;
  `uvm_object_utils( transaction )
    rand    bit     [31 : 0]    paddr;
    rand    bit     [31 : 0]    pwdata;
            bit     [31 : 0]    prdata;
    rand    bit                 pwrite;
  
   
  
    function new(string name = "transaction");
       super.new(name);
    endfunction 
  
    constraint c_paddr { 
      paddr inside {0, 4, 8, 12, 16};
    }
 
endclass 

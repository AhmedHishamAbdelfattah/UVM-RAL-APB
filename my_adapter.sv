// `include "uvm_macros.svh"
// import uvm_pkg::*;

 class top_adapter extends uvm_reg_adapter;
  `uvm_object_utils (top_adapter)
 
  function new (string name = "top_adapter");
      super.new (name);
   endfunction
  
 // reg2bus function 
  function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
    transaction tr;    
    tr = transaction::type_id::create("tr");
    
    tr.pwrite    = (rw.kind == UVM_WRITE) ? 1'b1 : 1'b0;
    tr.paddr     = rw.addr;
    tr.pwdata    = rw.data;
 
    return tr;
  endfunction
 
 
 // bus2reg function  
  function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
    transaction tr;
    
    assert($cast(tr, bus_item));
 
    rw.kind = (tr.pwrite == 1'b1) ? UVM_WRITE : UVM_READ;
    rw.data = (tr.pwrite == 1'b1) ? tr.pwdata : tr.prdata;
    rw.addr = tr.paddr;
    rw.status = UVM_IS_OK;
  endfunction
  
endclass

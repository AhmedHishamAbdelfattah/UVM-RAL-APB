// `include "uvm_macros.svh"
// import uvm_pkg::*;

// `include "transaction.sv"

class sco extends uvm_scoreboard;
`uvm_component_utils(sco)
 
  uvm_analysis_imp#(transaction,sco) recv;
  bit [31:0] arr [17];
  bit [31:0] temp;
 
 
    function new(input string inst = "sco", uvm_component parent = null);
    super.new(inst,parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    recv = new("recv", this);
    endfunction
    
    
  virtual function void write(transaction tr);
    
    if(tr.pwrite == 1'b1)
      begin
        arr[tr.paddr] = tr.pwdata;
        `uvm_info("SCO", $sformatf("DATA Stored Addr : %0d Data :%0d", tr.paddr, tr.pwdata), UVM_NONE)
      end
    else
       begin
         
         temp = arr[tr.paddr];
         
         if( temp == tr.prdata)
           `uvm_info("SCO", $sformatf("Test Passed -> Addr : %0d Data :%0d", tr.paddr, temp), UVM_NONE)
         else
          `uvm_error("SCO", $sformatf("Test Failed -> Addr : %0d Data :%0d", tr.paddr, temp))
         
       end
       $display("----------------------------------------------------------------");
     
           
           
      endfunction
 
endclass      

// `include "uvm_macros.svh"
// import uvm_pkg::*;

// `include "transaction.sv"

class driver extends uvm_driver #(transaction);
    `uvm_component_utils(driver)
  
  
  virtual top_if vif;
  transaction tr;
  
  
  function new(string name = "driver", uvm_component parent = null);
        super.new(name, parent);
   endfunction  
  
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
      if(!uvm_config_db#(virtual top_if)::get(this, "", "vif", vif))
        `uvm_error("DRV", "Error getting Interface Handle")
    endfunction 
        
        /////write data to dut  -> psel -> pen 
        
    virtual task write();
        @(posedge vif.pclk);
        vif.paddr   <= tr.paddr;
        vif.pwdata  <= tr.pwdata;
        vif.pwrite  <= 1'b1;
        vif.psel    <= 1'b1;
        @(posedge vif.pclk);
        vif.penable <= 1'b1;
        `uvm_info("DRV", $sformatf("Mode : Write WDATA : %0d ADDR : %0d", vif.pwdata, vif.paddr), UVM_NONE);         
         @(posedge vif.pclk);
        vif.psel    <= 1'b0;
        vif.penable <= 1'b0;
    endtask 
      
     ////read data from dut 
    virtual task read();
        @(posedge vif.pclk);
        vif.paddr   <= tr.paddr;
        vif.pwrite  <= 1'b0;
        vif.psel    <= 1'b1;
        @(posedge vif.pclk);
        vif.penable <= 1'b1;
        `uvm_info("DRV", $sformatf("Mode : Read WDATA : %0d ADDR : %0d RDATA : %0d", vif.pwdata, vif.paddr, vif.prdata), UVM_NONE);
        @(posedge vif.pclk);
        vif.psel    <= 1'b0;
        vif.penable <= 1'b0;
        tr.prdata   = vif.prdata;
      
 
    endtask 
      
    /////////////////////////////////////////
      
    virtual task run_phase (uvm_phase phase);
        bit [31:0] data;
        vif.presetn <= 1'b1;
        vif.psel <= 0;
        vif.penable <= 0;
        vif.pwrite <= 0;
        vif.paddr <= 0;
        vif.pwdata <= 0;
        forever begin
          seq_item_port.get_next_item (tr);
          if (tr.pwrite)
            begin
               write();
            end
            else 
            begin   
               read();
            end
            seq_item_port.item_done ();
        end
    endtask  
      
  
  
endclass

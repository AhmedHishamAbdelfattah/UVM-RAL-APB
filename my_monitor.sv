// `include "uvm_macros.svh"
// import uvm_pkg::*;

// `include "transaction.sv"

class monitor extends uvm_monitor;
    `uvm_component_utils( monitor )
 
    uvm_analysis_port   #(transaction)  mon_ap;
    virtual     top_if              vif;
    
    function new(string name="my_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction : new
  
    virtual function void build_phase(uvm_phase phase);
        super.build_phase (phase);
        mon_ap = new("mon_ap", this);
      if(! uvm_config_db#(virtual top_if)::get (this, "", "vif", vif))
            `uvm_error("DRV", "Error getting Interface Handle")
    endfunction : build_phase
  
    virtual task run_phase(uvm_phase phase);
        fork
            forever begin
               @(posedge vif.pclk);
                if(vif.psel && vif.penable && vif.presetn) begin
                  transaction tr = transaction::type_id::create("tr");
                  tr.paddr  = vif.paddr;
                  tr.pwrite = vif.pwrite;
                    if (vif.pwrite)
                       begin
                        tr.pwdata = vif.pwdata;
                        @(posedge vif.pclk);
                        `uvm_info("MON", $sformatf("Mode : Write WDATA : %0d ADDR : %0d", vif.pwdata, vif.paddr), UVM_NONE);
                       end
                    else
                       begin
                         @(posedge vif.pclk);
                        tr.prdata = vif.prdata;
                        `uvm_info("MON", $sformatf("Mode : Write WDATA : %0d ADDR : %0d RDATA : %0d", vif.pwdata, vif.paddr, vif.prdata), UVM_NONE); 
                       end
                  mon_ap.write(tr);
                end 
            end
        join_none
    endtask 
 
endclass    

class test extends uvm_test;
  `uvm_component_utils(test)

  function new(input string inst = "test", uvm_component c);
    super.new(inst, c);
  endfunction

  // Environment
  env e;

  // Sequence
  reg_access_seq #(bit[31:0]) seqr;  // Single sequence object

  // Build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Build environment
    e = env::type_id::create("env", this);

    // Create sequence object
   seqr = reg_access_seq#(bit[31:0])::type_id::create("seqr");
  endfunction

  // Run phase
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    // Connect the sequence to the environment's register model
    seqr.regmodel = e.regmodel;

    // --------------------------
    // Example: write and read control register
    seqr.reg_name     = "cntrl";
    seqr.access_type  = "write";
    seqr.start(e.agent_inst.seqr);

    seqr.access_type  = "read";
    seqr.start(e.agent_inst.seqr);

    // --------------------------
    // Example: write and read reg1
    seqr.reg_name     = "reg1";
    seqr.access_type  = "write";
    seqr.start(e.agent_inst.seqr);

    seqr.access_type  = "read";
    seqr.start(e.agent_inst.seqr);

    // --------------------------
    // Example: write and read reg2
    seqr.reg_name     = "reg2";
    seqr.access_type  = "write";
    seqr.start(e.agent_inst.seqr);

    seqr.access_type  = "read";
    seqr.start(e.agent_inst.seqr);

    // --------------------------
    // Example: write and read reg3
    seqr.reg_name     = "reg3";
    seqr.access_type  = "write";
    seqr.start(e.agent_inst.seqr);

    seqr.access_type  = "read";
    seqr.start(e.agent_inst.seqr);

    // --------------------------
    // Example: write and read reg4
    seqr.reg_name     = "reg4";
    seqr.access_type  = "write";
    seqr.start(e.agent_inst.seqr);

    seqr.access_type  = "read";
    seqr.start(e.agent_inst.seqr);

    // Finish test
    phase.drop_objection(this);
  endtask

endclass      

class reg_access_seq #(type T=bit[31:0]) extends uvm_sequence#(uvm_sequence_item);

  `uvm_object_utils(reg_access_seq)

  // Reference to the register model
  reg_block regmodel;

  // Which register to access: "cntrl", "reg1", "reg2", ...
  string reg_name;

  // Access type: "read" or "write"
  string access_type;

  // Number of random transactions
  int num_transactions = 5;

  function new(string name="reg_access_seq");
    super.new(name);
  endfunction

  // Body of the sequence
  task body();
    uvm_status_e status;
    T data;

    for (int i=0; i<num_transactions; i++) begin
      if (access_type == "write") begin
        data = $urandom();
        case (reg_name)
          "cntrl":   regmodel.cntrl_inst.write(status, data);
          "reg1":    regmodel.reg1_inst.write(status, data);
          "reg2":    regmodel.reg2_inst.write(status, data);
          "reg3":    regmodel.reg3_inst.write(status, data);
          "reg4":    regmodel.reg4_inst.write(status, data);
          default:   `uvm_error("REG_SEQ","Unknown register name")
        endcase
      end
      else if (access_type == "read") begin
        case (reg_name)
          "cntrl":   regmodel.cntrl_inst.read(status, data);
          "reg1":    regmodel.reg1_inst.read(status, data);
          "reg2":    regmodel.reg2_inst.read(status, data);
          "reg3":    regmodel.reg3_inst.read(status, data);
          "reg4":    regmodel.reg4_inst.read(status, data);
          default:   `uvm_error("REG_SEQ","Unknown register name")
        endcase
      end
      else begin
        `uvm_error("REG_SEQ","Unknown access type")
      end
    end
  endtask

endclass

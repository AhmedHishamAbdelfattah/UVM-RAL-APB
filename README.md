## UVM RAL APB Verification Environment

A modular and reusable UVM-based testbench for APB peripherals

# Overview

This project implements a UVM Register Abstraction Layer (RAL) environment for an APB (Advanced Peripheral Bus) design.
It provides:

1. Full APB register modeling using UVM RAL.
2. Read/Write sequences for control and data registers.
3. Reusable and parameterized sequences for any register.
4. Drivers, monitors, agents, environment, and scoreboard.
5. Randomized testing for robust verification.

# 📂 Project Structure
UVM_RAL_APB/
├─ rtl/                 # APB DUT RTL
├─ tb/                  # Testbench sources
│  ├─ interfaces/       # top_if.sv
│  ├─ sequences/        # reg_access_seq.sv
│  ├─ drivers/          # my_driver.sv
│  ├─ monitors/         # my_monitor.sv
│  ├─ agents/           # my_agent.sv
│  ├─ adapters/         # my_adapter.sv
│  ├─ scoreboards/      # my_scoreboard.sv
│  ├─ environment/      # my_env.sv
│  └─ tests/            # my_test.sv
├─ sim/                 # Simulation scripts (run.do)
└─ README.md


## How to Run

# Compile package first:

1. vlog -sv tb/my_uvm_pkg.sv
2. vlog -sv tb/TestBench.sv

# Simulate and run test:

1. vsim tb_new
2. run_test("my_test");

Modular and reusable for new APB peripherals.

Fully adheres to UVM best practices.

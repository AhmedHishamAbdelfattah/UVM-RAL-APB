# UVM RAL APB Verification Environment

A modular and reusable UVM-based testbench for APB peripherals

## Overview

This project implements a UVM Register Abstraction Layer (RAL) environment for an APB (Advanced Peripheral Bus) design.
It provides:

1. Full APB register modeling using UVM RAL.
2. Read/Write sequences for control and data registers.
3. Reusable and parameterized sequences for any register.
4. Drivers, monitors, agents, environment, and scoreboard.
5. Randomized testing for robust verification.

## 📂 Project Structure
<img width="546" height="335" alt="image" src="https://github.com/user-attachments/assets/e3131e9d-e6f4-4b55-999b-a8e43e699580" />


## How to Run

## Compile package first:

1. vlog -sv tb/my_uvm_pkg.sv
2. vlog -sv tb/TestBench.sv

## Simulate and run test:

1. vsim tb_new
2. run_test("my_test");


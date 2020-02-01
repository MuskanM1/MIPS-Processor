# MIPS-Processor

## Table of contents
* [General info](#general-info)
* [Technologies](#technologies)
* [Summary](#Summary)


## General info
This project inclue Implementation of 16 bit MIPS processor that performs 28 different operations in Verilog language on Xilinx-ISE software and dumped on FPGA hardware.  

## Technologies 
Project is created with:
* Software: Xilinx-ISE
* Hardware Desciptive Language: Verilog
* Hardware : FPGA

## Summary
This project consisted of implmenting different blocks for different functions. Each folder includes a different functionality which is all integrated in 'MIPS Processor' block code. The descriptions of the blocks are listed below: 

* MIPS Processor: Main MIPS 16 bit processor which integrates all the blocks together.
* ALU : Execution Block performs 28 different ALU operations.
* Program Memory : Used in Instruction fetch stage that generate instructions for further blocks.
* Register Block : Generate Operands for the execution block.
* Data Memory Block : Generate data stored at the address coming from ALU.
* Stall Control Block : Used to stall the pipeline for one or two clock cycles. 
* Data Dependency Block : It handles data hazard in pipeline processor and checks data dependency between previous three instructions. 
* Jump Control Block : Used to generate jump location and mux control signal for program memory block.
* Write Back Block: Used to delay the answer coming from Data Memory block for one clock cycle. 


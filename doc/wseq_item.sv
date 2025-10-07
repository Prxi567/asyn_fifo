 `include "uvm_macros.svh"
  import uvm_pkg::*;

class wseq_item extends uvm_sequence_item;

  rand bit [7:0] wdata;
  rand bit winc;
  bit wfull;

  function new(string name = "wseq_item");
    super.new(name);
  endfunction 
  
  `uvm_object_utils_begin(wseq_item)
  `uvm_field_int(wdata,UVM_ALL_ON)
  `uvm_field_int(winc,UVM_ALL_ON)
  `uvm_field_int(wfull,UVM_ALL_ON) 
  `uvm_object_utils_end
  
endclass

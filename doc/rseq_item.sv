 `include "uvm_macros.svh"
  import uvm_pkg::*;
​
class rseq_item extends uvm_sequence_item;
​
  rand bit [7:0] rdata;
  rand bit rinc;
  bit rempty;
​
  function new(string name = "rseq_item");
    super.new(name);
  endfunction 
  
  `uvm_object_utils_begin(rseq_item)
  `uvm_field_int(rdata,UVM_ALL_ON)
  `uvm_field_int(rinc,UVM_ALL_ON)
  `uvm_field_int(rempty,UVM_ALL_ON) 
  `uvm_object_utils_end
  
endclass

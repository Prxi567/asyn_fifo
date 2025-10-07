class rseqr extends uvm_sequencer #(rseq_item);
  
  `uvm_component_utils(rseqr)
  
  function new(string name = "rseqr",uvm_component parent);
    super.new(name,parent);
  endfunction
endclass

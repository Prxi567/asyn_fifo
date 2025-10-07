class wseqr extends uvm_sequencer #(wseq_item);
  
  `uvm_component_utils(wseqr)
  
  function new(string name = "wseqr",uvm_component parent);
    super.new(name,parent);
  endfunction
endclass

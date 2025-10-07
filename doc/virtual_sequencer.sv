
class virtual_sequencer extends uvm_sequencer;
  
  `uvm_component_utils(virtual_sequencer)
  
  wseqr wr_seqr;
 rseqr rd_seqr;
  
  function new(string name = "virtual_sequencer", uvm_component parent);
    super.new(name, parent);
  endfunction 
  
endclass

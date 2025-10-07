class ragent extends uvm_agent;
  
  `uvm_component_utils(ragent)
  
   rseqr rd_seqr;
  rdrv rd_drv;
  rmon rd_mon;

  
  function new(string name = "wagent",uvm_component parent);
    super.new(name,parent);
  endfunction 
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(get_is_active() == UVM_ACTIVE) begin
      rd_seqr = rseqr::type_id::create("rd_seqr",this);
      rd_drv = rdrv::type_id::create("rd_drv",this);
    end
    rd_mon = rmon::type_id::create("mon",this);
  endfunction 
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if(get_is_active() == UVM_ACTIVE)
      rd_drv.seq_item_port.connect(rd_seqr.seq_item_export);
  endfunction
endclass

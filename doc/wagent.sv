class wagent extends uvm_agent;
  
  `uvm_component_utils(wagent)
  
  wseqr wr_seqr;
  wdrv wr_drv;
  wmon wr_mon;
  
  function new(string name = "wagent",uvm_component parent);
    super.new(name,parent);
  endfunction 
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(get_is_active() == UVM_ACTIVE) begin
    wr_seqr = wseqr::type_id::create("seqr",this);
    wr_drv = wdrv::type_id::create("srv",this);
    end
    wr_mon = wmon::type_id::create("mon",this);
  endfunction 
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if(get_is_active() == UVM_ACTIVE) begin
      wr_drv.seq_item_port.connect(wr_seqr.seq_item_export);
    end
  endfunction
endclass

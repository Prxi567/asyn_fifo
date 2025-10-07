class rdrv extends uvm_driver #(rseq_item);
  
  virtual a_interface.rd_drv vif;
  
  `uvm_component_utils(rdrv)
  
  function new(string name = "rdrv",uvm_component parent);
    super.new(name,parent);
  endfunction 
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual a_interface)::get(this,"","key",vif))
      `uvm_fatal("WRITE_DRIVER","!!!No virtual interface!!!");
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin 
      seq_item_port.get_next_item(req);
      drive();
      seq_item_port.item_done();
    end
  endtask
  
  task drive();
    @(posedge vif.rd_drv_cb)
    vif.rd_drv_cb.rinc <= req.rinc;
    `uvm_info("READ_DRIVER",$sformatf("Driving from read driver"),UVM_LOW);
    req.print();
  endtask
endclass

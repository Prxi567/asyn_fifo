class wdrv extends uvm_driver #(wseq_item);
  
  virtual a_interface.wr_drv vif;
  
  `uvm_component_utils(wdrv)
  
  function new(string name = "wdrv",uvm_component parent);
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
    @(posedge vif.wr_drv_cb)
    vif.wr_drv_cb.wdata <= req.wdata;
    vif.wr_drv_cb.winc <= req.winc;
    `uvm_info("WRITE_DRIVER",$sformatf("Driving from write driver"),UVM_LOW);
    req.print();
  endtask
endclass

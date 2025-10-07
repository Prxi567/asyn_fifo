class test extends uvm_test;
  
  `uvm_component_utils(test)
  
  environment env;
  virtual_sequence v_seq;
  
  function new(string name = "test", uvm_component parent);
    super.new(name,parent);
  endfunction 
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = environment::type_id::create("env",this);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    v_seq = virtual_sequence::type_id::create("v_seq");
    repeat(3) begin
      v_seq.start(env.v_seqr);
    end
    phase.drop_objection(this);
  endtask
endclass

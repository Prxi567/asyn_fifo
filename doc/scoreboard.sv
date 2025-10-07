class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)
  wseq_item write_seq;
  rseq_item  read_seq;
  uvm_tlm_analysis_fifo #(wseq_item) wr_scb_port;
  uvm_tlm_analysis_fifo #(rseq_item)  rd_scb_port;
  bit [7:0] q[$];  
  bit [7:0] exp; 
  int depth = 16;
 
  function new(string name = "scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   wr_scb_port = new("wr_scb_port", this);
    rd_scb_port = new("rd_scb_port", this);
  endfunction
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin 
      wr_scb_port.get(write_seq);
       rd_scb_port.get(read_seq);
      sco(write_seq, read_seq);
    end
  endtask
 
  task sco(wseq_item write,
           rseq_item read);
 
    if (write.winc) begin
      if (q.size() == depth) begin
        if (!write.wfull)
          `uvm_error("SCOREBOARD", "FIFO full but DUT did NOT assert wfull")
        else
          `uvm_info("SCOREBOARD", "WRITE blocked (FIFO full as expected)",
                    UVM_LOW);

      end
      else begin
      q.push_back(write.wdata);
      `uvm_info("SCOREBOARD",
                $sformatf("WRITE: Stored %0h (size=%0d)",
                          write.wdata, q.size()), UVM_MEDIUM);
      end
      end
 
    if (read.rinc) begin
      if (q.size() == 0) begin
        if (!read.rempty)
          `uvm_error("SCOREBOARD", "FIFO empty but DUT did NOT assert rempty")
        else
          `uvm_info("SCOREBOARD", "READ blocked (FIFO empty as expected)", UVM_LOW);
      end

        exp = q.pop_front();
        if (exp != read.rdata)
          `uvm_error("SCOREBOARD",
                     $sformatf("DATA MISMATCH: Expected %0h, Got %0h",
                               exp, read.rdata))
        else
          `uvm_info("SCOREBOARD",
                    $sformatf("match: Got %0h (size=%0d)",
                              read.rdata, q.size()), UVM_MEDIUM);

 
    end
  endtask
endclass

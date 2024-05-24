
class scr_sequencer extends uvm_sequencer # (scr_sequence_item);

    `uvm_component_utils(scr_sequencer)

    function new(string name = "scr_sequencer", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("scr_sequencer", "constructor", UVM_HIGH)
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("scr_sequencer", "build phase", UVM_HIGH)
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("scr_sequencer", "connect phase", UVM_HIGH)
    endfunction: connect_phase

endclass: scr_sequencer

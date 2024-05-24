
class scr_agent extends uvm_agent;

    `uvm_component_utils(scr_agent)

    scr_driver driver_h;
    scr_monitor monitor_h;
    scr_sequencer sequencer_h;

    virtual scr_if vif;

    uvm_analysis_port # (scr_sequence_item) scr_analysis_port;

    function new(string name = "scr_agent", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("scr_agent", "constructor", UVM_HIGH)
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("scr_agent", "build phase", UVM_HIGH)
        driver_h = scr_driver::type_id::create("driver_h", this);
        monitor_h = scr_monitor::type_id::create("monitor_h", this);
        sequencer_h = scr_sequencer::type_id::create("sequencer_h", this);
        if(!uvm_config_db # (virtual scr_if) :: get(this, "", "vif", vif)) begin
            `uvm_error("NOVIF", {"vif must be set for: ", get_full_name(), ".vif"});
        end
        uvm_config_db # (virtual scr_if) :: set(this, "driver_h", "vif", vif);
        uvm_config_db # (virtual scr_if) :: set(this, "monitor_h", "vif", vif);
        scr_analysis_port = new("scr_analysis_port", this);
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("scr_agent", "connect phase", UVM_HIGH)
        driver_h.seq_item_port.connect(sequencer_h.seq_item_export);
        monitor_h.scr_analysis_port.connect(scr_analysis_port);
    endfunction: connect_phase

endclass: scr_agent

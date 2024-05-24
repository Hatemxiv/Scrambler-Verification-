
class scr_monitor extends uvm_monitor;

    `uvm_component_utils(scr_monitor)

    scr_sequence_item sequence_item_h;

    virtual scr_if vif;

    uvm_analysis_port # (scr_sequence_item) scr_analysis_port;

    function new(string name = "scr_monitor", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("scr_monitor", "constructor", UVM_HIGH)
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("scr_monitor", "build phase", UVM_HIGH)
        sequence_item_h = scr_sequence_item::type_id::create("sequence_item_h");
        if(!uvm_config_db # (virtual scr_if) :: get(this, "", "vif", vif)) begin
            `uvm_error("NOVIF", {"vif must be set for: ", get_full_name(), ".vif"});
        end
        scr_analysis_port = new("scr_analysis_port", this);
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("scr_monitor", "connect phase", UVM_HIGH)
        scr_analysis_port.write(sequence_item_h);
    endfunction: connect_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("scr_monitor", "run phase", UVM_HIGH)
        forever begin
            monitor();  #1step 
        //    sequence_item_h.display_out("scr_monitor");
            scr_analysis_port.write(sequence_item_h);
        end
    endtask: run_phase

    task monitor;
        @ (negedge vif.clk ); #1step 
        sequence_item_h.reset_n <= vif.reset_n;
        sequence_item_h.initial_state <= vif.initial_state;
        sequence_item_h.in_bit <= vif.in_bit;
        sequence_item_h.en <= vif.en;
        sequence_item_h.out_bit <= vif.out_bit;
        sequence_item_h.scmb_en <= vif.scmb_en;
    endtask: monitor

endclass: scr_monitor


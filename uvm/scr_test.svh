
class scr_base_test extends uvm_test;

    `uvm_component_utils(scr_base_test)

    scr_env env_h;
    
    virtual scr_if vif;

    function new(string name = "scr_base_test", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("scr_base_test", "constructor", UVM_HIGH)
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("scr_base_test", "build phase", UVM_HIGH)
        env_h = scr_env::type_id::create("env_h", this);
        if(!uvm_config_db # (virtual scr_if) :: get(this, "", "vif", vif)) begin
            `uvm_error("NOVIF", {"vif must be set for: ", get_full_name(), ".vif"});
        end
        uvm_config_db # (virtual scr_if) :: set(this, "env_h", "vif", vif);
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("scr_base_test", "connect phase", UVM_HIGH)
    endfunction: connect_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("scr_base_test", "run phase", UVM_HIGH)
    endtask: run_phase

endclass: scr_base_test

class scr_Input_test extends scr_base_test;

    `uvm_component_utils(scr_Input_test)


    scr_Input_sequence Input_sequence_h;

    function new(string name = "scr_Input_test", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("scr_Input_test", "constructor", UVM_HIGH)
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("scr_Input_test", "build phase", UVM_HIGH)
        Input_sequence_h = scr_Input_sequence::type_id::create("Input_sequence_h");
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("scr_Input_test", "connect phase", UVM_HIGH)
    endfunction: connect_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("scr_Input_test", "run phase", UVM_HIGH)
        phase.raise_objection(this, "Starting Sequences");
        Input_sequence_h.start(env_h.agent_h.sequencer_h);
        phase.drop_objection(this, "Finished Sequences");
    endtask: run_phase

endclass: scr_Input_test

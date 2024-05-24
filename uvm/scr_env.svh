
class scr_env extends uvm_env;

    `uvm_component_utils(scr_env)

    scr_agent agent_h;
    scr_scoreboard scoreboard_h;

    virtual scr_if vif;
    
    function new(string name = "scr_env", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("scr_env", "constructor", UVM_HIGH)
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("scr_env", "build phase", UVM_HIGH)
        agent_h = scr_agent::type_id::create("agent_h", this);
        scoreboard_h = scr_scoreboard::type_id::create("scoreboard_h", this);
        if(!uvm_config_db # (virtual scr_if) :: get(this, "", "vif", vif)) begin
            `uvm_error("NOVIF", {"vif must be set for: ", get_full_name(), ".vif"});
        end
        uvm_config_db # (virtual scr_if) :: set(this, "agent_h", "vif", vif);
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("scr_env", "connect phase", UVM_HIGH)
       agent_h.scr_analysis_port.connect(scoreboard_h.scr_analysis_imp);
    endfunction: connect_phase

endclass: scr_env


class scr_driver extends uvm_driver # (scr_sequence_item);

    `uvm_component_utils(scr_driver)

    scr_sequence_item sequence_item_h;

    virtual scr_if vif;

    function new(string name = "scr_driver", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("scr_driver", "constructor", UVM_HIGH)
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("scr_driver", "build phase", UVM_HIGH)
        if(!uvm_config_db # (virtual scr_if) :: get(this, "", "vif", vif)) begin
            `uvm_error("NOVIF", {"vif must be set for: ", get_full_name(), ".vif"});
        end
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("scr_driver", "connect phase", UVM_HIGH)
    endfunction: connect_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("scr_driver", "run phase", UVM_HIGH)
        forever begin
            seq_item_port.get_next_item(sequence_item_h);
            sequence_item_h.display_in("scr_driver");
            drive();
            seq_item_port.item_done();
        end
    endtask: run_phase

    task drive;
        vif.reset_n <= sequence_item_h.reset_n;
        vif.en <= sequence_item_h.en;
        vif.initial_state <= sequence_item_h.initial_state;
        vif.in_bit <= sequence_item_h.in_bit;
        @ (negedge vif.clk);
    endtask: drive

endclass: scr_driver

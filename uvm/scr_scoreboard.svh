
class scr_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(scr_scoreboard)
    scr_sequence_item sequence_item_h;
    uvm_analysis_imp # (scr_sequence_item, scr_scoreboard) scr_analysis_imp;
    logic Out_vect[1:1504*50];
    task read();
        $readmemb("Output.txt",Out_vect);
    endtask 



    function new(string name = "scr_scoreboard", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("scr_scoreboard", "constructor", UVM_HIGH)
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("scr_scoreboard", "build phase", UVM_HIGH)
        sequence_item_h = scr_sequence_item::type_id::create("sequence_item_h");
        scr_analysis_imp = new("scr_analysis_imp", this);
        read(); // READ
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("scr_scoreboard", "connect phase", UVM_HIGH)
    endfunction: connect_phase
    int i=1; int j=1; int fcount=0;
    function void write(scr_sequence_item t); 
        sequence_item_h = t;
        $display("---------------------------------------------------------------------------------------------------------------------------------------");
        $display("");
       
        if (sequence_item_h.reset_n && sequence_item_h.scmb_en) begin
            sequence_item_h.display_out("scr_scoreboard");
                $display("\nTrue was %d, \nExpected %d ", sequence_item_h.out_bit ,Out_vect[i+(j-1)*1504]);
            if (sequence_item_h.out_bit!=Out_vect[i+(j-1)*1504]) begin 
                `uvm_error(  "scr_scoreboard",
                        $sformatf("\nWRONG OUTPUT!! - True:%b  Expected: %b", sequence_item_h.out_bit,Out_vect[i+(j-1)*1504]))
                        $display("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
               
            fcount++;
            end
            else $display("RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");

        i++;
        $display("Number of faults is: %d", fcount);
        if (i==1505) begin i=1; j++; 
        end
        end
    endfunction: write

endclass: scr_scoreboard

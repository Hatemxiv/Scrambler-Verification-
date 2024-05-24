
class scr_sequence_item extends uvm_sequence_item;

    `uvm_object_utils(scr_sequence_item)

    logic               reset_n;
    logic               [1:15] initial_state;
    logic               in_bit;
    logic               en;
    logic               out_bit;
    logic               scmb_en;

    function new(string name = "scr_sequence_item");
        super.new(name);
        `uvm_info(name, "constructor", UVM_HIGH)
    endfunction: new

    function void display_in(input string name = " ");
        $display("---------------------------------------------------------------------------------------------------------------------------------------");
        // `uvm_info(name,
        //           $sformatf("\nTested:\nreset = %b, initial_state = %h, Input = %b, en = %b",
        //           reset_n, initial_state, in_bit, en),
        //           UVM_HIGH);
    endfunction: display_in

    function void display_out(input string name = " ");
        $display("---------------------------------------------------------------------------------------------------------------------------------------");
        `uvm_info(name,
                  $sformatf("\nTested:\nreset = %b, initial_state = %h, \nInput = %b, en = %b, \noutput: %b, Scmb_en: %b",
                  reset_n, initial_state, in_bit, en, out_bit, scmb_en),
                  UVM_HIGH);
    endfunction: display_out

endclass: scr_sequence_item

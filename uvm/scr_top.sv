
`timescale 1ns/1ps

module scr_top;

    import uvm_pkg::*;
    import scr_pkg::*;

    scr_if intf();

    initial begin
        intf.clk = 1'b0;
        uvm_config_db#(virtual scr_if)::set(null, "uvm_test_top", "vif", intf);
        run_test();
    end

    always #1 intf.clk = ~intf.clk;

    BB_scrambler BB_scrambler_1 (
        .clk        (intf.clk),
        .reset_n      (intf.reset_n),
        .initial_state      (intf.initial_state),
        .in_bit    (intf.in_bit),
        .out_bit    (intf.out_bit),
        .scmb_en   (intf.scmb_en),
        .en   (intf.en)

    );

endmodule: scr_top




interface scr_if;

    logic               clk;
    logic               reset_n;
    logic               [1:15] initial_state;
    logic                in_bit;
    logic                en;
    logic                out_bit;
    logic               scmb_en;

endinterface: scr_if


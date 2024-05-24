
vlog \
-permissive \
-f compile_files.f

vsim \
-c \
-displaymsgmode both \
-onfinish stop \
-voptargs=+acc \
+UVM_TESTNAME=scr_Input_test \
+UVM_VERBOSITY=UVM_HIGH \
+UVM_NO_RELNOTES \
work.scr_top

add wave -position insertpoint  \
sim:/scr_top/BB_scrambler_1/clk \
sim:/scr_top/BB_scrambler_1/reset_n \
sim:/scr_top/BB_scrambler_1/initial_state \
sim:/scr_top/BB_scrambler_1/in_bit \
sim:/scr_top/BB_scrambler_1/en \
sim:/scr_top/BB_scrambler_1/out_bit \
sim:/scr_top/BB_scrambler_1/scmb_en

run -all

wave zoom full
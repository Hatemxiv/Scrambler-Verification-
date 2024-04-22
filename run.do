vsim -voptargs=+acc work.scrambler_tb 

add wave -position insertpoint  \
sim:/scrambler_tb/clk \
sim:/scrambler_tb/reset_n \
sim:/scrambler_tb/initial_state \
sim:/scrambler_tb/in_bit \
sim:/scrambler_tb/en \
sim:/scrambler_tb/out_bit \
sim:/scrambler_tb/scmb_en \
sim:/scrambler_tb/out_exp \
sim:/scrambler_tb/pck \
sim:/scrambler_tb/ch
run -all

# Set the working dir, where all compiled Verilog goes.
vlib work

vlog -timescale 1ns/1ns seven_to_one_multiplexer.v


vsim seven_to_one_multiplexer

log {/*}
add wave {/*}
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 0
force {SW[5]} 1
force {SW[6]} 0
force {SW[7]} 0 0, 1 20 -r 40
force {SW[8]} 0 0, 1 40 -r 80
force {SW[9]} 0 0, 1 80 -r 160
# Run simulation for a few ns.
run 160ns






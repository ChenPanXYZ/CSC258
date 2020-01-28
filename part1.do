# Set the working dir, where all compiled Verilog goes.
vlib work
vlog -timescale 1ns/1ns part1.v
vsim part1
log {/*}
add wave {/*}

# Cycle1: Reset Everything
force {x} 10101010101010101010101010101010
force {y} 11111111111111111111111111111111
force {s} 1
run 160ns
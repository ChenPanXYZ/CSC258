# Set the working dir, where all compiled Verilog goes.
vlib work

vlog -timescale 1ns/1ns adder.v

vsim adder

log {/*}
add wave {/*}

# Edge Case: A = 1111, B = 1111, cin = 1
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 1
force {SW[4]} 1
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 1
force {SW[8]} 1
# Run simulation for a few ns.
run 160ns

# Edge Case: A = 1111, B = 1111, cin = 0
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 1
force {SW[4]} 1
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 1
force {SW[8]} 1
# Run simulation for a few ns.
run 160ns

force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 0
force {SW[8]} 0
# Run simulation for a few ns.
run 160ns

force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 0
force {SW[8]} 0
# Run simulation for a few ns.
run 160ns

force {SW[0]} 0

force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 0

force {SW[5]} 1
force {SW[6]} 0
force {SW[7]} 0
force {SW[8]} 0
# Run simulation for a few ns.
run 160ns






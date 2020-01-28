# Set the working dir, where all compiled Verilog goes.
vlib work
vlog -timescale 1ns/1ns part1.v
vsim part1
log {/*}
add wave {/*}

# Cycle1: Reset Everything
force {SW[1]} 0
force {KEY[0]} 0
force {SW[0]} 1
run 160ns

force {SW[1]} 0
force {KEY[0]} 1
force {SW[0]} 0
run 160ns


# Cycle2
force {SW[1]} 1
force {KEY[0]} 0
force {SW[0]} 1

run 160ns

force {SW[1]} 1
force {KEY[0]} 1
force {SW[0]} 1

run 160ns

# Cycle3
force {SW[1]} 1
force {KEY[0]} 0
force {SW[0]} 1

run 160ns

force {SW[1]} 1
force {KEY[0]} 1
force {SW[0]} 1

run 160ns


# Cycle4
force {SW[1]} 1
force {KEY[0]} 0
force {SW[0]} 1

run 160ns

force {SW[1]} 1
force {KEY[0]} 1
force {SW[0]} 1

run 160ns


# Cycle5
force {SW[1]} 0
force {KEY[0]} 0
force {SW[0]} 1

run 160ns

force {SW[1]} 0
force {KEY[0]} 1
force {SW[0]} 1

run 160ns


# Cycle6
force {SW[1]} 0
force {KEY[0]} 0
force {SW[0]} 0

run 160ns

force {SW[1]} 0
force {KEY[0]} 1
force {SW[0]} 0

run 160ns
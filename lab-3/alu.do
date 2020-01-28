# Set the working dir, where all compiled Verilog goes.
vlib work
vlog -timescale 1ns/1ns alu.v
vsim ALU
log {/*}
add wave {/*}

# For case 1:
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0

force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 1
force {SW[7]} 0

force {KEY[0]} 0
force {KEY[1]} 0
force {KEY[2]} 0
# Run simulation for a few ns.
run 160ns

# For case 2:
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0

force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 1
force {SW[7]} 0

force {KEY[0]} 1
force {KEY[1]} 0
force {KEY[2]} 0
# Run simulation for a few ns.
run 160ns

# For case 3:
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 1

force {SW[4]} 1
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 1

force {KEY[0]} 0
force {KEY[1]} 1
force {KEY[2]} 0
# Run simulation for a few ns.
run 160ns

# For case 4:
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0

force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 1
force {SW[7]} 0

force {KEY[0]} 1
force {KEY[1]} 1
force {KEY[2]} 0
# Run simulation for a few ns.
run 160ns

# For case 5:
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0

force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 1
force {SW[7]} 0

force {KEY[0]} 0
force {KEY[1]} 0
force {KEY[2]} 1
# Run simulation for a few ns.
run 160ns

# For case 6 a:
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0

force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0

force {KEY[0]} 1
force {KEY[1]} 0
force {KEY[2]} 1
# Run simulation for a few ns.
run 160ns

# For case 6 b:
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0

force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0

force {KEY[0]} 1
force {KEY[1]} 0
force {KEY[2]} 1
# Run simulation for a few ns.
run 160ns

# For case 7:
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0

force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 1
force {SW[7]} 0

force {KEY[0]} 0
force {KEY[1]} 1
force {KEY[2]} 0
# Run simulation for a few ns.
run 160ns
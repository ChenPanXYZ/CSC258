# Set the working dir, where all compiled Verilog goes.
vlib work
vlog -timescale 1ns/1ns sequence_detector.v
vsim sequence_detector
log {/*}
add wave {/*}

# Cycle1: Reset Everything
force {KEY[0]} 0
force {SW[1]} 0
force {SW[0]} 0
run 160ns
force {KEY[0]} 1
force {SW[1]} 0
force {SW[0]} 0
run 160ns






force {KEY[0]} 0
force {SW[1]} 1
force {SW[0]} 1
run 160ns
force {KEY[0]} 1
force {SW[1]} 1
force {SW[0]} 1
run 160ns


force {KEY[0]} 0
force {SW[1]} 1
force {SW[0]} 1
run 160ns
force {KEY[0]} 1
force {SW[1]} 1
force {SW[0]} 1
run 160ns


force {KEY[0]} 0
force {SW[1]} 1
force {SW[0]} 1
run 160ns
force {KEY[0]} 1
force {SW[1]} 1
force {SW[0]} 1
run 160ns


force {KEY[0]} 0
force {SW[1]} 1
force {SW[0]} 1
run 160ns
force {KEY[0]} 1
force {SW[1]} 1
force {SW[0]} 1
run 160ns


#1111



force {KEY[0]} 0
force {SW[1]} 0
force {SW[0]} 1
run 160ns
force {KEY[0]} 1
force {SW[1]} 0
force {SW[0]} 1
run 160ns


force {KEY[0]} 0
force {SW[1]} 1
force {SW[0]} 1
run 160ns
force {KEY[0]} 1
force {SW[1]} 1
force {SW[0]} 1
run 160ns







force {KEY[0]} 0
force {SW[1]} 1
force {SW[0]} 0
run 160ns
force {KEY[0]} 1
force {SW[1]} 1
force {SW[0]} 0
run 160ns



#reset


force {KEY[0]} 0
force {SW[1]} 1
force {SW[0]} 1
run 160ns
force {KEY[0]} 1
force {SW[1]} 1
force {SW[0]} 1
run 160ns


force {KEY[0]} 0
force {SW[1]} 1
force {SW[0]} 1
run 160ns
force {KEY[0]} 1
force {SW[1]} 1
force {SW[0]} 1
run 160ns




force {KEY[0]} 0
force {SW[1]} 1
force {SW[0]} 1
run 160ns
force {KEY[0]} 1
force {SW[1]} 1
force {SW[0]} 1
run 160ns
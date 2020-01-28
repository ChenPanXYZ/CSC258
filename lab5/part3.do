vlib work

vlog -timescale 1ns/1ns part3.v

vsim part3

log {/*}
add wave {/*}

force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {KEY[0]} 1
force {KEY[1]} 0
force {CLOCK_50} 0
run 160ns

force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {KEY[0]} 1
force {KEY[1]} 0
force {CLOCK_50} 1
run 160ns


force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {KEY[0]} 0
force {KEY[1]} 1
force {CLOCK_50} 0
run 160ns

force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {KEY[0]} 0
force {KEY[1]} 1
force {CLOCK_50} 1
run 160ns
vlib work
vlog -timescale 1ns/1ps part2.v
vsim part2
log {/*}
add wave {/*}

#SW[2]: par-load (active-high), SW[3]: reset_n(active-low)


# Cycle1: For Full Speed
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
force {CLOCK_50} 0
run 160ns

force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
force {CLOCK_50} 1
run 160ns

force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
force {CLOCK_50} 0
run 160ns

force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
force {CLOCK_50} 1
run 160ns



#For 1 HZ;
#Reset
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
force {CLOCK_50} 0
run 160ns

force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
force {CLOCK_50} 1
run 160ns


# Loops
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
force {CLOCK_50} 0 0, 1 5 -repeat 10
run 10000000ns



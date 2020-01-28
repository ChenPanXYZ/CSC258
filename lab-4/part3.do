# Set the working dir, where all compiled Verilog goes.
vlib work
vlog -timescale 1ns/1ns part3.v
vsim part3
log {/*}
add wave {/*}

#LoadVal
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 1

#reset
force {SW[9]} 0

#Clock
force {KEY[0]} 0

#Load_n
force {KEY[1]} 1

#ShiftRight
force {KEY[2]} 1

#ASR
force {KEY[3]} 0

# Run simulation for a few ns.
run 160ns


#LoadVal
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 1

#reset
force {SW[9]} 0

#Clock
force {KEY[0]} 1

#Load_n
force {KEY[1]} 0

#ShiftRight
force {KEY[2]} 0

#ASR
force {KEY[3]} 0

# Run simulation for a few ns.
run 160ns


#LoadVal
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 1

#reset
force {SW[9]} 1

#Clock
force {KEY[0]} 0

#Load_n
force {KEY[1]} 0

#ShiftRight
force {KEY[2]} 0

#ASR
force {KEY[3]} 0

# Run simulation for a few ns.
run 160ns


#LoadVal
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 1

#reset
force {SW[9]} 1

#Clock
force {KEY[0]} 1

#Load_n
force {KEY[1]} 0

#ShiftRight
force {KEY[2]} 0

#ASR
force {KEY[3]} 0

# Run simulation for a few ns.
run 160ns



#LoadVal
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 1

#reset
force {SW[9]} 1

#Clock
force {KEY[0]} 0

#Load_n
force {KEY[1]} 1

#ShiftRight
force {KEY[2]} 1

#ASR
force {KEY[3]} 1

# Run simulation for a few ns.
run 160ns


#LoadVal
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 1

#reset
force {SW[9]} 1

#Clock
force {KEY[0]} 1

#Load_n
force {KEY[1]} 1

#ShiftRight
force {KEY[2]} 1

#ASR
force {KEY[3]} 1

# Run simulation for a few ns.
run 160ns


#LoadVal
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 1

#reset
force {SW[9]} 1

#Clock
force {KEY[0]} 0

#Load_n
force {KEY[1]} 1

#ShiftRight
force {KEY[2]} 1

#ASR
force {KEY[3]} 1

# Run simulation for a few ns.
run 160ns


#LoadVal
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 1

#reset
force {SW[9]} 1

#Clock
force {KEY[0]} 1

#Load_n
force {KEY[1]} 1

#ShiftRight
force {KEY[2]} 1

#ASR
force {KEY[3]} 1

# Run simulation for a few ns.
run 160ns



#LoadVal
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 1

#reset
force {SW[9]} 1

#Clock
force {KEY[0]} 0

#Load_n
force {KEY[1]} 1

#ShiftRight
force {KEY[2]} 1

#ASR
force {KEY[3]} 0

# Run simulation for a few ns.
run 160ns


#LoadVal
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 1

#reset
force {SW[9]} 1

#Clock
force {KEY[0]} 1

#Load_n
force {KEY[1]} 1

#ShiftRight
force {KEY[2]} 1

#ASR
force {KEY[3]} 0

# Run simulation for a few ns.
run 160ns


#LoadVal
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 1

#reset
force {SW[9]} 1

#Clock
force {KEY[0]} 0

#Load_n
force {KEY[1]} 1

#ShiftRight
force {KEY[2]} 1

#ASR
force {KEY[3]} 0

# Run simulation for a few ns.
run 160ns


#LoadVal
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 1

#reset
force {SW[9]} 1

#Clock
force {KEY[0]} 1

#Load_n
force {KEY[1]} 1

#ShiftRight
force {KEY[2]} 1

#ASR
force {KEY[3]} 0

# Run simulation for a few ns.
run 160ns


#LoadVal
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 1

#reset
force {SW[9]} 1

#Clock
force {KEY[0]} 0

#Load_n
force {KEY[1]} 1

#ShiftRight
force {KEY[2]} 0

#ASR
force {KEY[3]} 0

# Run simulation for a few ns.
run 160ns


#LoadVal
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 1

#reset
force {SW[9]} 1

#Clock
force {KEY[0]} 1

#Load_n
force {KEY[1]} 1

#ShiftRight
force {KEY[2]} 0

#ASR
force {KEY[3]} 0

# Run simulation for a few ns.
run 160ns
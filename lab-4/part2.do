# Set the working dir, where all compiled Verilog goes.
vlib work
vlog -timescale 1ns/1ns part2.v
vsim part2
log {/*}
add wave {/*}

# For case 0:

#Data A
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 1

#ALU-Function
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0

#reset_n
force {SW[9]} 1

#Clock
force {KEY[0]} 0

# Run simulation for a few ns.
run 160ns


#Data A
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 1

#ALU-Function
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0

#reset_n
force {SW[9]} 0

#Clock
force {KEY[0]} 1 

#B should be 0000 because reset.
#And it is also for case 1 test.
# Run simulation for a few ns.
run 160ns


#Data A
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 1

#ALU-Function
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0

#reset_n
force {SW[9]} 0

#Clock
force {KEY[0]} 0

#B should still be 0000 because it is not a positive edge.
#But we should get an ALUout 00000000
# Run simulation for a few ns.
run 160ns


#Data A
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 1

#ALU-Function
force {SW[5]} 1
force {SW[6]} 0
force {SW[7]} 0

#reset_n
force {SW[9]} 1

#Clock
force {KEY[0]} 0

#CASE 1 TEST
#B should still be 0000 at first because it is not a positive edge.
#But we should get an ALUout 00000000
# Run simulation for a few ns.
run 160ns


#Data A
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 1

#ALU-Function
force {SW[5]} 0
force {SW[6]} 1
force {SW[7]} 0

#reset_n
force {SW[9]} 1

#Clock
force {KEY[0]} 1

#CASE 2 TEST
#B should still be 0000 at first because it is not a positive edge.
#But we should get an ALUout 00000000
# Run simulation for a few ns.
run 160ns


#Data A
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 1

#ALU-Function
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 0

#reset_n
force {SW[9]} 1

#Clock
force {KEY[0]} 1

#CASE 3 TEST
#B should still be 0000 at first because it is not a positive edge.
#But we should get an ALUout 00000000
# Run simulation for a few ns.
run 160ns


#Data A
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 1

#ALU-Function
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 1

#reset_n
force {SW[9]} 1

#Clock
force {KEY[0]} 0

#CASE 4 TEST
#B should still be 0000 at first because it is not a positive edge.
#But we should get an ALUout 00000000
# Run simulation for a few ns.
run 160ns


#Data A
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 1

#ALU-Function
force {SW[5]} 1
force {SW[6]} 0
force {SW[7]} 1

#reset_n
force {SW[9]} 1

#Clock
force {KEY[0]} 1

#CASE 5 TEST And a positive edge so B should be 0001 after it.
#B should still be 0000 at first because it is not a positive edge.
#But we should get an ALUout 00000000
# Run simulation for a few ns.
run 160ns


#Data A
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 0

#ALU-Function
force {SW[5]} 0
force {SW[6]} 1
force {SW[7]} 1

#reset_n
force {SW[9]} 1

#Clock
force {KEY[0]} 1

#CASE 6 TEST.
#But we should get an ALUout 00000000
# Run simulation for a few ns.
run 160ns


#Data A
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 0

#ALU-Function
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 1

#reset_n
force {SW[9]} 1

#Clock
force {KEY[0]} 1

#CASE 7 TEST.
#But we should get an ALUout 00000000
# Run simulation for a few ns.
run 160ns
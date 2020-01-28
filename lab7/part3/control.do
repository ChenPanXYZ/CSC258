vlib work

vlog -timescale 1ps/1ps control.v

vsim -L altera_mf_ver control

log {/*}
add wave {/*}

force {clock} 0
force {reset} 0
force {go} 0
force {start_drawing} 0
run 160ps

force {clock} 1
force {reset} 0
force {go} 0
force {start_drawing} 0
run 160ps






force {clock} 0
force {reset} 1
force {go} 1
force {start_drawing} 0
run 160ps

force {clock} 1
force {reset} 1
force {go} 1
force {start_drawing} 0
run 160ps






force {clock} 0
force {reset} 1
force {go} 0
force {start_drawing} 0
run 160ps

force {clock} 1
force {reset} 1
force {go} 0
force {start_drawing} 0
run 160ps




force {clock} 0
force {reset} 1
force {go} 1
force {start_drawing} 0
run 160ps

force {clock} 1
force {reset} 1
force {go} 1
force {start_drawing} 0
run 160ps


force {clock} 0
force {reset} 1
force {go} 0
force {start_drawing} 0
run 160ps

force {clock} 1
force {reset} 1
force {go} 0
force {start_drawing} 0
run 160ps



force {clock} 0
force {reset} 1
force {go} 0
force {start_drawing} 1
run 160ps

force {clock} 1
force {reset} 1
force {go} 0
force {start_drawing} 1
run 160ps



















vlib work

vlog -timescale 1ps/1ps datapath.v

vsim -L altera_mf_ver datapath

log {/*}
add wave {/*}

force {clock} 0
force {x_data} 0
force {y_data} 0
force {color_data} 010
force {reset} 0
force {go} 0
run 160ps



force {clock} 1
force {x_data} 0
force {y_data} 0
force {color_data} 010
force {reset} 0
force {go} 0
run 160ps




force {clock} 0
force {x_data} 0
force {y_data} 0
force {color_data} 010
force {reset} 1
force {go} 1
run 160ps



force {clock} 1
force {x_data} 0
force {y_data} 0
force {color_data} 010
force {reset} 1
force {go} 1
run 160ps


force {clock} 0
force {x_data} 0
force {y_data} 0
force {color_data} 010
force {reset} 1
force {go} 1
run 160ps



force {clock} 1
force {x_data} 0
force {y_data} 0
force {color_data} 010
force {reset} 1
force {go} 1
run 160ps


force {clock} 0
force {x_data} 0
force {y_data} 0
force {color_data} 010
force {reset} 1
force {go} 1
run 160ps



force {clock} 1
force {x_data} 0
force {y_data} 0
force {color_data} 010
force {reset} 1
force {go} 1
run 160ps




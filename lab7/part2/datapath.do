vlib work

vlog -timescale 1ps/1ps datapath.v

vsim -L altera_mf_ver datapath

log {/*}
add wave {/*}

force {clock} 0
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 0
force {go} 0
run 160ps

force {clock} 1
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 0
force {go} 0
run 160ps

force {clock} 0
force {ld_x} 1
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 0
run 160ps

force {clock} 1
force {ld_x} 1
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 0
run 160ps

force {clock} 0
force {ld_x} 0
force {ld_y} 1
force {ld_color} 0
force {position_data} 0000001
force {color_data} 001
force {reset} 1
force {go} 0
run 160ps

force {clock} 1
force {ld_x} 0
force {ld_y} 1
force {ld_color} 0
force {position_data} 0000001
force {color_data} 001
force {reset} 1
force {go} 0
run 160ps

force {clock} 0
force {ld_x} 0
force {ld_y} 0
force {ld_color} 1
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 0
run 160ps

force {clock} 1
force {ld_x} 0
force {ld_y} 0
force {ld_color} 1
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 0
run 160ps


force {clock} 0
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 1
run 160p

force {clock} 1
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 1
run 160ps


force {clock} 0
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 1
run 160p

force {clock} 1
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 1
run 160ps


force {clock} 0
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 1
run 160p

force {clock} 1
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 1
run 160ps

force {clock} 0
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 1
run 160p

force {clock} 1
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 1
run 160ps

force {clock} 0
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 1
run 160p

force {clock} 1
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 1
run 160ps

force {clock} 0
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 1
run 160p

force {clock} 1
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 1
run 160ps

force {clock} 0
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 1
run 160p

force {clock} 1
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 1
run 160ps

force {clock} 0
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 1
run 160p

force {clock} 1
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 1
run 160ps

force {clock} 0
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 1
run 160p

force {clock} 1
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 1
run 160ps

force {clock} 0
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 1
run 160p

force {clock} 1
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 1
run 160ps

force {clock} 0
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 1
run 160p

force {clock} 1
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 1
run 160ps


force {clock} 0
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 1
run 160p

force {clock} 1
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 1
run 160ps


force {clock} 0
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 1
run 160p

force {clock} 1
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 1
run 160ps


force {clock} 0
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 1
run 160p

force {clock} 1
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 1
run 160ps


force {clock} 0
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 1
run 160p

force {clock} 1
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 1
run 160ps


force {clock} 0
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 1
run 160p

force {clock} 1
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 1
run 160ps


force {clock} 0
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 1
run 160p

force {clock} 1
force {ld_x} 0
force {ld_y} 0
force {ld_color} 0
force {position_data} 0000000
force {color_data} 001
force {reset} 1
force {go} 1
run 160ps




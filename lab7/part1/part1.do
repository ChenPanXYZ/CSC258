vlib work

vlog -timescale 1ps/1ps ram32x4.v

vsim -L altera_mf_ver ram32x4

log {/*}
add wave {/*}

force {clock} 0
force {address} 00001
force {data} 1111
force {wren} 1
run 160ps

force {clock} 1
force {address} 00001
force {data} 1111
force {wren} 1
run 160ps



force {clock} 0
force {address} 00001
force {data} 0110
force {wren} 1
run 160ps

force {clock} 1
force {address} 00001
force {data} 0110
force {wren} 1
run 160ps



force {clock} 0
force {address} 00001
force {data} 0000
force {wren} 0
run 160ps

force {clock} 1
force {address} 00001
force {data} 0000
force {wren} 0
run 160ps
























force {clock} 0
force {address} 11111
force {data} 1111
force {wren} 0
run 160ps

force {clock} 1
force {address} 11111
force {data} 1111
force {wren} 0
run 160ps



force {clock} 0
force {address} 11111
force {data} 0110
force {wren} 1
run 160ps

force {clock} 1
force {address} 11111
force {data} 0110
force {wren} 1
run 160ps



force {clock} 0
force {address} 11111
force {data} 0000
force {wren} 0
run 160ps

force {clock} 1
force {address} 11111
force {data} 0000
force {wren} 0
run 160ps









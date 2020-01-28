vlib work

vlog -timescale 1ns/1ns seven_segment_decoder.v

# Load simulation using mux as the top level simulation module.
vsim seven_segment_decoder

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}

force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0

run 10ns


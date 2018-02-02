#open_wave_config shift_out_tb.wcfg
#log_wave -r *
set vcdfile [lindex $argv 0]
set sim_time [lindex $argc 1]
xsim shift_out_tb 
open_vcd $vcdfile
log_vcd *
run 200 ns
close_vcd
quit
#**************************************************************
# Create Clock (where ‘Clk’ is the user-defined system clock name)
#**************************************************************
create_clock -name {MAX10_CLK1_50} -period 20ns -waveform {0.000 5.000} [get_ports {MAX10_CLK1_50}]
# Constrain the input I/O path
set_input_delay -clock {MAX10_CLK1_50} -max 3 [all_inputs]
set_input_delay -clock {MAX10_CLK1_50} -min 2 [all_inputs]
# Constrain the output I/O path
set_output_delay -clock {MAX10_CLK1_50} 2 [all_outputs]
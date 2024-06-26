transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/kayla/OneDrive/Documents/ECE385/lab4 {C:/Users/kayla/OneDrive/Documents/ECE385/lab4/router.sv}
vlog -sv -work work +incdir+C:/Users/kayla/OneDrive/Documents/ECE385/lab4 {C:/Users/kayla/OneDrive/Documents/ECE385/lab4/ripple_adder.sv}
vlog -sv -work work +incdir+C:/Users/kayla/OneDrive/Documents/ECE385/lab4 {C:/Users/kayla/OneDrive/Documents/ECE385/lab4/reg_17.sv}
vlog -sv -work work +incdir+C:/Users/kayla/OneDrive/Documents/ECE385/lab4 {C:/Users/kayla/OneDrive/Documents/ECE385/lab4/Hex_driver.sv}
vlog -sv -work work +incdir+C:/Users/kayla/OneDrive/Documents/ECE385/lab4 {C:/Users/kayla/OneDrive/Documents/ECE385/lab4/control.sv}
vlog -sv -work work +incdir+C:/Users/kayla/OneDrive/Documents/ECE385/lab4 {C:/Users/kayla/OneDrive/Documents/ECE385/lab4/multiplier.sv}

vlog -sv -work work +incdir+C:/Users/kayla/OneDrive/Documents/ECE385/lab4 {C:/Users/kayla/OneDrive/Documents/ECE385/lab4/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 2000 ns

transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/kayla/Downloads/385_lab4_adders_provided_fa20 {C:/Users/kayla/Downloads/385_lab4_adders_provided_fa20/router.sv}
vlog -sv -work work +incdir+C:/Users/kayla/Downloads/385_lab4_adders_provided_fa20 {C:/Users/kayla/Downloads/385_lab4_adders_provided_fa20/reg_17.sv}
vlog -sv -work work +incdir+C:/Users/kayla/Downloads/385_lab4_adders_provided_fa20 {C:/Users/kayla/Downloads/385_lab4_adders_provided_fa20/lookahead_adder.sv}
vlog -sv -work work +incdir+C:/Users/kayla/Downloads/385_lab4_adders_provided_fa20 {C:/Users/kayla/Downloads/385_lab4_adders_provided_fa20/HexDriver.sv}
vlog -sv -work work +incdir+C:/Users/kayla/Downloads/385_lab4_adders_provided_fa20 {C:/Users/kayla/Downloads/385_lab4_adders_provided_fa20/control.sv}
vlog -sv -work work +incdir+C:/Users/kayla/Downloads/385_lab4_adders_provided_fa20 {C:/Users/kayla/Downloads/385_lab4_adders_provided_fa20/adder2.sv}

vlog -sv -work work +incdir+C:/Users/kayla/OneDrive/Documents/ECE385/lab3/../../../../Downloads/385_lab4_adders_provided_fa20 {C:/Users/kayla/OneDrive/Documents/ECE385/lab3/../../../../Downloads/385_lab4_adders_provided_fa20/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 1000 ns
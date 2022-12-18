transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/kayla/OneDrive/Documents/ECE385/lab5/lab5files {C:/Users/kayla/OneDrive/Documents/ECE385/lab5/lab5files/test_memory.sv}
vlog -sv -work work +incdir+C:/Users/kayla/OneDrive/Documents/ECE385/lab5/lab5files {C:/Users/kayla/OneDrive/Documents/ECE385/lab5/lab5files/synchronizers.sv}
vlog -sv -work work +incdir+C:/Users/kayla/OneDrive/Documents/ECE385/lab5/lab5files {C:/Users/kayla/OneDrive/Documents/ECE385/lab5/lab5files/SLC3_2.sv}
vlog -sv -work work +incdir+C:/Users/kayla/OneDrive/Documents/ECE385/lab5/lab5files {C:/Users/kayla/OneDrive/Documents/ECE385/lab5/lab5files/Mem2IO.sv}
vlog -sv -work work +incdir+C:/Users/kayla/OneDrive/Documents/ECE385/lab5/lab5files {C:/Users/kayla/OneDrive/Documents/ECE385/lab5/lab5files/ISDU.sv}
vlog -sv -work work +incdir+C:/Users/kayla/OneDrive/Documents/ECE385/lab5/lab5files {C:/Users/kayla/OneDrive/Documents/ECE385/lab5/lab5files/HexDriver.sv}
vlog -sv -work work +incdir+C:/Users/kayla/OneDrive/Documents/ECE385/lab5/lab5files {C:/Users/kayla/OneDrive/Documents/ECE385/lab5/lab5files/slc3.sv}
vlog -sv -work work +incdir+C:/Users/kayla/OneDrive/Documents/ECE385/lab5/lab5files {C:/Users/kayla/OneDrive/Documents/ECE385/lab5/lab5files/memory_contents.sv}
vlog -sv -work work +incdir+C:/Users/kayla/OneDrive/Documents/ECE385/lab5/lab5files {C:/Users/kayla/OneDrive/Documents/ECE385/lab5/lab5files/slc3_testtop.sv}

vlog -sv -work work +incdir+C:/Users/kayla/OneDrive/Documents/ECE385/lab5/lab5files {C:/Users/kayla/OneDrive/Documents/ECE385/lab5/lab5files/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 2000000 ns

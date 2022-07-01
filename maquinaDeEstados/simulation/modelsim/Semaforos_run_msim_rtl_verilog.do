transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/ferre/Desktop/DLP/tarefa4 {C:/Users/ferre/Desktop/DLP/tarefa4/semaforo.v}

vlog -vlog01compat -work work +incdir+C:/Users/ferre/Desktop/DLP/tarefa4 {C:/Users/ferre/Desktop/DLP/tarefa4/FSM_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  FSM_tb

add wave *
view structure
view signals
run 2000 ns

transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/ferre/Downloads/ParaleloSerie/ParaleloSerie {C:/Users/ferre/Downloads/ParaleloSerie/ParaleloSerie/PISOReg.v}
vlog -vlog01compat -work work +incdir+C:/Users/ferre/Downloads/ParaleloSerie/ParaleloSerie {C:/Users/ferre/Downloads/ParaleloSerie/ParaleloSerie/cnt4.v}
vlog -vlog01compat -work work +incdir+C:/Users/ferre/Downloads/ParaleloSerie/ParaleloSerie {C:/Users/ferre/Downloads/ParaleloSerie/ParaleloSerie/MUX4.v}
vlog -vlog01compat -work work +incdir+C:/Users/ferre/Downloads/ParaleloSerie/ParaleloSerie {C:/Users/ferre/Downloads/ParaleloSerie/ParaleloSerie/TX.v}
vlog -vlog01compat -work work +incdir+C:/Users/ferre/Downloads/ParaleloSerie/ParaleloSerie {C:/Users/ferre/Downloads/ParaleloSerie/ParaleloSerie/SIPOReg.v}
vlog -vlog01compat -work work +incdir+C:/Users/ferre/Downloads/ParaleloSerie/ParaleloSerie {C:/Users/ferre/Downloads/ParaleloSerie/ParaleloSerie/DEMUX4.v}
vlog -vlog01compat -work work +incdir+C:/Users/ferre/Downloads/ParaleloSerie/ParaleloSerie {C:/Users/ferre/Downloads/ParaleloSerie/ParaleloSerie/decoder4.v}
vlog -vlog01compat -work work +incdir+C:/Users/ferre/Downloads/ParaleloSerie/ParaleloSerie {C:/Users/ferre/Downloads/ParaleloSerie/ParaleloSerie/RX.v}
vlog -vlog01compat -work work +incdir+C:/Users/ferre/Downloads/ParaleloSerie/ParaleloSerie {C:/Users/ferre/Downloads/ParaleloSerie/ParaleloSerie/TOP.v}
vlog -vlog01compat -work work +incdir+C:/Users/ferre/Downloads/ParaleloSerie/ParaleloSerie {C:/Users/ferre/Downloads/ParaleloSerie/ParaleloSerie/JK_FF.v}
vlog -vlog01compat -work work +incdir+C:/Users/ferre/Downloads/ParaleloSerie/ParaleloSerie {C:/Users/ferre/Downloads/ParaleloSerie/ParaleloSerie/D_FF.v}

vlog -vlog01compat -work work +incdir+C:/Users/ferre/Downloads/ParaleloSerie/ParaleloSerie {C:/Users/ferre/Downloads/ParaleloSerie/ParaleloSerie/TOP_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  TOP_tb

add wave *
view structure
view signals
run 3 ms

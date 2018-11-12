transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/luizaff/Documents/fpEEL5105_clone/final_project_EEL5105/frequency_divider.vhd}
vcom -93 -work work {/home/luizaff/Documents/fpEEL5105_clone/final_project_EEL5105/decod7seg.vhd}
vcom -93 -work work {/home/luizaff/Documents/fpEEL5105_clone/final_project_EEL5105/ROM1.vhd}
vcom -93 -work work {/home/luizaff/Documents/fpEEL5105_clone/final_project_EEL5105/datapath.vhd}
vcom -93 -work work {/home/luizaff/Documents/fpEEL5105_clone/final_project_EEL5105/control.vhd}
vcom -93 -work work {/home/luizaff/Documents/fpEEL5105_clone/final_project_EEL5105/multiplexer.vhd}
vcom -93 -work work {/home/luizaff/Documents/fpEEL5105_clone/final_project_EEL5105/counter_user.vhd}
vcom -93 -work work {/home/luizaff/Documents/fpEEL5105_clone/final_project_EEL5105/comparator2x1.vhd}
vcom -93 -work work {/home/luizaff/Documents/fpEEL5105_clone/final_project_EEL5105/counter_round.vhd}
vcom -93 -work work {/home/luizaff/Documents/fpEEL5105_clone/final_project_EEL5105/counter_time.vhd}
vcom -93 -work work {/home/luizaff/Documents/fpEEL5105_clone/final_project_EEL5105/main.vhd}
vcom -93 -work work {/home/luizaff/Documents/fpEEL5105_clone/final_project_EEL5105/multiplexer2x1.vhd}
vcom -93 -work work {/home/luizaff/Documents/fpEEL5105_clone/final_project_EEL5105/column_decoder.vhd}
vcom -93 -work work {/home/luizaff/Documents/fpEEL5105_clone/final_project_EEL5105/multiplexer_1bit.vhd}
vcom -93 -work work {/home/luizaff/Documents/fpEEL5105_clone/final_project_EEL5105/buttonSync.vhd}
vcom -93 -work work {/home/luizaff/Documents/fpEEL5105_clone/final_project_EEL5105/REGISTRADOR.vhd}
vcom -93 -work work {/home/luizaff/Documents/fpEEL5105_clone/final_project_EEL5105/ROM0.vhd}


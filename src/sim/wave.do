onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/DUT/rst
add wave -noupdate -radix unsigned /tb/DUT/a
add wave -noupdate -radix unsigned /tb/DUT/b
add wave -noupdate -divider {Inputs to LC0}
add wave -noupdate /tb/DUT/sel_sj0
add wave -noupdate /tb/DUT/lr
add wave -noupdate /tb/DUT/la
add wave -noupdate -divider {LC0 to SJ0}
add wave -noupdate -radix unsigned /tb/DUT/L0A_o
add wave -noupdate -radix unsigned /tb/DUT/L0B_o
add wave -noupdate /tb/DUT/r0
add wave -noupdate /tb/DUT/a0
add wave -noupdate -divider {SJ0 to LC1}
add wave -noupdate /tb/DUT/r1
add wave -noupdate /tb/DUT/a1
add wave -noupdate -divider {LC1 to LC2}
add wave -noupdate -radix unsigned /tb/DUT/L1A_i
add wave -noupdate -radix unsigned /tb/DUT/L1B_i
add wave -noupdate -radix unsigned /tb/DUT/L1A_o
add wave -noupdate -radix unsigned /tb/DUT/L1B_o
add wave -noupdate /tb/DUT/r2
add wave -noupdate /tb/DUT/a2
add wave -noupdate -divider {LC2 to SF0}
add wave -noupdate /tb/DUT/sel_sf0
add wave -noupdate -radix unsigned /tb/DUT/Fn_o
add wave -noupdate /tb/DUT/Fn_s
add wave -noupdate /tb/DUT/Fn_e
add wave -noupdate /tb/DUT/r3
add wave -noupdate /tb/DUT/a3
add wave -noupdate -radix unsigned /tb/DUT/L2D_o
add wave -noupdate /tb/DUT/L2S_o
add wave -noupdate /tb/DUT/L2E_o
add wave -noupdate -radix unsigned /tb/DUT/L2A_o
add wave -noupdate -radix unsigned /tb/DUT/L2B_o
add wave -noupdate -radix unsigned /tb/DUT/L1A_m
add wave -noupdate -radix unsigned /tb/DUT/L2B_m
add wave -noupdate -divider {SF0 to SJ0}
add wave -noupdate /tb/DUT/r5
add wave -noupdate /tb/DUT/a5
add wave -noupdate -divider {SF0 to LC3}
add wave -noupdate /tb/DUT/r4
add wave -noupdate /tb/DUT/a4
add wave -noupdate -divider <NULL>
add wave -noupdate -radix unsigned /tb/DUT/gcd
add wave -noupdate /tb/DUT/rr
add wave -noupdate /tb/DUT/ra
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {70137 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 239
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {174711 ps}

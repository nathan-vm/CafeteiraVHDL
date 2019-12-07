onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color Blue /tb_cafeteira/w_CLK
add wave -noupdate -divider {Maquinas de estado}
add wave -noupdate /tb_cafeteira/Utt/U_1/w_state
add wave -noupdate /tb_cafeteira/Utt/U_2/w_state
add wave -noupdate -divider {Entradas Switchs}
add wave -noupdate -color Gold /tb_cafeteira/w_RST
add wave -noupdate -color Gold /tb_cafeteira/w_CAFE
add wave -noupdate -color Gold /tb_cafeteira/w_CAFE_LEITE
add wave -noupdate -color Gold /tb_cafeteira/w_MOCHA
add wave -noupdate -color Gold /tb_cafeteira/w_TAMANHO
add wave -noupdate -color Gold /tb_cafeteira/w_ACUCAR
add wave -noupdate -divider {Entradas botoes}
add wave -noupdate /tb_cafeteira/w_PREPARO
add wave -noupdate /tb_cafeteira/w_REPOSICAO
add wave -noupdate -divider {Leds switchs}
add wave -noupdate -color Gold /tb_cafeteira/w_OUT_CAFE
add wave -noupdate -color Gold /tb_cafeteira/w_OUT_CAFE_LEITE
add wave -noupdate -color Gold /tb_cafeteira/w_OUT_MOCHA
add wave -noupdate -color Gold /tb_cafeteira/w_OUT_TAMANHO
add wave -noupdate -color Gold /tb_cafeteira/w_OUT_ACUCAR
add wave -noupdate -divider Leds
add wave -noupdate -color Red /tb_cafeteira/w_OUT_PREPARO
add wave -noupdate -radixenum numeric /tb_cafeteira/w_OUT_DISPLAY_1
add wave -noupdate -radixenum numeric /tb_cafeteira/w_OUT_DISPLAY_2
add wave -noupdate -radixenum numeric /tb_cafeteira/w_OUT_DISPLAY_3
add wave -noupdate -radixenum numeric /tb_cafeteira/w_OUT_DISPLAY_4
add wave -noupdate -divider sinal
add wave -noupdate -color Cyan /tb_cafeteira/w_OUT_REPOSICAO
add wave -noupdate -divider Memoria
add wave -noupdate -radix decimal /tb_cafeteira/Utt/U_1/U1/w_MEMORIA
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 316
configure wave -valuecolwidth 114
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {47250 ns}

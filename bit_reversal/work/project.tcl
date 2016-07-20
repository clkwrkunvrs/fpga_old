set projDir "/home/kells/FPGA/mojo/projects/bit_reversal/work/planAhead"
set projName "bit_reversal"
set topName top
set device xc6slx9-2tqg144
if {[file exists "$projDir/$projName"]} { file delete -force "$projDir/$projName" }
create_project $projName "$projDir/$projName" -part $device
set_property design_mode RTL [get_filesets sources_1]
set verilogSources [list "/home/kells/FPGA/mojo/projects/bit_reversal/work/verilog/mojo_top_0.v" "/home/kells/FPGA/mojo/projects/bit_reversal/work/verilog/avr_interface_1.v" "/home/kells/FPGA/mojo/projects/bit_reversal/work/verilog/message_printer_2.v" "/home/kells/FPGA/mojo/projects/bit_reversal/work/verilog/cclk_detector_3.v" "/home/kells/FPGA/mojo/projects/bit_reversal/work/verilog/spi_slave_4.v" "/home/kells/FPGA/mojo/projects/bit_reversal/work/verilog/serial_rx_5.v" "/home/kells/FPGA/mojo/projects/bit_reversal/work/verilog/serial_tx_6.v" "/home/kells/FPGA/mojo/projects/bit_reversal/work/verilog/message_rom_7.v"]
import_files -fileset [get_filesets sources_1] -force -norecurse $verilogSources
set ucfSources [list "/home/kells/FPGA/mojo/projects/bit_reversal/constraint/mojo.ucf"]
import_files -fileset [get_filesets constrs_1] -force -norecurse $ucfSources
set_property -name {steps.bitgen.args.More Options} -value {-g Binary:Yes -g Compress} -objects [get_runs impl_1]
set_property steps.map.args.mt on [get_runs impl_1]
set_property steps.map.args.pr b [get_runs impl_1]
set_property steps.par.args.mt on [get_runs impl_1]
update_compile_order -fileset sources_1
launch_runs -runs synth_1
wait_on_run synth_1
launch_runs -runs impl_1
wait_on_run impl_1
launch_runs impl_1 -to_step Bitgen
wait_on_run impl_1
#set_property IOSTANDARD LVCMOS33 [get_ports clk]
#set_property PACKAGE_PIN Y9 [get_ports clk]
#create_clock -period 10 [get_ports clk]

#set_property -dict  [get_ports D]
set_property -dict { PACKAGE_PIN Y11 IOSTANDARD LVCMOS33 } [get_ports {D}]
#set_property IOSTANDARD LVCMOS33 [get_ports A]
set_property -dict { PACKAGE_PIN AA11 IOSTANDARD LVCMOS33 } [get_ports {A}]
#set_property IOSTANDARD LVCMOS33 [get_ports Dp]
set_property -dict {   PACKAGE_PIN Y10 IOSTANDARD LVCMOS33 } [get_ports {Dp}]
#set_property IOSTANDARD LVCMOS33 [get_ports E]
set_property -dict {   PACKAGE_PIN AA9 IOSTANDARD LVCMOS33 } [get_ports {E}]
#set_property IOSTANDARD LVCMOS33 [get_ports B]
set_property -dict {   PACKAGE_PIN W12 IOSTANDARD LVCMOS33 } [get_ports {B}]
#set_property IOSTANDARD LVCMOS33 [get_ports C]
set_property -dict {   PACKAGE_PIN W11 IOSTANDARD LVCMOS33 } [get_ports {C}]
#set_property IOSTANDARD LVCMOS33 [get_ports G]
set_property -dict {  PACKAGE_PIN V10 IOSTANDARD LVCMOS33 } [get_ports {G}]
#set_property IOSTANDARD LVCMOS33 [get_ports F]
set_property  -dict {   PACKAGE_PIN W8 IOSTANDARD LVCMOS33 } [get_ports {F}]

############################

#set_property  [get_ports Din0]
set_property -dict { PACKAGE_PIN H18 IOSTANDARD LVCMOS25} [get_ports Din0]
#set_property -dict { IOSTANDARD LVCMOS25 } [get_ports Din1]
set_property -dict { PACKAGE_PIN H17 IOSTANDARD LVCMOS25 } [get_ports Din1]
#set_property -dict { IOSTANDARD LVCMOS25 } [get_ports DiIOSTANDARD LVCMOS25 n2]
set_property -dict { PACKAGE_PIN M15 IOSTANDARD LVCMOS25 } [get_ports Din2]
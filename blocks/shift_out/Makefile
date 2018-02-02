VIVADO_BASE=C:/Xilinx/Vivado/2017.4/bin
VIVADO=$(VIVADO_BASE)/vivado
XVHDL=$(VIVADO_BASE)/xvhdl
XELAB=$(VIVADO_BASE)/xelab
XSIM=$(VIVADO_BASE)/xsim

WORKLIB=work
TOP=shift_out_tb

HDL_FILES=hdl/shift_out.vhd 
SIM_FILES=sim/shift_out_tb.vhd
VCDFILE=dump.vcd

SIM_TIME=200 
SIM_CONFIG_TCL=sim.tcl

all: analyze elaborate simulate
analyze: 
	$(XVHDL) -work $(WORKLIB) $(HDL_FILES) $(SIM_FILES)

elaborate:
	$(XELAB) -debug typical shift_out_tb -s shift_out_tb

simulate:
	$(VIVADO_BASE)/vivado -mode batch -source $(SIM_CONFIG_TCL) -tclargs $(VCDFILE) $(SIM_TIME)

clean:
	rm *.jou *.log *.vcd *.wdb *.pb 
	rm -rf .Xil xsim.dir

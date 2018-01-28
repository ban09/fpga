GHDL=ghdl
TOP=shift_out_tb
WORKDIR=work
HDLFILES=shift_out_1.vhd shift_out_tb.vhd
VCDFILE=dump.vcd
VIEWER=gtkwave
SIM_TIME=90ns

all: directories elaborate simulate

directories: $(WORKDIR)
$(WORKDIR):	
	mkdir -p $(WORKDIR)
elaborate:
	$(GHDL) -i --workdir=$(WORKDIR) $(HDLFILES)  
	$(GHDL) -m --workdir=$(WORKDIR) $(TOP)

simulate: 
	$(TOP).exe --stop-time=$(SIM_TIME) --vcd=$(VCDFILE)

.PHONY:display clean
display: 
	$(VIEWER) $(VCDFILE)
clean:
	rm $(TOP).exe work/* *.o *.vcd

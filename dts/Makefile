# Build the device tree for the Lenovo LACM-MN101.
# Requires cpp and dtc. Run "make" in this directory.

CPP = cpp
DTC = dtc
CPPFLAGS := -nostdinc -undef -D__DTS__ -x assembler-with-cpp -I . -I include

BOARD := cix-sky1-lenovo-lacm-mn101
DEPS := sky1.dtsi sky1-pinfunc.h

all: $(BOARD).dtb

$(BOARD).dtb: $(BOARD).dts $(DEPS)
	$(CPP) $(CPPFLAGS) -o $(BOARD).pre.dts $(BOARD).dts
	$(DTC) -I dts -O dtb -o $(BOARD).dtb $(BOARD).pre.dts
	$(DTC) -I dtb -O dts $(BOARD).dtb -o $(BOARD).decompiled.dts
	@rm -f $(BOARD).pre.dts

check: $(BOARD).dtb
	$(DTC) -I dtb -O dts -o /dev/null $(BOARD).dtb

clean:
	rm -f $(BOARD).dtb $(BOARD).pre.dts $(BOARD).decompiled.dts

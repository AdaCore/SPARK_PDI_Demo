demo: print_pdi define_pdi
	@echo "=================================="
	@echo "Generate binary PDI file \"the.pdi\""
	@echo "=================================="
	./define_pdi
	@echo "============================================================="
	@echo "Example application: load binary PDI file \"the.pdi\" and print"
	@echo "============================================================="
	./print_pdi

print_pdi: pdi.ads pdi.adb print_pdi.adb
	gprbuild -P pdi.gpr print_pdi.adb

define_pdi: pdi.ads pdi.adb define_pdi.adb
	gprbuild -P pdi.gpr define_pdi.adb

clean:
	gprclean -P pdi.gpr
	rm -f the.pdi

########################################
# Only necessary for running MODELSIM:
# 
# In your shell (I use tcsh): you may need to define the license file
# before running make:
#
# setenv LM_LICENSE_FILE /uusoc/facility/cad_tools/Mentor/common_license
#
MODELTECH_BIN=/uusoc/facility/cad_tools/Mentor/MSIM-S17/questasim/bin
CADTOOLS=/uusoc/facility/cad_common/local/bin/S22:/uusoc/facility/cad_common/local/bin/F19:/uusoc/facility/cad_common/local/bin/F18:/uusoc/facility/cad_common/local/bin/F17:/uusoc/facility/cad_common/local/bin/S17:/uusoc/facility/cad_common/local/bin/F16:/uusoc/facility/cad_common/local/bin/F15
# Add tools paths to PATH
PATH=.:/usr/share/Modules/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/usr/local/cuda/bin:/bin:${CADTOOLS}:${MODELTECH_BIN}
#
########################################

all: clean sim_c

clean:
	-\rm -r work
	-\rm -r transcript
	-\rm -r vsim_stacktrace.vstf
	-\rm -r vsim.wlf

sim_c:
	cd sim; vlog -f dut.f
	cd sim; vlog -f sv.f
	cd sim; vopt tb -o tb_optimized +acc
	cd sim; vsim -c tb_optimized +UVM_TESTNAME=gcd_test -sv_seed random -do "run -all; exit -code 0"

sim:
	cd sim; vlog -f dut.f
	cd sim; vlog -f sv.f
	cd sim; vopt tb -o tb_optimized +acc
	cd sim; vsim tb_optimized +UVM_TESTNAME=gcd_test -sv_seed random -do "do wave.do; run -all"

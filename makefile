
PathToSbtJar = /home/rv/riscv/freedom/rocket-chip/sbt-launch.jar
SBT ?= java -jar ${PathToSbtJar} ++2.12.4
Generated-Src = ./generated-src
TestBench = ./testbench

# 指定verilator
VERILATOR = verilator


# DUT 即为编译的目标，在命令行中指定

# 由chisel生成verilog
verilog := ${TestBench}/${DUT}/vsrc/${DUT}.v
${verilog}:
	mkdir -p ${Generated-Src}/${DUT}
	${SBT} 'runMain ${DUT} -td ${Generated-Src}/${DUT}'
	mkdir -p ${TestBench}/${DUT}/vsrc
	mkdir -p ${TestBench}/${DUT}/csrc
	cp ${Generated-Src}/${DUT}/* ${TestBench}/${DUT}/vsrc

.PHONY: verilog
verilog: ${verilog}

testcpp := ${TestBench}/${DUT}/tb.cpp
# 由verilog生成cpp
cpp := ${TestBench}/${DUT}/csrc/V${DUT}.cpp
${cpp}: ${testcpp} ${verilog}
	cd ${TestBench}/${DUT} && \
	${VERILATOR} \
	--cc \
	--trace \
	--exe \
	--top-module ${DUT} \
	tb.cpp \
	vsrc/${DUT}.v \
	-Ivsrc \
	--Mdir csrc \
	-o ../emu-${DUT}.out
# 由于makefile的依赖目标无法解析tb.cpp相对路径，故需要进入该文件夹内运行


# 生成可执行emu文件
exe:${cpp}
	${MAKE} -C ${TestBench}/${DUT}/csrc -f V${DUT}.mk
	rm ${TestBench}/${DUT}/csrc/*.d
	rm ${TestBench}/${DUT}/csrc/*.o
	rm ${TestBench}/${DUT}/csrc/*.a

run:exe
	./${TestBench}/${DUT}/emu-${DUT}.out

wave:run
	gtkwave ${TestBench}/${DUT}/tb.vcd



decoder-cpp:decoder-gen 
	mkdir -p ${TestBench}/$@
	cp -R ${Generated-Src}/$< ${TestBench}/$@


decoder-emu:decoder-verilate

blackBoxInlineDemoGen-gen:
	mkdir -p ${Generated-Src}/$@
	rm ${Generated-Src}/$@ -rf
	${SBT} 'runMain BlackBoxInlineDemoGen -td ${Generated-Src}/$@'

availible:
	${SBT} 'testOnly gcd.GCDTester -- -z Basic
sbt:
	${SBT} 'test:runMain gcd.GCDMain --generate-vcd-output on'
# decoder:
# 	rm test_run_dir/* -rf
# 	${SBT} 'test:runMain gcd.DECODERMain --backend-name verilator'


clk:
	${SBT} 'test:runMain gcd.CLKMain --backend-name verilator'
add:
	${SBT} 'test:run gcd.AdderTester'
help:
	${SBT} 'test:runMain gcd.DECODERMain --help'


clean:
	${SBT} clean
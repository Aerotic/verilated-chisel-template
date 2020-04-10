// Decoder-harness.cpp
#include <verilated.h>       // 核心头文件
#include <verilated_vcd_c.h> // 波形生成头文件
#include <iostream>
#include <fstream>
#include "VTriOctDecoderDemo.h" // 译码器模块类的头文件
using namespace std;
// 单词dump的意思是 转存
// A dump is a list of the data that is stored in a computer's memory at a particular time.
// Dumps are often used by computer programmers to find out what is causing a problem with a program.

VTriOctDecoderDemo *dut;      // 顶层dut对象指针
VerilatedVcdC *mTracer; // 波形生成对象指针

vluint64_t main_time = 0;         // 仿真时间戳
const vluint64_t sim_time = 100; // 最大仿真时间戳

// #define STEP  


int main(int argc, char **argv)
{
    // 一些初始化工作
    Verilated::commandArgs(argc, argv);
    Verilated::traceEverOn(true); /// Allow traces to at some point be enabled (disables some optimizations)

    // 为对象分配内存空间
    dut = new VTriOctDecoderDemo; // 这个名字是仿真的top模块所在的verilog文件的名字前加个V
    mTracer = new VerilatedVcdC;

    // tfp初始化工作
    dut->trace(mTracer, 99); // Trace 99 levels of hierarchy
    mTracer->open("./testbench/TriOctDecoderDemo/tb.vcd"); // 指定输出波形文件的文件名

    int count = 0;
    dut->clock = 0; // 时钟初始电位0
    dut->reset = 1;
    mTracer->dump(main_time); // 波形文件写入步进




    // Loop
    while (!Verilated::gotFinish() && main_time < sim_time)
    {
        /**
         * 上升沿信号赋值
        */
        dut->io_in = count++;

        // 时钟跳1
        dut-> clock = 1;
        dut -> eval();
        mTracer->dump(main_time++);
        printf("io_in is %x io_out is %x\n", dut->io_in,dut->io_out);


        /**
         * 下降沿信号赋值
        */
        dut-> clock = 0;
        dut->eval();
        mTracer->dump(main_time++);
    }
        std::cout<<std::endl;
        std::cout<<std::endl;
        std::cout<<std::endl;
    // 清理工作
    mTracer->close();
    delete dut;
    delete mTracer;
    exit(0);
    return 0;
}
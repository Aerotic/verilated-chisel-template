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

#define STEP  dut->clock = 1;dut->eval();mTracer->dump(main_time);main_time++;dut->clock = 0


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
    while (!Verilated::gotFinish() && main_time < sim_time)
    {
        STEP;
        // mTracer->dump(main_time); // 波形文件写入步进
        // if (count > 3 && count < 9)
        // {
        //     /* code */
        //     dut->vLong[0] = 0;
        //     printf ("*128***\n%x %x %x %x",dut->vLong[0],dut->vLong[1],dut->vLong[2],dut->Decoder__DOT__vSee[3]);
        //     printf ("\n*256*1**\n%x %x %x %x",dut->Decoder__DOT__vSee[0],dut->Decoder__DOT__vSee[1],dut->Decoder__DOT__vSee[2],dut->Decoder__DOT__vSee[3]);
        //     printf ("\n*256*2**\n%x %x %x %x",dut->Decoder__DOT__vSee[4],dut->Decoder__DOT__vSee[5],dut->Decoder__DOT__vSee[6],dut->Decoder__DOT__vSee[7]);
        //     dut->eval();          // 仿真时间步进 /// Evaluate the model.  Application must call when inputs change.
        //     mTracer->dump(main_time); // 波形文件写入步进
        //     printf("\n******");
        //     break;
        // }
        // // 仿真过程
        // dut->reset = 0;
        // dut->S = count;       // 模块S输出递增
        // dut->clock = ~dut->clock;
        // // dut->eval();          // 仿真时间步进 /// Evaluate the model.  Application must call when inputs change.
        // // mTracer->dump(main_time); // 波形文件写入步进
        // // dut->clock = 1;
        // dut->eval();          // 仿真时间步进 /// Evaluate the model.  Application must call when inputs change.
        // mTracer->dump(main_time); // 波形文件写入步进
        // // 可能在dump()中， main_time代表的是当前步的时刻, dump(main_time)是记录下此刻的各个信号的值
        // // 源代码(在verilated_vcs_c.h中)声明如下
        // // // Inside dumping routines, called each cycle to make the dump
        // // void dump     (vluint64_t timeui);
        // count++;
        // main_time++;
        // std::cout<<std::endl;
        // std::cout<<std::endl;
        // std::cout<<std::endl;
        // printf("dut->s is %x dut->out is %x count is %d\n",dut->Decoder__DOT__mEmpty__DOT__acer,dut->out,count);

        // main_time++;
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
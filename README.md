如何使用
============
[toc]

# 0 运行机制简介
## 0.1 目录结构
```shell
    .
    ├── build.sbt
    ├── makefile
    ├── README.md
    ├── scalastyle-config.xml
    ├── scalastyle-test-config.xml
    ├── src
    │   └── main
    │       ├── resources # 黑盒的外部verilog代码置于此
    │       └── scala # chisel源代码置于此目录下
    ├── target
    └── testbench # 测试相关都置于此目录下
        ├── BlackBoxInlineDemo 
        │   ├── csrc # verilator生成的各种源代码、makefile都置于此目录下
        │   ├── emu-BlackBoxInlineDemo.out # verilator 仿真用可执行文件
        │   ├── tb.cpp # cpp testbench
        │   ├── tb.vcd # 可执行文件运行生成的波形
        │   └── vsrc # chisel生成的verilog文件和一些中间文件置于此
        ├── BlackBoxResourceDemo
        │   ├── csrc
        │   ├── emu-BlackBoxResourceDemo.out
        │   ├── tb.cpp
        │   └── vsrc
        └── TriOctDecoderDemo
            ├── csrc
            ├── emu-TriOctDecoderDemo.out
            ├── tb.cpp
            ├── tb.vcd
            └── vsrc
```

## 0.2 命名规范
为方便开发，规定每个scala文件中的最上层类(也即单例对象)的名称需要与scala文件名一致，由此可自动化地生成一系列的测试文件、可执行文件等

## 0.3 运行过程
如下以DeviceUnderTest代指待测模块
DeviceUnderTest.scala代码内的内容
```scala
/*其他代码*/
class DeviceUnderTest extends Module {
    val io = IO(new Bundle {
        val in = Input(UInt(3.W))
        val out = Output(UInt(8.W))
    })
    /*其他代码*/
}
// 此单例对象用于生成verilog
object DeviceUnderTest extends App {
    chisel3.Driver.execute(args, () => new DeviceUnderTest)
}
```
在命令行中运行：
```shell
make DUT=DeviceUnderTest exe
```
然后会依次：
1. 创建 testbench/DeviceUnderTest/csrc 和 testbench/DeviceUnderTest/vsrc 目录
2. 将chisel编译，生成verilog到 testbench/DeviceUnderTest/vsrc
3. (若已存在testbench/DeviceUnderTest/tb.cpp) verilator 编译生成相关cpp和makefile到 testbench/DeviceUnderTest/csrc
4. 运行 testbench/DeviceUnderTest/csrc/VDeviceUnderTest.mk 生成 emu-DeviceUnderTest.out 到testbench/DeviceUnderTest/
```shell
    ├── src
    │   └── main
    │       ├── resources # 黑盒的外部verilog代码置于此
    │       └── scala # chisel源代码置于此目录下
    │           └── DeviceUnderTest.scala # chisel源代码
    ├── target
    └── testbench # 测试相关都置于此目录下
        └── DeviceUnderTest
            ├── csrc # verilator生成的各种源代码、makefile都置于此目录下
            ├── emu-DeviceUnderTest.out # verilator 仿真用可执行文件
            ├── tb.cpp
            ├── tb.vcd
            └── vsrc
```

# 1 scala代码中加入生成verilog相关语句
以[TriOctDecoderDemo.scala](./src/main/scala/TriOctDecoderDemo.scala)为例：
```scala
class TriOctDecoderDemo extends Module {
    val io = IO(new Bundle {
        val in = Input(UInt(3.W))
        val out = Output(UInt(8.W))
    })
    io.out := "b0001_0001".U(8.W)
    val mTriOct = Module(new TriOctDecoder)
    mTriOct.io.in := io.in
    io.out := mTriOct.io.out
}

// 此单例对象用于生成verilog
object TriOctDecoderDemo extends App {
    chisel3.Driver.execute(args, () => new TriOctDecoderDemo)
}
```

# 2 编译目标说明
编译目标有一个依赖链，可用以增量编译，比如：
- 若scala代码有相关改动，且希望运行新的仿真
    ```shell
    make DUT=TriOctDecoderDemo run
    ```
    运行以上指令，会从sbt开始，自动编译生成相关文件，完事后运行仿真可执行文件

- 若scala代码无改动，改动了tb.cpp 且希望运行新的仿真
    ```shell
    make DUT=TriOctDecoderDemo run
    ```
    运行以上指令，会跳过verilog生成，从生成cpp开始，自动编译生成相关文件，完事后运行仿真可执行文件


以[TriOctDecoderDemo.scala](./src/main/scala/TriOctDecoderDemo.scala)为例

### **verilog**
```shell
make DUT=TriOctDecoderDemo verilog
```
由chisel生成verilog，即TriOctDecoderDemo.v ，到 testbench/TriOctDecoderDemo/vsrc

### **cpp**
```shell
make DUT=TriOctDecoderDemo cpp
```
若已存在testbench/TriOctDecoderDemo/tb.cpp，由verilog生成相关cpp文件及makefile文件；若无若已存在testbench/TriOctDecoderDemo/tb.cpp 则报错

### **exe**
```shell
make DUT=TriOctDecoderDemo exe
```
运行 testbench/TriOctDecoderDemo/csrc/VTriOctDecoderDemo.mk 生成 emu-TriOctDecoderDemo.out 到testbench/TriOctDecoderDemo/ 根目录下

### **run**
```shell
make DUT=TriOctDecoderDemo run
```
运行 testbench/TriOctDecoderDemo/emu-TriOctDecoderDemo.out，相关波形文件生成路径在tb.cpp中设置

### **wave**
```shell
make DUT=TriOctDecoderDemo wave
```
查看波形，这个比较随意，可根据需要修改

### **clean**
```shell
make DUT=TriOctDecoderDemo clean
```
删除：
- testbench/TriOctDecoderDemo/vsrcTriOctDecoderDemo.v
- testbench/TriOctDecoderDemo/csrc/VTriOctDecoderDemo.cpp
- testbench/TriOctDecoderDemo/emu-TriOctDecoderDemo.out




# 3 特殊情况的处理

## Nothing to be done for XXXX
例如黑盒类的外部verilog文件不在增量编译的监控范围内，若外部verilog文件发生改动，不会触发增量编译，编译的结果是滞后的。故需要 clean 一下 删除中间文件，再次运行相应的指令即可
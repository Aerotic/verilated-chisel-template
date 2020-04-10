import chisel3._
import chisel3.util._
import chisel3.experimental._ // To enable experimental features


// module名必须与class名一致，区分大小写
class TriOctDecoder_Verilog extends BlackBox with HasBlackBoxResource{
    val io = IO(new Bundle() {
        val ver_in = Input(UInt(3.W)) // 这个名必须与verilog中的名字一致
        val ver_out = Output(UInt(8.W))
    })
    addResource("/TriOctDecoder_Verilog.v") // 添加源文件,路径root在test/resources内
//   setResource("/MVER1.v") 上下两种皆可，但在chisel3.2之后只能用上边那种
}

class TriOctDecoder extends Module {
    val mCR = Module(new CR())
    val testReg = Reg(UInt(8.W))
    testReg := "b1000_0001".U(8.W)
    val io = IO(new Bundle {
                val in = Input(UInt(3.W))
                val out = Output(UInt(8.W))
                })
    testReg := testReg + io.in
    mCR.io.in := io.in
    io.out := "b0000_0000".U(8.W) // io.out初始化赋值，无此则报错
    switch (io.in){
        is ("b000".U(3.W)){
            io.out := "b0000_0001".U(8.W) + testReg
        }
        is ("b001".U(3.W)){
            io.out := "b0000_0010".U(8.W)
        }
        is ("b010".U(3.W)){
            io.out := "b0000_0100".U(8.W)
        }
        is ("b011".U(3.W)){
            io.out := "b0000_1000".U(8.W)
        }
        is ("b100".U(3.W)){
            io.out := "b0001_0000".U(8.W)
        }
        is ("b101".U(3.W)){
            io.out := "b0010_0000".U(8.W)
        }
        is ("b110".U(3.W)){
            io.out := "b0100_0000".U(8.W)
        }
        is ("b111".U(3.W)){
            io.out := "b1000_0000".U(8.W)
        }
    }
}


class CR extends Module {
    val io = IO(new Bundle {
        // val mclk = Input(Clock())
        val in = Input(UInt(3.W))
        val out = Output(UInt(8.W))
    })
    
    // val cnt = Reg(UInt(8.W))
    // cnt := "b0000_0000".U(8.W)
    io.out := "b1000_1000".U(8.W)

}

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
object TriOctDecoderDemo extends App {
    chisel3.Driver.execute(args, () => new TriOctDecoderDemo)
}
import chisel3._
import chisel3.util._
// import chisel3.experimental._ // To enable experimental features

// module名必须与class名一致，区分大小写
class BlackBoxResource extends BlackBox with HasBlackBoxResource{
    val io = IO(new Bundle() {
        val in = Input(UInt(3.W))
        val out = Output(UInt(8.W))
        val cnt = Output(UInt(8.W))
        val clk = Input(Clock())
    })
    addResource("/BlackBoxResource.v") // 添加源文件,路径root在main/resources内
    // setResource("/BlackBoxResource.v") 上下两种皆可，但在chisel3.2之后只能用上边那种
}
class BlackBoxResourceDemo extends Module {
    val io = IO(new Bundle {
        val in = Input(UInt(3.W))
        val out = Output(UInt(8.W))
    })
    val mBlackBoxResource = Module(new BlackBoxResource)
    mBlackBoxResource.io.in := io.in
    mBlackBoxResource.io.clk := clock
    io.out := mBlackBoxResource.io.out
}
object BlackBoxResourceDemo extends App {
    chisel3.Driver.execute(args, () => new BlackBoxResourceDemo)
}
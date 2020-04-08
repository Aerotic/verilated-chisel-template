import chisel3._
import chisel3.util._
// import chisel3.experimental._ // To enable experimental features

// module名必须与class名一致，区分大小写
class BlackBoxInline extends BlackBox with HasBlackBoxInline{
    val io = IO(new Bundle() {
        val in = Input(UInt(3.W))
        val out = Output(UInt(8.W))
        val cnt = Output(UInt(8.W))
        val clk = Input(Clock())
    })
    setInline("BlackBoxInline.v",    // 运行过程中会在输出文件夹中生成以此命名的verilog文件
    s"""
        |module BlackBoxInline(
        |    input [2:0] in,
        |    output reg [7:0] out,
        |    output reg[7:0] cnt,
        |    input clk
        |);
        |initial cnt = 8'b0000_0001;
        |always @(negedge clk) begin
        |    cnt <= cnt + 8'b0000_0001;
        |end
        |always @(posedge clk) begin
        |   case (in) 
        |       3'b000: out = 8'b0000_0001;
        |       3'b001: out = 8'b0000_0010;
        |       3'b010: out = 8'b0000_0100;
        |       3'b011: out = 8'b0000_1000;
        |       3'b100: out = 8'b0001_0000;
        |       3'b101: out = 8'b0010_0000;
        |       3'b110: out = 8'b0100_0000;
        |       3'b111: out = 8'b1000_0000;        
        |       default:  out = 8'b0000_0001;
        |   endcase
        |end
        |endmodule // mver
    """.stripMargin)
}
class BlackBoxInlineDemo extends Module {
    val io = IO(new Bundle {
        val in = Input(UInt(3.W))
        val out = Output(UInt(8.W))
    })
    val mBlackBoxInline = Module(new BlackBoxInline)
    mBlackBoxInline.io.in := io.in
    mBlackBoxInline.io.clk := clock
    io.out := mBlackBoxInline.io.out
// val mverm = Module(new M_BlackBoxInline())
//   io.out := "b0001_0001".U(8.W)
//   val mBram = Module(new CR)
//   val mTriOct = Module(new TriOctDecoder)
//   mTriOct.io.in := io.in
//   mBram.io.in := io.in
//   io.out := mTriOct.io.out
//   // printf(p"\n\nwoc\n ${Hexadecimal(mTriOct.io.out)}\n\n")

//   // mTriOct.io.in := io.in

}
object BlackBoxInlineDemo extends App {
  chisel3.Driver.execute(args, () => new BlackBoxInlineDemo)
}
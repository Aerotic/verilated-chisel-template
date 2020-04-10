module BlackBoxResourceDemo(
  input        clock,
  input        reset,
  input  [2:0] io_in,
  output [7:0] io_out
);
  wire [2:0] mBlackBoxResource_in; // @[BlackBoxResourceDemo.scala 21:35]
  wire [7:0] mBlackBoxResource_out; // @[BlackBoxResourceDemo.scala 21:35]
  wire [7:0] mBlackBoxResource_cnt; // @[BlackBoxResourceDemo.scala 21:35]
  wire  mBlackBoxResource_clk; // @[BlackBoxResourceDemo.scala 21:35]
  BlackBoxResource mBlackBoxResource ( // @[BlackBoxResourceDemo.scala 21:35]
    .in(mBlackBoxResource_in),
    .out(mBlackBoxResource_out),
    .cnt(mBlackBoxResource_cnt),
    .clk(mBlackBoxResource_clk)
  );
  assign io_out = mBlackBoxResource_out; // @[BlackBoxResourceDemo.scala 24:12]
  assign mBlackBoxResource_in = io_in; // @[BlackBoxResourceDemo.scala 22:29]
  assign mBlackBoxResource_clk = clock; // @[BlackBoxResourceDemo.scala 23:30]
endmodule

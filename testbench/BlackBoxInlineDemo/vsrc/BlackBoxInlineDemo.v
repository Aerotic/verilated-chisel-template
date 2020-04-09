module BlackBoxInlineDemo(
  input        clock,
  input        reset,
  input  [2:0] io_in,
  output [7:0] io_out
);
  wire [2:0] mBlackBoxInline_in; // @[BlackBoxInlineDemo.scala 46:33]
  wire [7:0] mBlackBoxInline_out; // @[BlackBoxInlineDemo.scala 46:33]
  wire [7:0] mBlackBoxInline_cnt; // @[BlackBoxInlineDemo.scala 46:33]
  wire  mBlackBoxInline_clk; // @[BlackBoxInlineDemo.scala 46:33]
  BlackBoxInline mBlackBoxInline ( // @[BlackBoxInlineDemo.scala 46:33]
    .in(mBlackBoxInline_in),
    .out(mBlackBoxInline_out),
    .cnt(mBlackBoxInline_cnt),
    .clk(mBlackBoxInline_clk)
  );
  assign io_out = mBlackBoxInline_out; // @[BlackBoxInlineDemo.scala 49:12]
  assign mBlackBoxInline_in = io_in; // @[BlackBoxInlineDemo.scala 47:27]
  assign mBlackBoxInline_clk = clock; // @[BlackBoxInlineDemo.scala 48:28]
endmodule

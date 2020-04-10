module TriOctDecoder(
  input        clock,
  input  [2:0] io_in,
  output [7:0] io_out
);
  reg [7:0] testReg; // @[TriOctDecoderDemo.scala 18:22]
  reg [31:0] _RAND_0;
  wire [7:0] _GEN_8; // @[TriOctDecoderDemo.scala 24:24]
  wire  _T_2; // @[Conditional.scala 37:30]
  wire [7:0] _T_4; // @[TriOctDecoderDemo.scala 29:43]
  wire  _T_5; // @[Conditional.scala 37:30]
  wire  _T_6; // @[Conditional.scala 37:30]
  wire  _T_7; // @[Conditional.scala 37:30]
  wire  _T_8; // @[Conditional.scala 37:30]
  wire  _T_9; // @[Conditional.scala 37:30]
  wire  _T_10; // @[Conditional.scala 37:30]
  wire  _T_11; // @[Conditional.scala 37:30]
  wire [7:0] _GEN_0; // @[Conditional.scala 39:67]
  wire [7:0] _GEN_1; // @[Conditional.scala 39:67]
  wire [7:0] _GEN_2; // @[Conditional.scala 39:67]
  wire [7:0] _GEN_3; // @[Conditional.scala 39:67]
  wire [7:0] _GEN_4; // @[Conditional.scala 39:67]
  wire [7:0] _GEN_5; // @[Conditional.scala 39:67]
  wire [7:0] _GEN_6; // @[Conditional.scala 39:67]
  assign _GEN_8 = {{5'd0}, io_in}; // @[TriOctDecoderDemo.scala 24:24]
  assign _T_2 = 3'h0 == io_in; // @[Conditional.scala 37:30]
  assign _T_4 = 8'h1 + testReg; // @[TriOctDecoderDemo.scala 29:43]
  assign _T_5 = 3'h1 == io_in; // @[Conditional.scala 37:30]
  assign _T_6 = 3'h2 == io_in; // @[Conditional.scala 37:30]
  assign _T_7 = 3'h3 == io_in; // @[Conditional.scala 37:30]
  assign _T_8 = 3'h4 == io_in; // @[Conditional.scala 37:30]
  assign _T_9 = 3'h5 == io_in; // @[Conditional.scala 37:30]
  assign _T_10 = 3'h6 == io_in; // @[Conditional.scala 37:30]
  assign _T_11 = 3'h7 == io_in; // @[Conditional.scala 37:30]
  assign _GEN_0 = _T_11 ? 8'h80 : 8'h0; // @[Conditional.scala 39:67]
  assign _GEN_1 = _T_10 ? 8'h40 : _GEN_0; // @[Conditional.scala 39:67]
  assign _GEN_2 = _T_9 ? 8'h20 : _GEN_1; // @[Conditional.scala 39:67]
  assign _GEN_3 = _T_8 ? 8'h10 : _GEN_2; // @[Conditional.scala 39:67]
  assign _GEN_4 = _T_7 ? 8'h8 : _GEN_3; // @[Conditional.scala 39:67]
  assign _GEN_5 = _T_6 ? 8'h4 : _GEN_4; // @[Conditional.scala 39:67]
  assign _GEN_6 = _T_5 ? 8'h2 : _GEN_5; // @[Conditional.scala 39:67]
  assign io_out = _T_2 ? _T_4 : _GEN_6; // @[TriOctDecoderDemo.scala 26:12 TriOctDecoderDemo.scala 29:20 TriOctDecoderDemo.scala 32:20 TriOctDecoderDemo.scala 35:20 TriOctDecoderDemo.scala 38:20 TriOctDecoderDemo.scala 41:20 TriOctDecoderDemo.scala 44:20 TriOctDecoderDemo.scala 47:20 TriOctDecoderDemo.scala 50:20]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  testReg = _RAND_0[7:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`endif // SYNTHESIS
  always @(posedge clock) begin
    testReg <= testReg + _GEN_8;
  end
endmodule
module TriOctDecoderDemo(
  input        clock,
  input        reset,
  input  [2:0] io_in,
  output [7:0] io_out
);
  wire  mTriOct_clock; // @[TriOctDecoderDemo.scala 75:25]
  wire [2:0] mTriOct_io_in; // @[TriOctDecoderDemo.scala 75:25]
  wire [7:0] mTriOct_io_out; // @[TriOctDecoderDemo.scala 75:25]
  TriOctDecoder mTriOct ( // @[TriOctDecoderDemo.scala 75:25]
    .clock(mTriOct_clock),
    .io_in(mTriOct_io_in),
    .io_out(mTriOct_io_out)
  );
  assign io_out = mTriOct_io_out; // @[TriOctDecoderDemo.scala 74:12 TriOctDecoderDemo.scala 77:12]
  assign mTriOct_clock = clock;
  assign mTriOct_io_in = io_in; // @[TriOctDecoderDemo.scala 76:19]
endmodule

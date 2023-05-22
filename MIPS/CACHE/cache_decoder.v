module cache_decoder(clk, address, tag, index, blk_offset);
    input clk;
    input [31:0] address;

    output reg [24:0] tag;
    output reg [2:0] index;
    output reg [1:0] blk_offset;

    always@(posedge clk)
    begin
        tag <= address[31:7];
        index <= address[6:4];
        blk_offset <= address[3:2];
    end
endmodule
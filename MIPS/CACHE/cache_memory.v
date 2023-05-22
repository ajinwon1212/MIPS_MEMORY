`define BLOCKS 8
`define WORDS 4
`define SIZE 32
`define BLOCK_SIZE 128


module cache_memory(clk,address,read,dataIn,dataOut,hit);

    input clk;
    input [31:0] address;
    input read;
    input [`BLOCK_SIZE-1:0] dataIn;

    output reg hit;
    output reg [31:0] dataOut;

    reg [`BLOCK_SIZE+25:0] buffer;
    reg [2:0] index;
    reg [1:0] blockOffset;
    reg [`BLOCK_SIZE+25:0] cache [`BLOCKS-1:0];

    always@(posedge clk)
    begin
        index = address[6:4];
        blockOffset = address[3:2];
        if(read == 0) begin
            buffer[0] = 1;
            buffer[25:1] = address[31:7];
            buffer[153:26] = dataIn;
            cache[index] = buffer;
            dataOut = cache[index][32*blockOffset+26+31-:32];
            hit = 1;
        end
        if(read == 1) begin
            if(address[31:7] == cache[index][25:1]) begin
                hit = 1;
            end
            else begin
                hit = 0;
            end
            // hit = 0;
            dataOut = cache[index][32*blockOffset+26+31-:32];
        end
        else begin
            hit = 1;
        end
    end

endmodule















    // input clk,
    // input mode,
    // input [7:0] index,
    // input [3:0] blkOffset,
    // input [19:0] tagin,
    // input [`SIZE*`WORDS-1:0] datain,
    // output reg [`SIZE-1:0] dataout,
    // output reg [19:0] tagout,
    // output reg valid
    // );

    // reg[`BLOCKS-1:0] cache [`WORDS*`SIZE+20:0];

    // reg [532:0] out;

    // always @(posedge clk)
    //     begin
    //     if(mode == 1)
    //         begin
    //             out[0] <= 1;
    //             out[20:1] <= tagin;
    //             out[532:21] <= datain;
    //             cache[index] <= out;
    //         end
    //     else
    //         begin
    //             out <= cache[index];
    //             valid <= out[0];
    //             dataout = out[32*(blkOffset)+:32];
    //             tagout <= out[20:1];
    //         end
    //     end

// endmodule
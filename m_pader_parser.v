module m_pader_parser(
    input clk, rst,
    input byte_rdy, byte_stop,
    input [7:0] data_in,
    output reg overflow_err, flag_0_15,
    output reg [31:0] padd_out,
    output reg padding_done,
    output reg strt_a_h
);
    reg [7:0] block_512 [0:63];
    reg [6:0] add_512_block;
    reg [63:0] m_size;
    reg [6:0] add_out0, add_out1, add_out2, add_out3;
    reg temp_chk;
    integer i;

    always @(posedge clk) begin
        if (!rst) begin
            add_512_block <= 0;
            m_size <= 0;
            padding_done <= 0;
            padd_out <= 0;
            overflow_err <= 0;
            temp_chk <= 0;
            flag_0_15 <= 0;
            strt_a_h <= 0;
            add_out0 <= 0; add_out1 <= 1; add_out2 <= 2; add_out3 <= 3;
            for (i = 0; i < 64; i = i + 1)
                block_512[i] <= 8'd0;
        end else begin
            if (byte_rdy) begin
                block_512[add_512_block] <= data_in;
                add_512_block <= add_512_block + 1;
            end else if (byte_stop) begin
                if (!temp_chk) begin
                    m_size = add_512_block * 8;
                    block_512[add_512_block] = 8'h80;
                    add_512_block = add_512_block + 1;
                    temp_chk = 1;
                end

                if (add_512_block < 56) begin
                    for (i = add_512_block; i < 56; i = i + 1)
                        block_512[i] = 8'd0;

                    // Append message size (big endian)
                    block_512[56] = m_size[63:56];
                    block_512[57] = m_size[55:48];
                    block_512[58] = m_size[47:40];
                    block_512[59] = m_size[39:32];
                    block_512[60] = m_size[31:24];
                    block_512[61] = m_size[23:16];
                    block_512[62] = m_size[15:8];
                    block_512[63] = m_size[7:0];

                    padding_done <= 1;
                    strt_a_h <= 1;
                end else begin
                    overflow_err <= 1;
                    padding_done <= 0;
                end
            end

            if (padding_done) begin
                if (add_out3 < 64) begin
                    padd_out[31:24] = block_512[add_out0];
                    padd_out[23:16] = block_512[add_out1];
                    padd_out[15:8]  = block_512[add_out2];
                    padd_out[7:0]   = block_512[add_out3];
                    add_out0 = add_out0 + 4;
                    add_out1 = add_out1 + 4;
                    add_out2 = add_out2 + 4;
                    add_out3 = add_out3 + 4;
                end else begin
                    flag_0_15 <= 1;
                end
            end
        end
    end
endmodule

module interative_processing(
    input clk, rst, padding_done,
    input [6:0] counter_iteration,
    input [31:0] w, k,
    output reg [31:0] a_out, b_out, c_out, d_out, e_out, f_out, g_out, h_out
);
    reg [31:0] t1, t2;
    wire [31:0] ep0, ep1, ch, maj;

    assign ep0 = ({a_out[1:0], a_out[31:2]} ^ {a_out[12:0], a_out[31:13]} ^ {a_out[21:0], a_out[31:22]});
    assign ep1 = ({e_out[5:0], e_out[31:6]} ^ {e_out[10:0], e_out[31:11]} ^ {e_out[24:0], e_out[31:25]});
    assign ch = (e_out & f_out) ^ (~e_out & g_out);
    assign maj = (a_out & b_out) ^ (a_out & c_out) ^ (b_out & c_out);

    always @(posedge clk) begin
        if (!rst) begin
            a_out <= 32'h6a09e667;
            b_out <= 32'hbb67ae85;
            c_out <= 32'h3c6ef372;
            d_out <= 32'ha54ff53a;
            e_out <= 32'h510e527f;
            f_out <= 32'h9b05688c;
            g_out <= 32'h1f83d9ab;
            h_out <= 32'h5be0cd19;
        end else if (padding_done && counter_iteration < 64) begin
            t1 = h_out + ep1 + ch + k + w;
            t2 = ep0 + maj;
            
            h_out <= g_out;
            g_out <= f_out;
            f_out <= e_out;
            e_out <= d_out + t1;
            d_out <= c_out;
            c_out <= b_out;
            b_out <= a_out;
            a_out <= t1 + t2;
        end
    end
endmodule

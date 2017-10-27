module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);
    output [63:0] BusA, BusB;
    input [63:0] BusW;
    input [4:0] RA, RB, RW;
    input RegWr, Clk;

    reg [31:0] register;

    always @(posedge Clk)
        register[31] <= 0;
    
    assign #2 BusA = register[RA];
    assign #2 BusB = register[RAB;

    always @(negedge Clk)
        if(RegWr && RW != 31)
        register[RW] <= #3 BusW;
endmodule
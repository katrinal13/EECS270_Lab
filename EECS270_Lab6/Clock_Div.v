// Clocking
// Clock Divider by Powers of 2 (Table of frequencies and periods at EOF)
module Clock_Div
	#(parameter SIZE = 36)	// divides by 2^i for i = 0 to i = 36
	(
		input CLK_in,
		output [SIZE:0] CLKS_out
	);
	
	reg [SIZE:1] Counter;
	initial Counter = 'd0;
	
	always @(posedge CLK_in)
		Counter <= Counter + 1;

	assign CLKS_out = {Counter, CLK_in};
endmodule // Clock_Div


/* Clock frequency and period
   for a 12 MHz input clock (HAILBoard)

                   Frequency          Period
________________________________________________
CLKS_out[0]        12.00 MHz          83.33 ns
CLKS_out[1]         6.00 MHz         166.67 ns
CLKS_out[2]         3.00 MHz         333.33 ns
CLKS_out[3]         1.50 MHz         666.67 ns
CLKS_out[4]       750.00 kHz           1.33 us
CLKS_out[5]       375.00 kHz           2.67 us
CLKS_out[6]       187.50 kHz           5.33 us
CLKS_out[7]        93.75 kHz          10.67 us
CLKS_out[8]        46.88 kHz          21.33 us
CLKS_out[9]        23.44 kHz          42.67 us
CLKS_out[10]       11.72 kHz          85.33 us
CLKS_out[11]        5.86 kHz         170.67 us
CLKS_out[12]        2.93 kHz         341.33 us
CLKS_out[13]        1.46 kHz         682.67 us
CLKS_out[14]      732.42 Hz            1.37 ms
CLKS_out[15]      366.21 Hz            2.73 ms
CLKS_out[16]      183.11 Hz            5.46 ms
CLKS_out[17]       91.55 Hz           10.92 ms
CLKS_out[18]       45.78 Hz           21.85 ms
CLKS_out[19]       22.89 Hz           43.69 ms
CLKS_out[20]       11.44 Hz           87.38 ms
CLKS_out[21]        5.72 Hz          174.76 ms
CLKS_out[22]        2.86 Hz          349.53 ms
CLKS_out[23]        1.43 Hz          699.05 ms
CLKS_out[24]      715.26 mHz           1.40 s
CLKS_out[25]      357.63 mHz           2.80 s
CLKS_out[26]      178.81 mHz           5.59 s
CLKS_out[27]       89.41 mHz          11.18 s
CLKS_out[28]       44.70 mHz          22.37 s
CLKS_out[29]       22.35 mHz          44.74 s
CLKS_out[30]       11.18 mHz           1.49 min
CLKS_out[31]        5.59 mHz           2.98 min
CLKS_out[32]        2.79 mHz           5.97 min
CLKS_out[33]        1.40 mHz          11.93 min
CLKS_out[34]      698.49 uHz          23.86 min
CLKS_out[35]      349.25 uHz          47.72 min
CLKS_out[36]      174.62 uHz          95.44 min

*/
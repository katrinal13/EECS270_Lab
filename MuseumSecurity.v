module Museum_Security(
    input  D,
    input  V,
    input  M,
    input  H,
    output A
);

assign A = (H & (D | V | M)) | (D & V);


endmodule

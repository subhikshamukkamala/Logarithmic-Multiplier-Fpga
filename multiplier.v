      
module LPPG( 
    input [9:0] B0, 
    input [15:0] Y, 
    output [24:0] PP01, 
    output [24:0] PP02 
); 
 
    wire[9:0] pos_B0, mod_B0, B00, SB00; 
    wire [15:0] pos_Y, mod_Y, SY; 
    wire [3:0] enc_b0, enc_Y; 
    wire sign, msb_B0, msb_Y; 
    assign msb_B0 = B0[9];   
    assign msb_Y = Y[15];   
    xor (sign, msb_B0, msb_Y); 
 
 
    xor (mod_B0[9], B0[9], msb_B0); 
    xor (mod_B0[8], B0[8], msb_B0); 
    xor (mod_B0[7], B0[7], msb_B0); 
    xor (mod_B0[6], B0[6], msb_B0); 
    xor (mod_B0[5], B0[5], msb_B0); 
    xor (mod_B0[4], B0[4], msb_B0); 
    xor (mod_B0[3], B0[3], msb_B0); 
    xor (mod_B0[2], B0[2], msb_B0); 
    xor (mod_B0[1], B0[1], msb_B0); 
    xor (mod_B0[0], B0[0], msb_B0); 
 
    xor (B00[9], mod_B0[9], pos_B0[9]); 
    xor (B00[8], mod_B0[8], pos_B0[8]); 
    xor (B00[7], mod_B0[7], pos_B0[7]); 
    xor (B00[6], mod_B0[6], pos_B0[6]); 
 
    xor (B00[5], mod_B0[5], pos_B0[5]); 
    xor (B00[4], mod_B0[4], pos_B0[4]); 
    xor (B00[3], mod_B0[3], pos_B0[3]); 
    xor (B00[2], mod_B0[2], pos_B0[2]); 
    xor (B00[1], mod_B0[1], pos_B0[1]); 
    xor (B00[0], mod_B0[0], pos_B0[0]); 
 
    xor (mod_Y[15], Y[15], msb_Y); 
    xor (mod_Y[14], Y[14], msb_Y); 
    xor (mod_Y[13], Y[13], msb_Y); 
    xor (mod_Y[12], Y[12], msb_Y); 
    xor (mod_Y[11], Y[11], msb_Y); 
    xor (mod_Y[10], Y[10], msb_Y); 
    xor (mod_Y[9], Y[9], msb_Y); 
    xor (mod_Y[8], Y[8], msb_Y); 
    xor (mod_Y[7], Y[7], msb_Y); 
    xor (mod_Y[6], Y[6], msb_Y); 
    xor (mod_Y[5], Y[5], msb_Y); 
    xor (mod_Y[4], Y[4], msb_Y); 
    xor (mod_Y[3], Y[3], msb_Y); 
    xor (mod_Y[2], Y[2], msb_Y); 
    xor (mod_Y[1], Y[1], msb_Y); 
    xor (mod_Y[0], Y[0], msb_Y); 
 
    xor (SY[15], mod_Y[15], sign); 
    xor (SY[14], mod_Y[14], sign); 
    xor (SY[13], mod_Y[13], sign); 
    xor (SY[12], mod_Y[12], sign); 
    xor (SY[11], mod_Y[11], sign); 
    xor (SY[10], mod_Y[10], sign); 
    xor (SY[9], mod_Y[9], sign); 
    xor (SY[8], mod_Y[8], sign); 
    xor (SY[7], mod_Y[7], sign); 
    xor (SY[6], mod_Y[6], sign); 
    xor (SY[5], mod_Y[5], sign); 
    xor (SY[4], mod_Y[4], sign); 
    xor (SY[3], mod_Y[3], sign); 
    xor (SY[2], mod_Y[2], sign); 
    xor (SY[1], mod_Y[1], sign); 
    xor (SY[0], mod_Y[0], sign); 
 
    xor (SB00[9], B00[9], sign); 
    xor (SB00[8], B00[8], sign); 
    xor (SB00[7], B00[7], sign); 
    xor (SB00[6], B00[6], sign); 
    xor (SB00[5], B00[5], sign); 
    xor (SB00[4], B00[4], sign); 
    xor (SB00[3], B00[3], sign); 
    xor (SB00[2], B00[2], sign); 
    xor (SB00[1], B00[1], sign); 
    xor (SB00[0], B00[0], sign); 
 
    LOD_10bit lod_B0(.in(mod_B0), .g(pos_B0)); 
    LOD_16bit lod_y(.in(mod_Y), .g(pos_Y)); 
 
    priority_encoder_10bit pe_B0(.in(pos_B0), .enc(enc_b0)); 
    priority_encoder_16bit pe_Y(.in(pos_Y), .enc(enc_Y)); 
 
 
  d10barrel_shifter bp1(enc_Y,SB00,PP02); 
   
  d16barrel_shifter bp2(enc_b0,SY,PP01); 
Endmodule 
 
 

module LOD_10bit ( 
    input  [9:0] in, 
    output [9:0] g 
); 
 
    wire [9:0] in_not; 
    not (in_not[9],  in[9]); 
    not (in_not[8],  in[8]); 
    not (in_not[7],  in[7]); 
    not (in_not[6],  in[6]); 
    not (in_not[5],  in[5]); 
    not (in_not[4],  in[4]); 
    not (in_not[3],  in[3]); 
    not (in_not[2],  in[2]); 
    not (in_not[1],  in[1]); 
    not (in_not[0],  in[0]); 
     
    assign g[9] = in[9]; 
    and (g[8], in_not[9], in[8]); 
    and (g[7], in_not[9], in_not[8], in[7]); 
    and (g[6], in_not[9], in_not[8], in_not[7], in[6]); 
    and (g[5], in_not[9], in_not[8], in_not[7], in_not[6], in[5]); 
    and (g[4], in_not[9], in_not[8], in_not[7], in_not[6], in_not[5], in[4]); 
    and (g[3], in_not[9], in_not[8], in_not[7], in_not[6], in_not[5], in_not[4], in[3]); 
    and (g[2], in_not[9], in_not[8], in_not[7], in_not[6], in_not[5], in_not[4], in_not[3], in[2]); 
    and (g[1], in_not[9], in_not[8], in_not[7], in_not[6], in_not[5], in_not[4], in_not[3], in_not[2], in[1]); 
    and (g[0], in_not[9], in_not[8], in_not[7], in_not[6], in_not[5], in_not[4], in_not[3], in_not[2], in_not[1], 
in[0]); 
Endmodule 
 
module LOD_16bit ( 
    input  [15:0] in, 
    output [15:0]g 
); 
 
 
    wire [15:0] in_not; 
    not (in_not[15], in[15]); 
    not (in_not[14], in[14]); 
    not (in_not[13], in[13]); 
    not (in_not[12], in[12]); 
    not (in_not[11], in[11]); 
    not (in_not[10], in[10]); 
    not (in_not[9],  in[9]); 
    not (in_not[8],  in[8]); 
    not (in_not[7],  in[7]); 
    not (in_not[6],  in[6]); 
    not (in_not[5],  in[5]); 
    not (in_not[4],  in[4]); 
    not (in_not[3],  in[3]); 
    not (in_not[2],  in[2]); 
    not (in_not[1],  in[1]); 
    not (in_not[0],  in[0]); 
 
    assign g[15] = in[15]; 
    and (g[14], in_not[15], in[14]); 
    and (g[13], in_not[15], in_not[14], in[13]); 
    and (g[12], in_not[15], in_not[14], in_not[13], in[12]); 
    and (g[11], in_not[15], in_not[14], in_not[13], in_not[12], in[11]); 
    and (g[10], in_not[15], in_not[14], in_not[13], in_not[12], in_not[11], in[10]); 
    and (g[9],  in_not[15], in_not[14], in_not[13], in_not[12], in_not[11], in_not[10], in[9]); 
    and (g[8],  in_not[15], in_not[14], in_not[13], in_not[12], in_not[11], in_not[10], in_not[9], in[8]); 
    and (g[7],  in_not[15], in_not[14], in_not[13], in_not[12], in_not[11], in_not[10], in_not[9], in_not[8], 
in[7]); 
    and (g[6],  in_not[15], in_not[14], in_not[13], in_not[12], in_not[11], in_not[10], in_not[9], in_not[8], 
in_not[7], in[6]); 
    and (g[5],  in_not[15], in_not[14], in_not[13], in_not[12], in_not[11], in_not[10], in_not[9], in_not[8], 
in_not[7], in_not[6], in[5]); 
    and (g[4],  in_not[15], in_not[14], in_not[13], in_not[12], in_not[11], in_not[10], in_not[9], in_not[8], 
in_not[7], in_not[6], in_not[5], in[4]); 
    and (g[3],  in_not[15], in_not[14], in_not[13], in_not[12], in_not[11], in_not[10], in_not[9], in_not[8], 
in_not[7], in_not[6], in_not[5], in_not[4], in[3]); 
    and (g[2],  in_not[15], in_not[14], in_not[13], in_not[12], in_not[11], in_not[10], in_not[9], in_not[8], 
in_not[7], in_not[6], in_not[5], in_not[4], in_not[3], in[2]); 
    and (g[1],  in_not[15], in_not[14], in_not[13], in_not[12], in_not[11], in_not[10], in_not[9], in_not[8], 
in_not[7], in_not[6], in_not[5], in_not[4], in_not[3], in_not[2], in[1]); 
    and (g[0],  in_not[15], in_not[14], in_not[13], in_not[12], in_not[11], in_not[10], in_not[9], in_not[8], 
in_not[7], in_not[6], in_not[5], in_not[4], in_not[3], in_not[2], in_not[1], in[0]); 
 
Endmodule 

module priority_encoder_10bit ( 
    input  [9:0] in, 
    output [3:0] enc 
); 
 
or(enc[3],in[9],in[8]); 
or(enc[2],in[4],in[5],in[6],in[7]); 
or(enc[1],in[2],in[3],in[6],in[7]); 
or(enc[0],in[1],in[3],in[5],in[7],in[9]); 
 
Endmodule 
 
module priority_encoder_16bit ( 
    input  [15:0] in, 
    output [3:0] enc 
); 
 
or(enc[3],in[8],in[9],in[10],in[11],in[12],in[13],in[14],in[15]); 
or(enc[2],in[4],in[5],in[6],in[7],in[12],in[13],in[14],in[15]); 
or(enc[1],in[2],in[3],in[6],in[7],in[10],in[11],in[14],in[15]); 
or(enc[0],in[1],in[3],in[5],in[7],in[9],in[11],in[13],in[15]); 
 
Endmodule 


module d10barrel_shifter( 
input [3:0]s,input [9:0]a,output [24:0]o 
    ); 
    wire [10:0]s0; 
    mux m1(1'b0,a[0],s[0],s0[0]); 
    mux m2(a[0],a[1],s[0],s0[1]); 
    mux m3(a[1],a[2],s[0],s0[2]); 
    mux m4(a[2],a[3],s[0],s0[3]); 
    mux m5(a[3],a[4],s[0],s0[4]); 
    mux m6 (a[4],a[5],s[0],s0[5]); 
    mux m7(a[5],a[6],s[0],s0[6]); 
    mux m8(a[6],a[7],s[0],s0[7]); 
    mux m9(a[7],a[8],s[0],s0[8]); 
    mux m10(a[8],a[9],s[0],s0[9]); 
    mux m11(a[9],1'b0,s[0],s0[10]); 
     
    wire[12:0]s1; 
     
    mux m12(1'b0,s0[0],s[1],s1[0]); 
    mux m13(1'b0,s0[1],s[1],s1[1]); 
    mux m14(s0[0],s0[2],s[1],s1[2]); 
    mux m15(s0[1],s0[3],s[1],s1[3]); 
    mux m16(s0[2],s0[4],s[1],s1[4]); 
    mux m17(s0[3],s0[5],s[1],s1[5]); 
    mux m18(s0[4],s0[6],s[1],s1[6]); 
    mux m19(s0[5],s0[7],s[1],s1[7]); 
    mux m20(s0[5],s0[8],s[1],s1[8]); 
    mux m21(s0[6],s0[9],s[1],s1[9]); 
    mux m22(s0[8],s0[10],s[1],s1[10]); 
    mux m23(s0[9],1'b0,s[1],s1[11]); 
    mux m24(s0[10],1'b0,s[1],s1[12]); 
      
    wire [16:0]s2; 
    mux m25(1'b0,s1[0],s[2],s2[0]); 
    mux m26(1'b0,s1[1],s[2],s2[1]); 
    mux m27(1'b0,s1[2],s[2],s2[2]); 
    mux m28(1'b0,s1[3],s[2],s2[3]); 
    mux m29(s1[0],s1[4],s[2],s2[4]); 
    mux m30(s1[1],s1[5],s[2],s2[5]); 
    mux m31(s1[2],s1[6],s[2],s2[6]); 
    mux m32(s1[3],s1[7],s[2],s2[7]); 
    mux m33(s1[4],s1[8],s[2],s2[8]); 
    mux m34(s1[5],s1[9],s[2],s2[9]); 
    mux m35(s1[6],s1[10],s[2],s2[10]); 
    mux m36(s1[7],s1[11],s[2],s2[11]); 
    mux m37(s1[8],s1[12],s[2],s2[12]); 
    mux m38(s1[9],1'b0,s[2],s2[13]); 
    mux m39(s1[10],1'b0,s[2],s2[14]); 
    mux m40(s1[11],1'b0,s[2],s2[15]); 
    mux m41(s1[12],1'b0,s[2],s2[16]); 
    mux m42(1'b0,s2[0],s[3],o[0]);
    mux m43(1'b0,s2[1],s[3],o[1]); 
    mux m44(1'b0,s2[2],s[3],o[2]); 
    mux m45(1'b0,s2[3],s[3],o[3]); 
    mux m46(1'b0,s2[4],s[3],o[4]); 
    mux m47(1'b0,s2[5],s[3],o[5]); 
    mux m48(1'b0,s2[6],s[3],o[6]); 
    mux m49(1'b0,s2[7],s[3],o[7]); 
    mux m50(s2[0],s2[8],s[3],o[8]); 
    mux m51(s2[1],s2[9],s[3],o[9]); 
    mux m52(s2[2],s2[10],s[3],o[10]); 
    mux m53(s2[3],s2[11],s[3],o[11]); 
    mux m54(s2[4],s2[12],s[3],o[12]); 
    mux m55(s2[5],s2[13],s[3],o[13]); 
    mux m56(s2[6],s2[14],s[3],o[14]); 
    mux m57(s2[7],s2[15],s[3],o[15]); 
    mux m58(s2[8],s2[16],s[3],o[16]); 
 
    mux m59(s2[9],1'b0,s[3],o[17]); 
    mux m60(s2[10],1'b0,s[3],o[18]); 
    mux m61(s2[11],1'b0,s[3],o[19]); 
    mux m62(s2[12],1'b0,s[3],o[20]); 
    mux m63(s2[13],1'b0,s[3],o[21]); 
    mux m64(s2[14],1'b0,s[3],o[22]); 
    mux m65(s2[15],1'b0,s[3],o[23]); 
    mux m66(s2[16],1'b0,s[3],o[24]); 
     
    Endmodule 
 
module d10barrel_shifter( 
input [3:0]s,input [9:0]a,output [24:0]o 
    ); 
    wire [10:0]s0; 
    mux m1(1'b0,a[0],s[0],s0[0]); 
    mux m2(a[0],a[1],s[0],s0[1]); 
    mux m3(a[1],a[2],s[0],s0[2]); 
    mux m4(a[2],a[3],s[0],s0[3]); 
    mux m5(a[3],a[4],s[0],s0[4]); 
    mux m6 (a[4],a[5],s[0],s0[5]); 
    mux m7(a[5],a[6],s[0],s0[6]); 
    mux m8(a[6],a[7],s[0],s0[7]); 
    mux m9(a[7],a[8],s[0],s0[8]); 
    mux m10(a[8],a[9],s[0],s0[9]); 
    mux m11(a[9],1'b0,s[0],s0[10]); 
     
    wire[12:0]s1; 
     
    mux m12(1'b0,s0[0],s[1],s1[0]); 
    mux m13(1'b0,s0[1],s[1],s1[1]); 
    mux m14(s0[0],s0[2],s[1],s1[2]); 
    mux m15(s0[1],s0[3],s[1],s1[3]); 
    mux m16(s0[2],s0[4],s[1],s1[4]); 
    mux m17(s0[3],s0[5],s[1],s1[5]); 
    mux m18(s0[4],s0[6],s[1],s1[6]); 
    mux m19(s0[5],s0[7],s[1],s1[7]); 
    mux m20(s0[5],s0[8],s[1],s1[8]); 
    mux m21(s0[6],s0[9],s[1],s1[9]); 
    mux m22(s0[8],s0[10],s[1],s1[10]); 
    mux m23(s0[9],1'b0,s[1],s1[11]); 
    mux m24(s0[10],1'b0,s[1],s1[12]); 
      
    wire [16:0]s2; 
    mux m25(1'b0,s1[0],s[2],s2[0]); 
    mux m26(1'b0,s1[1],s[2],s2[1]); 
    mux m27(1'b0,s1[2],s[2],s2[2]); 
    mux m28(1'b0,s1[3],s[2],s2[3]); 
    mux m29(s1[0],s1[4],s[2],s2[4]); 
    mux m30(s1[1],s1[5],s[2],s2[5]); 
    mux m31(s1[2],s1[6],s[2],s2[6]); 
    mux m32(s1[3],s1[7],s[2],s2[7]); 
    mux m33(s1[4],s1[8],s[2],s2[8]); 
    mux m34(s1[5],s1[9],s[2],s2[9]); 
    mux m35(s1[6],s1[10],s[2],s2[10]); 
    mux m36(s1[7],s1[11],s[2],s2[11]); 
    mux m37(s1[8],s1[12],s[2],s2[12]); 
    mux m38(s1[9],1'b0,s[2],s2[13]); 
    mux m39(s1[10],1'b0,s[2],s2[14]); 
    mux m40(s1[11],1'b0,s[2],s2[15]); 
    mux m41(s1[12],1'b0,s[2],s2[16]); 
     mux m42(1'b0,s2[0],s[3],o[0]); 
    mux m43(1'b0,s2[1],s[3],o[1]); 
    mux m44(1'b0,s2[2],s[3],o[2]); 
    mux m45(1'b0,s2[3],s[3],o[3]); 
    mux m46(1'b0,s2[4],s[3],o[4]); 
    mux m47(1'b0,s2[5],s[3],o[5]); 
    mux m48(1'b0,s2[6],s[3],o[6]); 
    mux m49(1'b0,s2[7],s[3],o[7]); 
    mux m50(s2[0],s2[8],s[3],o[8]); 
    mux m51(s2[1],s2[9],s[3],o[9]); 
    mux m52(s2[2],s2[10],s[3],o[10]); 
    mux m53(s2[3],s2[11],s[3],o[11]); 
    mux m54(s2[4],s2[12],s[3],o[12]); 
    mux m55(s2[5],s2[13],s[3],o[13]); 
    mux m56(s2[6],s2[14],s[3],o[14]); 
    mux m57(s2[7],s2[15],s[3],o[15]); 
    mux m58(s2[8],s2[16],s[3],o[16]); 
    mux m59(s2[9],1'b0,s[3],o[17]); 
    mux m60(s2[10],1'b0,s[3],o[18]); 
    mux m61(s2[11],1'b0,s[3],o[19]); 
    mux m62(s2[12],1'b0,s[3],o[20]); 
    mux m63(s2[13],1'b0,s[3],o[21]); 
    mux m64(s2[14],1'b0,s[3],o[22]); 
    mux m65(s2[15],1'b0,s[3],o[23]); 
    mux m66(s2[16],1'b0,s[3],o[24]); 
     
    Endmodule 
 
 
 
module d16barrel_shifter( 
 
input [3:0]s,input [15:0]a,output [24:0]o 
 
    ); 
 
    wire [16:0]s0; 
 
    mux m1(1'b0,a[0],s[0],s0[0]); 
    mux m2(a[0],a[1],s[0],s0[1]); 
    mux m3(a[1],a[2],s[0],s0[2]); 
    mux m4(a[2],a[3],s[0],s0[3]); 
    mux m5(a[3],a[4],s[0],s0[4]); 
    mux m6 (a[4],a[5],s[0],s0[5]); 
    mux m7(a[5],a[6],s[0],s0[6]); 
    mux m8(a[6],a[7],s[0],s0[7]); 
    mux m9(a[7],a[8],s[0],s0[8]); 
    mux m10(a[8],a[9],s[0],s0[9]); 
    mux m11(a[9],a[10],s[0],s0[10]); 
    mux m12(a[10],a[11],s[0],s0[11]); 
    mux m13(a[11],a[12],s[0],s0[12]); 
    mux m14(a[12],a[13],s[0],s0[13]); 
    mux m15(a[13],a[14],s[0],s0[14]); 
    mux m16(a[14],a[15],s[0],s0[15]); 
    mux m17(a[15],1'b0,s[0],s0[16]); 
 
    wire[18:0]s1; 
    mux m18(1'b0,s0[0],s[1],s1[0]); 
    mux m19(1'b0,s0[1],s[1],s1[1]); 
    mux m20(s0[0],s0[2],s[1],s1[2]); 
    mux m21(s0[1],s0[3],s[1],s1[3]); 
    mux m22(s0[2],s0[4],s[1],s1[4]); 
    mux m23(s0[3],s0[5],s[1],s1[5]); 
    mux m24(s0[4],s0[6],s[1],s1[6]); 
    mux m25(s0[5],s0[7],s[1],s1[7]); 
    mux m26(s0[6],s0[8],s[1],s1[8]); 
    mux m27(s0[7],s0[9],s[1],s1[9]); 
    mux m28(s0[8],s0[10],s[1],s1[10]); 
    mux m29(s0[9],s0[11],s[1],s1[11]); 
    mux m30(s0[10],s0[12],s[1],s1[12]); 
    mux m31(s0[11],s0[13],s[1],s1[13]); 
    mux m32(s0[12],s0[14],s[1],s1[14]); 
    mux m33(s0[13],s0[15],s[1],s1[15]); 
    mux m34(s0[14],s0[16],s[1],s1[16]);  
    mux m35(s0[15],1'b0,s[1],s1[17]); 
    mux m36(s0[16],1'b0,s[1],s1[18]); 
     
    wire [22:0]s2; 
    mux m37(1'b0,s1[0],s[2],s2[0]); 
    mux m38(1'b0,s1[1],s[2],s2[1]); 
    mux m39(1'b0,s1[2],s[2],s2[2]); 
    mux m40(1'b0,s1[3],s[2],s2[3]); 
    mux m41(s1[0],s1[4],s[2],s2[4]); 
    mux m42(s1[1],s1[5],s[2],s2[5]); 
    mux m43(s1[2],s1[6],s[2],s2[6]); 
    mux m44(s1[3],s1[7],s[2],s2[7]); 
    mux m45(s1[4],s1[8],s[2],s2[8]); 
    mux m46(s1[5],s1[9],s[2],s2[9]); 
    mux m47(s1[6],s1[10],s[2],s2[10]); 
    mux m48(s1[7],s1[11],s[2],s2[11]); 
    mux m49(s1[8],s1[12],s[2],s2[12]); 
    mux m50(s1[9],s1[13],s[2],s2[13]); 
    mux m51(s1[10],s1[14],s[2],s2[14]); 
    mux m52(s1[11],s1[15],s[2],s2[15]); 
    mux m53(s1[12],s1[16],s[2],s2[16]); 
    mux m54(s1[13],s1[17],s[2],s2[17]); 
    mux m55(s1[14],s1[18],s[2],s2[18]); 
    mux m56(s1[15],1'b0,s[2],s2[19]); 
    mux m57(s1[16],1'b0,s[2],s2[20]); 
    mux m58(s1[17],1'b0,s[2],s2[21]); 
    mux m59(s1[18],1'b0,s[2],s2[22]); 
        
        
 
    wire [24:0]o1; 
    mux m60(1'b0,s2[0],s[3],o[0]); 
    mux m61(1'b0,s2[1],s[3],o[1]); 
    mux m62(1'b0,s2[2],s[3],o[2]); 
    mux m63(1'b0,s2[3],s[3],o[3]); 
    mux m64(1'b0,s2[4],s[3],o[4]); 
    mux m65(1'b0,s2[5],s[3],o[5]); 
    mux m66(1'b0,s2[6],s[3],o[6]); 
    mux m67(1'b0,s2[7],s[3],o[7]); 
    mux m68(s2[0],s2[8],s[3],o[8]); 
    mux m69(s2[1],s2[9],s[3],o[9]); 
    mux m70(s2[2],s2[10],s[3],o[10]); 
    mux m71(s2[3],s2[11],s[3],o[11]); 
    mux m72(s2[4],s2[12],s[3],o[12]); 
    mux m73(s2[5],s2[13],s[3],o[13]); 
    mux m74(s2[6],s2[14],s[3],o[14]); 
    mux m75(s2[7],s2[15],s[3],o[15]); 
    mux m76(s2[8],s2[16],s[3],o[16]); 
    mux m77(s2[9],s2[17],s[3],o[17]); 
    mux m78(s2[10],s2[18],s[3],o[18]); 
    mux m79(s2[11],s2[19],s[3],o[19]); 
    mux m80(s2[12],s2[20],s[3],o[20]); 
    mux m81(s2[13],s2[21],s[3],o[21]); 
    mux m82(s2[14],s2[22],s[3],o[22]); 
    mux m83(s2[15],1'b0,s[3],o[23]); 
    mux m84(s2[16],1'b0,s[3],o[24]); 
    Endmodule 
 
 
module mux(input a,input b,input s,output o); 
wire a1,a2; wire ns; 
not(ns,s); 
and(a1,a,s); 
and(a2,b,ns); 
or(o,a1,a2); 
Endmodule 
RADIX-4 PARTIAL PRODUCT : - 
module r4_pp (input [2:0]r,input [15:0]Y,output [16:0]ppr); 
wire s,d,n; 
radix4_encoder R_en(r,s,d,n); 
selector s1(.s(s),.d(d),.n(n),.y1(1'b0),.y0(Y[0]),.BY(ppr[0])); 
selector s2(.s(s),.d(d),.n(n),.y1(Y[0]),.y0(Y[1]),.BY(ppr[1])); 
selector s3(.s(s),.d(d),.n(n),.y1(Y[1]),.y0(Y[2]),.BY(ppr[2])); 
selector s4(.s(s),.d(d),.n(n),.y1(Y[2]),.y0(Y[3]),.BY(ppr[3])); 
selector s5(.s(s),.d(d),.n(n),.y1(Y[3]),.y0(Y[4]),.BY(ppr[4])); 
selector s6(.s(s),.d(d),.n(n),.y1(Y[4]),.y0(Y[5]),.BY(ppr[5])); 
selector s7(.s(s),.d(d),.n(n),.y1(Y[5]),.y0(Y[6]),.BY(ppr[6])); 
selector s8(.s(s),.d(d),.n(n),.y1(Y[6]),.y0(Y[7]),.BY(ppr[7])); 
selector s9(.s(s),.d(d),.n(n),.y1(Y[7]),.y0(Y[8]),.BY(ppr[8])); 
selector s10(.s(s),.d(d),.n(n),.y1(Y[8]),.y0(Y[9]),.BY(ppr[9])); 
selector s11(.s(s),.d(d),.n(n),.y1(Y[9]),.y0(Y[10]),.BY(ppr[10])); 
selector s12(.s(s),.d(d),.n(n),.y1(Y[10]),.y0(Y[11]),.BY(ppr[11])); 
selector s13(.s(s),.d(d),.n(n),.y1(Y[11]),.y0(Y[12]),.BY(ppr[12])); 
selector s14(.s(s),.d(d),.n(n),.y1(Y[12]),.y0(Y[13]),.BY(ppr[13])); 
selector s15(.s(s),.d(d),.n(n),.y1(Y[13]),.y0(Y[14]),.BY(ppr[14])); 
selector s16(.s(s),.d(d),.n(n),.y1(Y[14]),.y0(Y[15]),.BY(ppr[15])); 
selector s17(.s(s),.d(d),.n(n),.y1(Y[15]),.y0(Y[15]),.BY(ppr[16])); 
Endmodule 
module selector (input s,d,n,y1,y0,output BY); 
wire a1,a2,o1; 
and(a1,s,y0); 
and(a2,d,y1); 
or(o1,a1,a2); 
xor(BY,o1,n); 
endmodule 
module radix4_encoder( 
input [2:0]r, 
output s,d,n 
); 
wire a1,a2,o1,nr1,nr0,nr2; 
not(nr0,r[0]); 
not(nr1,r[1]); 
not(nr2,r[2]); 
xor(s,r[0],r[1]); 
and(a1,nr2,r[0],r[1]); 
and(a2,nr1,nr0,r[2]); 
or(d,a1,a2); 
or(o1,s,d); 
and(n,o1,r[2]); 

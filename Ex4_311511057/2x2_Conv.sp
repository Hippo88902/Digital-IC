
.option post nomod brief measdgt=8 captab
.include './Convolution_SYN.sp'

.include '7nm_TT.pm'

.include 'asap7sc7p5t_SIMPLE_RVT.sp'
.include 'asap7sc7p5t_SEQ_RVT.sp'
.include 'asap7sc7p5t_OA_RVT.sp'
.include 'asap7sc7p5t_INVBUF_RVT.sp'
.include 'asap7sc7p5t_AO_RVT.sp'

.VEC 'Pattern.vec'
.temp 25
*.global VDD GND

vvdd VDD GND 1.1v
vvss VSS GND 0v
*xconv VSS VDD IFM_0[3] IFM_0[2] IFM_0[1] IFM_0[0] IFM_1[3] IFM_1[2] IFM_1[1] IFM_1[0] IFM_2[3] IFM_2[2] IFM_2[1] IFM_2[0] IFM_3[3] IFM_3[2] IFM_3[1] IFM_3[0] INW_0[3] INW_0[2] INW_0[1] INW_0[0] INW_1[3] INW_1[2] INW_1[1] INW_1[0] INW_2[3] INW_2[2] INW_2[1] INW_2[0] INW_3[3] INW_3[2] INW_3[1] INW_3[0] Output[9] Output[8] Output[7] Output[6] Output[5] Output[4] Output[3] Output[2] Output[1] Output[0] 
xconv VSS VDD IFM_0[3] IFM_0[2] IFM_0[1] IFM_0[0] IFM_1[3] IFM_1[2] IFM_1[1] IFM_1[0] IFM_2[3] IFM_2[2] IFM_2[1] IFM_2[0] IFM_3[3] IFM_3[2] IFM_3[1] IFM_3[0] INW_0[3] INW_0[2] INW_0[1] INW_0[0] INW_1[3] INW_1[2] INW_1[1] INW_1[0] INW_2[3] INW_2[2] INW_2[1] INW_2[0] INW_3[3] INW_3[2] INW_3[1] INW_3[0] Output[9] Output[8] Output[7] Output[6] Output[5] Output[4] Output[3] Output[2] Output[1] Output[0] Port10 Convolution

*C0 Ouput[0] gnd 5fF
*C1 Ouput[1] gnd 5fF
*C2 Ouput[2] gnd 5fF
*C3 Ouput[3] gnd 5fF
*C4 Ouput[4] gnd 5fF
*C5 Ouput[5] gnd 5fF
*C6 Ouput[6] gnd 5fF
*C7 Ouput[7] gnd 5fF
*C8 Ouput[8] gnd 5fF
*C9 Ouput[9] gnd 5fF

.meas TRAN T_delay TRIG V(IFM_3[0]) VAL=0.325 FALL=1
+                      TARG V(Output[8])  VAL=0.325 FALL=1
.meas TRAN Power1
+avg P(vvdd) from 49n to 56n

.tran 1p 110n

.end

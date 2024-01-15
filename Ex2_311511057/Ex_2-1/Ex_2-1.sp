.TITLE 1-bit FA

* Include the required libraries
.protect
.include '7nm_TT.pm'
.include 'asap7_75t_R_24.cdl'
.include 'Buffer.sp'
.unprotect

* Set simulation options
.VEC "Pattern_adder_1bit.vec"
.option post accurate
.option captab
.temp 27

* Define voltage sources
.global VDD GND
vvdd VDD GND 0.8v

* Define Circuit
.SUBCKT Adder_1 A B C VDD VSS S C_out
x_XOR1 A B VDD VSS wire XOR2x1_ASAP7_75t_R
x_XOR2 wire C VDD VSS S XOR2x1_ASAP7_75t_R
x_MAJ  A B C VDD VSS C_out MAJx2_ASAP7_75t_R
.ENDS

x_buf1 A A_1 buffer
x_buf2 B B_1 buffer
x_buf3 C_in C_1 buffer
x_Adder A_1 B_1 C_1 VDD GND S C_out Adder_1
c1 S GND 5ff
c2 C_out GND 5ff

* Measure the power consumption & set simulator setting 
.tran 1ps 3ns
.meas tran pwr avg p(x_Adder)
.print tran power_adder=par('p(x_Adder)')
.meas tran S_worst trig v(A_1) val=0.4v rise=1
+               targ v(S) val=0.4v rise=1
.meas tran C_worst trig v(A_1) val=0.4v rise=3
+               targ v(C_out) val=0.4v rise=3
.meas tran S_norm trig v(B_1) val=0.4v fall=1
+               targ v(S) val=0.4v rise=2
.meas tran C_norm trig v(C_1) val=0.4v rise=1
+               targ v(C_out) val=0.4v rise=1
.end



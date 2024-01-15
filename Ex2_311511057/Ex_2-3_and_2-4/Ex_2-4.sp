.TITLE 4-bit Adder

* Include the required libraries
.protect
.include '7nm_TT.pm'
.include 'asap7sc7p5t_INVBUF_RVT.sp'
.include 'asap7sc7p5t_SIMPLE_RVT.sp'
.include 'Adder_4bit_SYN_new.sp'
.include 'Buffer.sp'
.unprotect
.VEC "Pattern_adder_4bit.vec"

* Set simulation options
.option post acurate
.option captab
.temp 27

* Define voltage sources
.global VDD GND
vvdd VDD GND 0.7v

* Define Circuit
x_buf1 A[0] A0 buffer
x_buf2 A[1] A1 buffer
x_buf3 A[2] A2 buffer
x_buf4 A[3] A3 buffer
x_buf5 B[0] B0 buffer
x_buf6 B[1] B1 buffer
x_buf7 B[2] B2 buffer
x_buf8 B[3] B3 buffer
x_Adder GND VDD A3 A2 A1 A0 B3 B2 B1 B0 C_out S3 S2 S1 S0 Adder_4bit
c1 S0 GND 5ff
c2 S1 GND 5ff
c3 S2 GND 5ff
c4 S3 GND 5ff
c5 C_out GND 5ff


* Measure the power consumption & set simulator setting 
.tran 1ps 5ns
.meas tran pwr avg p(x_Adder)
.print tran power_adder=par('p(x_Adder)')
.meas tran C_worst trig v(B0) val=0.35v rise=3
+               targ v(C_out) val=0.35v rise=3

.end
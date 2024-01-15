.TITLE 1-bit FA

* Include the required libraries
.include '7nm_TT.pm'
.include 'Buffer.sp'
.include 'XOR.sp'
.include 'MAJ3.sp'
.VEC "Pattern_adder_1bit.vec"

* Set simulation options
.option post accurate
.option captab
.temp 27

* Define voltage sources
.global VDD GND
vvdd VDD GND 2v

* Define Circuit
.SUBCKT Adder_CMOS A B C VDD VSS S C_out
	x_XOR1 A B VDD VSS wire XOR_CMOS
	x_XOR2 wire C VDD VSS S XOR_CMOS
	x_MAJ  A B C VDD VSS C_out MAJ_CMOS
.ENDS

.SUBCKT OR_CPL A B out outb
    x_inv1 A Ab inverter
    x_inv2 B Bb inverter
    mm0 out  Bb A  x nmos_rvt m=1
	mm1 out  B  B  x nmos_rvt m=1
	mm2 outb Bb Ab x nmos_rvt m=1
	mm3 outb B  Bb x nmos_rvt m=1
.ENDS

.SUBCKT AND_CPL A B out outb
    x_inv1 A Ab inverter
    x_inv2 B Bb inverter
    mm0 out  B  A  x nmos_rvt m=1
	mm1 out  Bb B  x nmos_rvt m=1
	mm2 outb B  Ab x nmos_rvt m=1
	mm3 outb Bb Bb x nmos_rvt m=1
.ENDS

.SUBCKT Adder_CPL A B C S Sb C_out C_outb
	x_XOR1 A  B w1 w1b XOR_CPL
	x_XOR2 w1 C S Sb XOR_CPL
	x_AND1 A  B w2 w2b AND_CPL
	x_AND2 w1 C w3 w3b AND_CPL
	X_OR1  w3 w2 C_out C_outb OR_CPL
.ENDS

.SUBCKT Adder_DCVS A B C VDD VSS S Sb C_out C_outb
	x_XOR1 A B VDD VSS wire wb XOR_DCVS
	x_XOR2 wire C VDD VSS S Sb XOR_DCVS
	x_MAJ  A B C VDD VSS C_out C_outb MAJ_DCVS
.ENDS

x_buf1 A A_1 buffer
x_buf2 B B_1 buffer
x_buf3 C_in C_1 buffer
*x_Adder A_1 B_1 C_1 VDD GND S C_out Adder_CMOS
x_Adder A_1 B_1 C_1 S Sb C_out C_outb Adder_CPL
*x_Adder A_1 B_1 C_1 VDD GND S Sb C_out C_outb Adder_DCVS
c1 S GND 5ff
c2 C_out GND 5ff

* Measure the power consumption & set simulator setting 
.tran 1ns 20ns
.meas tran pwr avg p(x_Adder)
.print tran power_adder=par('p(x_Adder)')
.meas tran S_worst trig v(A_1) val=1v rise=1
+               targ v(S) val=0.5v rise=1
.meas tran C_worst trig v(A_1) val=1v rise=3
+               targ v(C_out) val=1v rise=3
.meas tran S_norm trig v(A_1) val=1v fall=2
+               targ v(S) val=1v rise=2
.meas tran C_norm trig v(A_1) val=1v rise=2
+               targ v(C_out) val=1v rise=1
.end
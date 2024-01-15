.SUBCKT XOR_CMOS A B VDD VSS out
	X_inv1 A A_bar inverter
	X_inv2 B B_bar inverter
	mm0  up1 A_bar VDD x pmos_rvt m=1
	mm1  out A     up1 x pmos_rvt m=1
	mm2  up1 B_bar VDD x pmos_rvt m=1
	mm3  out B     up1 x pmos_rvt m=1
	mm4  dn1 B_bar VSS x nmos_rvt m=1
	mm5  out A_Bar dn1 x nmos_rvt m=1
	mm6  dn2 B     VSS x nmos_rvt m=1
	mm7  out A     dn2 x nmos_rvt m=1
.ENDS

.SUBCKT XOR_CPL A B out outb
	X_inv1 A A_bar inverter
	X_inv2 B B_bar inverter
	mm0 out  B_bar A     x nmos_rvt m=1
	mm1 out  B     A_bar x nmos_rvt m=1
	mm2 outb B_bar A_bar x nmos_rvt m=1
	mm3 outb B     A     x nmos_rvt m=1
.ENDS

.SUBCKT XOR_DCVS A B VDD VSS out outb
	X_inv1 A A_bar inverter
	X_inv2 B B_bar inverter
	mm0 dn_l A     VSS   x nmos_rvt m=1
	mm1 dn_r A_bar VSS   x nmos_rvt m=1
	mm2 out  B     dn_l  x nmos_rvt m=1
	mm3 outb B_bar dn_l  x nmos_rvt m=1
	mm4 outb B     dn_r  x nmos_rvt m=1
	mm5 out  B_bar dn_r  x nmos_rvt m=1
	mm6 out  outb  VDD   x pmos_rvt m=1
	mm7 outb out   VDD   x pmos_rvt m=1
.ENDS
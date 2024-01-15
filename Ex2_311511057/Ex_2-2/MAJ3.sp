.SUBCKT MAJ_CMOS A B C VDD VSS out
    mm0  up1 A VDD x pmos_rvt m=1
    mm1  up2 A up1 x pmos_rvt m=1
    mm2  Qb  B up2 x pmos_rvt m=1
    mm3  up1 B VDD x pmos_rvt m=1
    mm4  up2 C up1 x pmos_rvt m=1
    mm5  Qb  C up2 x pmos_rvt m=1
    mm6  dn1 B VSS x nmos_rvt m=1
    mm7  dn2 C VSS x nmos_rvt m=1
    mm8  dn3 C VSS x nmos_rvt m=1
    mm9  Qb  A dn1 x nmos_rvt m=1
    mm10 Qb  A dn2 x nmos_rvt m=1
    mm11 Qb  B dn3 x nmos_rvt m=1
    x_inv Qb out inverter
.ENDS

.SUBCKT MAJ_DCVS A B C VDD VSS out outb
    x_inv1 A Ab inverter
    x_inv2 B Bb inverter
    x_inv3 C Cb inverter
    mm0  dn1 Bb VSS x nmos_rvt m=1
    mm1  dn2 Cb VSS x nmos_rvt m=1
    mm2  dn3 Cb VSS x nmos_rvt m=1
    mm3  out Ab dn1 x nmos_rvt m=1
    mm4  out Ab dn2 x nmos_rvt m=1
    mm5  out Bb dn3 x nmos_rvt m=1
    mm6  dn4 B  VSS x nmos_rvt m=1
    mm7  dn5 C  VSS x nmos_rvt m=1
    mm8  dn6 C  VSS x nmos_rvt m=1
    mm9  outb A dn4 x nmos_rvt m=1
    mm10 outb A dn5 x nmos_rvt m=1
    mm11 outb B dn6 x nmos_rvt m=1
    mm12 out outb VDD x pmos_rvt m=1
    mm13 outb out VDD x pmos_rvt m=1
.ENDS
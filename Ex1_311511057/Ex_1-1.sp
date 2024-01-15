* Include the required libraries
.include '16mos.pm'
.include '7nm_TT.pm'

* Set simulation options
.option post accurate
.option captab
.temp 27

* Define global voltage sources
.global vdd vss gnd
vvdd vdd gnd 0.7v
vvss vss gnd 0v

* Define gate voltage sources for CMOS
vgsn gn 0 dc 0.7
vgsp gp 0 dc 0.7

* Connect gate voltage sources to FinFETs and CMOS
vgs vgsp vdd
isd gnd vdd

* Define components (transistors)
* PMOS and NMOS for CMOS
mpmos1 vss gp vdd vdd pmos l=16n w=16n m=1
mnmos1 vdd gn vss vss nmos l=16n w=16n m=1

* FinFETs (Make sure to provide valid gate voltage sources)
mpfin1 vss gp vdd vdd pmos_rvt l=16n w=16n m=1
mnfin1 vdd gn vss vss nmos_rvt l=16n w=16n m=1

* Simulate
.dc vgsn 0 0.7 0.1
.dc vgsp 0 0.7 0.1
.dc vgs -0.7 0 0.1
.probe v(*) i(*)
.end


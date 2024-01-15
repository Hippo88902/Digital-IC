* Include the required libraries
.include '7nm_TT.pm'
.include 'asap7sc7p5t_INVBUF_RVT.sp'

* Set simulation options
.option post accurate
.option captab
.temp 27

* Define global voltage sources
.global vdd gnd

* Initial value for Vdd
.param Vdd=0.7v

* Voltage source for input signal
vvdd vdd gnd 'Vdd'
vin in gnd pulse (0 0.7 0.1n 0.1n 0.1n 0.4n 1n)

* Define components (inverter instances)
xmin gnd vdd in outmin INVx1_ASAP7_75t_R
xmax gnd vdd in outmax INVx13_ASAP7_75t_R

* Simulate for different Vdd values
.dc vin 0 'Vdd' 0.01
.probe v(*)

* Simulate for different Vdd values using .alter statements
.alter
.param Vdd=0.6v
.alter
.param Vdd=0.5v
.alter
.param Vdd=0.4v

.end


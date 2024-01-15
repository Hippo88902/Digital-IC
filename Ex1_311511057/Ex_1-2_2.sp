* Include the required technology files
.include '7nm_TT.pm' 
.include '16mos.pm'    

* Set simulation options
.option post accurate
.option captab
.temp 27

* Define global voltage sources
.global vdd gnd
vvdd vdd gnd 0.7V

* Define input pulse sources
vin in gnd pulse (0 0.7 0.1n 0.1n 0.1n 0.4n 1n)

* Define the unit-sized inverter for FinFET
.subckt invmos in out
mpmos out in vdd vdd pmos l=16n w=33n m=1
mnmos out in gnd gnd nmos l=16n w=33n m=1
.ends

* Define the unit-sized inverter for planar MOS
.subckt invplanar in out
mpmos out in vdd vdd pmos l=16n w=50n m=1
mnmos out in gnd gnd nmos l=16n w=50n m=1
.ends

* Instantiate the unit-sized inverters
xmos in out invmos
xplanar in out invplanar

* DC sweep to plot the VTC curves
.dc vin 0 0.7 0.01
.probe v(out) 

.end

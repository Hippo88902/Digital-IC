* Include the required technology files
.include '7nm_TT.pm'
.include '16mos.pm'
.include 'Buffer.sp'

* Set simulation options
.option post accurate
.option captab
.temp 27

* Define global voltage sources
.global VDD GND
VVDD VDD GND 0.7V
.param period=1n

* Define the input pattern generator
vin in1 GND PULSE(0  0.7  0.01n  0.01n  0.01n  'period/2-0.01n'  'period')

* Instantiate the input buffer
X_BUF in1 in_buffer inverter

* Define the FO4 (4 inverters)
X_INV1 in_buffer out1 inverter 
X_INV2 out1 out2 inverter
X_INV3 out2 out3 inverter
X_INV4 out3 out4 inverter

* Wire loading
c1 out4 gnd 10ff

* Measure the power consumption
.meas TRAN Power AVG 'P(X_INV1) + P(X_INV2) + P(X_INV3) + P(X_INV4)' 

.tran 1ns 'period*20'
.alter
.param period=0.5n
.alter
.param period=0.25n
.end
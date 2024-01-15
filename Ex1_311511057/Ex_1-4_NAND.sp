* Include the required technology files
.include '7nm_TT.pm'
.include 'asap7sc7p5t_INVBUF_RVT.sp'
.include 'asap7sc7p5t_SIMPLE_RVT.sp'

* Set simulation options
.option post accurate
.option captab
.temp 27

* Define global voltage sources
.global VDD GND
VVDD VDD GND 0.7V

* Include the input buffer subcircuit
.include 'Buffer.sp'

* Define the input pattern generators
Vina ina GND PULSE(0 0.7 1n 1n 1n 9n 20n)
Vinb inb GND PULSE(0 0.7 1n 1n 1n 9n 20n)
Vinc inc GND PULSE(0 0.7 1n 1n 1n 9n 20n)

* Define the smallest NAND2 gate
X_NAND GND VDD ina inb inverter NAND2x1_ASAP7_75t_R

* Instantiate the input buffer
X_BUF inc in_buffer inverter

* Define the FO4_1 (4 inverters)
X_INV1 in_buffer out1 inverter
X_INV2 out1 out2 inverter
X_INV3 out2 out3 inverter
X_INV4 out3 out4 inverter

* Wire loading
Cwire out4 0 10f

* Measure the propagation delay and transition times
.meas tran Tplh_NAND2 TRIG v(inc) VAL=0.35V FALL=2
+               TARG v(out4) VAL=0.35V RISE=2

.meas tran Tphl_NAND2 TRIG v(inc) VAL=0.35V RISE=2
+               TARG v(out4) VAL=0.35V FALL=2

.meas tran trise TRIG v(out4) VAL='0.1*0.7v' rise=2
+                TARG v(out4) VAL='0.9*0.7v' rise=2

.meas tran tfall TRIG v(out4) VAL='0.9*0.7v' fall=2
+                TARG v(out4) VAL='0.1*0.7v' fall=2

* Measure power consumption
.meas tran pwr avg power

* Perform transient analysis
.tran 1ns 100ns

* Probe and output
.probe tran
.probe v(*) i(*)

.end

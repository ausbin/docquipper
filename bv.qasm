OPENQASM 2.0;
include "qelib1.inc";


qreg anc0[1];
qreg anc1[1];
qreg anc2[1];
qreg anc3[1];
x anc3[0];
h anc0[0];
h anc1[0];
h anc2[0];
h anc3[0];
cx anc0[0],anc3[0];
cx anc2[0],anc3[0];
h anc0[0];
h anc1[0];
h anc2[0];
creg canc3[1];
measure -> canc3[0];
creg canc2[1];
measure -> canc2[0];
creg canc1[1];
measure -> canc1[0];
creg canc0[1];
measure -> canc0[0];


OPENQASM 2.0;
include "qelib1.inc";


qreg anc0[1];
qreg anc1[1];
qreg anc2[1];
qreg anc3[1];
qreg anc4[1];
qreg anc5[1];
qreg anc6[1];
//// barrier anc0[0],anc1[0],anc2[0],anc3[0],anc4[0],anc5[0],anc6[0];
h anc0[0];
h anc1[0];
h anc2[0];
cx anc2[0],anc4[0];
cx anc2[0],anc5[0];
cx anc3[0],anc5[0];
ccx anc1[0],anc5[0],anc3[0];
cx anc3[0],anc5[0];
cx anc6[0],anc4[0];
ccx anc1[0],anc4[0],anc6[0];
cx anc6[0],anc4[0];
creg canc6[1];
measure -> canc6[0];
creg canc5[1];
measure -> canc5[0];
creg canc4[1];
measure -> canc4[0];
creg canc3[1];
measure -> canc3[0];
//// ENTER: qft_big_endianbarrier anc0[0],anc1[0],anc2[0];
h anc0[0];
ccx anc0[0],anc1[0],anc3[0];
rz(4.0) anc3[0];
ccx anc0[0],anc1[0],anc3[0];
reset anc3[0];
h anc1[0];
ccx anc0[0],anc2[0],anc3[0];
rz(8.0) anc3[0];
ccx anc0[0],anc2[0],anc3[0];
reset anc3[0];
ccx anc1[0],anc2[0],anc3[0];
rz(4.0) anc3[0];
ccx anc1[0],anc2[0],anc3[0];
reset anc3[0];
h anc2[0];
//// EXIT: qft_big_endianbarrier anc0[0],anc1[0],anc2[0];
creg canc0[1];
measure -> canc0[0];
creg canc1[1];
measure -> canc1[0];
creg canc2[1];
measure -> canc2[0];

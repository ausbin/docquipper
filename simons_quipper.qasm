OPENQASM 2.0;
include "qelib1.inc";


////  Simon8217s algorithmbarrier//// startbarrierqreg anc0[1];
qreg anc1[1];
qreg anc2[1];
x anc2[0];
qreg anc3[1];
x anc3[0];
//// barrier anc0[0],anc1[0],anc2[0],anc3[0];
h anc0[0];
h anc1[0];
h anc2[0];
h anc3[0];
//// ENTER: exact_synthesisbarrier anc0[0],anc1[0],anc2[0],anc3[0];
qreg anc4[1];
ccx anc0[0],anc1[0],anc4[0];
ccx anc2[0],anc4[0],anc3[0];
ccx anc0[0],anc1[0],anc4[0];
reset anc4[0];
ccx anc0[0],anc1[0],anc4[0];
x anc2[0];
ccx anc2[0],anc4[0],anc3[0];
x anc2[0];
ccx anc0[0],anc1[0],anc4[0];
reset anc4[0];
x anc1[0];
ccx anc0[0],anc1[0],anc4[0];
x anc1[0];
ccx anc3[0],anc4[0],anc2[0];
x anc1[0];
ccx anc0[0],anc1[0],anc4[0];
x anc1[0];
reset anc4[0];
x anc1[0];
ccx anc0[0],anc1[0],anc4[0];
x anc1[0];
x anc3[0];
ccx anc3[0],anc4[0],anc2[0];
x anc3[0];
x anc1[0];
ccx anc0[0],anc1[0],anc4[0];
x anc1[0];
reset anc4[0];
x anc0[0];
ccx anc0[0],anc1[0],anc4[0];
x anc0[0];
ccx anc3[0],anc4[0],anc2[0];
x anc0[0];
ccx anc0[0],anc1[0],anc4[0];
x anc0[0];
reset anc4[0];
x anc0[0];
ccx anc0[0],anc1[0],anc4[0];
x anc0[0];
x anc3[0];
ccx anc3[0],anc4[0],anc2[0];
x anc3[0];
x anc0[0];
ccx anc0[0],anc1[0],anc4[0];
x anc0[0];
reset anc4[0];
x anc0[0];
x anc1[0];
ccx anc0[0],anc1[0],anc4[0];
x anc1[0];
x anc0[0];
ccx anc2[0],anc4[0],anc3[0];
x anc0[0];
x anc1[0];
ccx anc0[0],anc1[0],anc4[0];
x anc1[0];
x anc0[0];
reset anc4[0];
x anc0[0];
x anc1[0];
ccx anc0[0],anc1[0],anc4[0];
x anc1[0];
x anc0[0];
x anc2[0];
ccx anc2[0],anc4[0],anc3[0];
x anc2[0];
x anc0[0];
x anc1[0];
ccx anc0[0],anc1[0],anc4[0];
x anc1[0];
x anc0[0];
reset anc4[0];
//// EXIT: exact_synthesisbarrier anc0[0],anc1[0],anc2[0],anc3[0];
h anc0[0];
h anc1[0];
creg canc3[1];
measure -> canc3[0];
creg canc2[1];
measure -> canc2[0];
creg canc1[1];
measure -> canc1[0];
creg canc0[1];
measure -> canc0[0];
//// finishbarrier
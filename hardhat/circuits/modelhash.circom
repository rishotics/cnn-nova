pragma circom 2.1.5;

include "../node_modules/circomlib/circuits/mimc.circom";

template GetModelHash{

    signal input in[1000];
    signal output out;

    component mimc = MultiMiMC7(1000, 91);
    mimc.k <== 0;

    for (var i = 0; i < 1000; i++) {
        mimc.in[i] <== in[i];
    }

    out <== mimc.out;
}
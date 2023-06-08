pragma circom 2.1.5;

include "./model.circom";
include "./modelHash.circom";
include "../node_modules/circomlib/circuits/poseidon.circom";

template RecursionModel {

    signal input step_in[3];

    signal input in[28][28][1];
    signal input conv2d_1_weights[3][3][1][4];
    signal input conv2d_1_bias[4];
    signal input bn_1_a[4];
    signal input bn_1_b[4];
    signal input conv2d_2_weights[3][3][4][16];
    signal input conv2d_2_bias[16];
    signal input bn_2_a[16];
    signal input bn_2_b[16];

    signal output step_out[3];


    component model = Model(28,28);
    component modelHash = GetModelHash();

    model.in <== in;
    model.conv2d_1_weights <== conv2d_1_weights;
    model.conv2d_1_bias <== conv2d_1_bias;
    model.bn_1_a <== bn_1_a;
    model.bn_1_b <== bn_1_b;
    model.conv2d_2_weights <== conv2d_2_weights; 
    model.conv2d_2_bias <== conv2d_2_bias;
    model.bn_2_a <== bn_2_a;
    model.bn_2_b <== bn_2_b;

    //testing
    for(var i=0; i<100; i++){
        modelHash.in <== 1;
    }
    component poseidon[2];
    poseidon[0] <== Poseidon(2);
    poseidon[0].inputs[0] <== step_in[0];
    poseidon[0].inputs[1] <== modelHash.out;

    step_out[0] <== poseidon[0].out;

    poseidon[1] <== Poseidon(2);
    poseidon[1].inputs[0] <== step_in[1];
    poseidon[1].inputs[1] <== model.out;

    step_out[2] <== poseidon[1].out;
}
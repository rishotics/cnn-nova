pragma circom 2.1.5;
include "../node_modules/circomlib-ml/circuits/Conv2D.circom";
include "../node_modules/circomlib-ml/circuits/Dense.circom";
include "../node_modules/circomlib-ml/circuits/ArgMax.circom";
include "../node_modules/circomlib-ml/circuits/Poly.circom";
include "../node_modules/circomlib-ml/circuits/AveragePooling2D.circom";
include "../node_modules/circomlib-ml/circuits/BatchNormalization2D.circom";
include "../node_modules/circomlib-ml/circuits/Flatten2D.circom";


/*This circuit template checks that c is the multiplication of a and b.*/  

template ImageRecognitionSimple (n, m) {  
   signal input in[4][4][1];
   signal input conv2d_1_weights[4][4][1][1];
   signal input conv2d_1_bias[1];
//    signal input bn_1_a[1];
//    signal input bn_1_b[1];
//    signal input conv2d_2_weights[3][3][4][16];
//    signal input conv2d_2_bias[16];
//    signal input bn_2_a[16];
//    signal input bn_2_b[16];

   signal output out[1];

   // out <== 1 ;

//    component pixels[n][m][1];

//    for (var i=0; i<4; i++) {
//         for (var j=0; j<4; j++) {
//             pixels[i][j][0] = Bits2Num(8);
//             for (var k=0; k<8; k++) {
//                 pixels[i][j][0].in[k] <== in[13*8+i*28*8+j*8+k]; // the pgm header is 13 bytes
//             }
//         }
//     }

//                      Conv2D (nRows, nCols, nChannels, nFilters, kernelSize, strides)
   component conv2d_1 = Conv2D(4, 4, 1, 1, 4, 1);
//    component bn_1 = BatchNormalization2D(, 26, 4);
//    component avg_1 = AveragePooling2D(26, 26, 4, 2, 2, 25);


   for(var i=0; i<4; i++) {
         for(var j=0; j<4; j++) {
            conv2d_1.in[i][j][0] <== in[i][j][0];
         }
   }

   for(var i=0;i<4;i++){
      for(var j=0;j<4;j++){
         for(var k=0;k<1;k++){
            conv2d_1.weights[i][j][0][k] <== conv2d_1_weights[i][j][0][k];
         }
      }
   }

   for(var i=0;i<1;i++){
      conv2d_1.bias[i] <== conv2d_1_bias[i];
   }

//    for(var i=0;i<4;i++){
//       bn_1.a[i] <== bn_1_a[i];
//    }

//    for(var i=0;i<4;i++){
//       bn_1.b[i] <== bn_1_b[i];
//       for(var j=0;j<26;j++){
//          for(var k=0;k<26;k++){
//             bn_1.in[j][k][i] <== conv2d_1.out[j][k][i];
//          }
//       }
//    }

//    component poly_1[26][26][4];

//    for(var i=0;i<26;i++){
//       for(var j=0;j<26;j++){
//          for(var k=0;k<4;k++){
//             poly_1[i][j][k] = Poly(10**6);
//             poly_1[i][j][k].in <== bn_1.out[i][j][k];
//             avg_1.in[i][j][k] <== poly_1[i][j][k].out;
//          }
//       }
//    }

//    for(var i=0;i<13;i++){
//       for(var j=0;j<13;j++){
//          for(var k=0;k<4;k++){
//             out[i][j][k] <== avg_1.out[i][j][k];
//          }
//       }
//    }
// //                      Conv2D (nRows, nCols, nChannels, nFilters, kernelSize, strides)
//    // conv2d_2_weights[3][3][4][16];

//    component conv2d_2 = Conv2D(13, 13, 4, 16, 3, 1);
//    component bn_2 = BatchNormalization2D(11, 11, 16);
//    component avg_2 = AveragePooling2D(11, 11, 16, 2, 2, 25);
//    component global_avg = GlobalAveragePooling2D(5, 5, 16, 500);

//    for(var i=0;i<13;i++){
//       for(var j=0;j<13;j++){
//          for(var k=0;k<4;k++){
//             conv2d_2.in[i][j][k] <== avg_1.out[i][j][k];
//          }
//       }
//    }
//    for(var i=0;i<3;i++){
//       for(var j=0;j<3;j++){
//          for(var k=0;k<4;k++){
//             for(var l=0;l<16;l++){
//                conv2d_2.weights[i][j][k][l] <== conv2d_2_weights[i][j][k][l];
//             }
//          }
//       }
//    }

//    for(var i=0;i<16;i++){
//       conv2d_2.bias[i] <== conv2d_2_bias[i];
//    }

//    // output_size = [(dimension - kernal_size)/stride] + 1

//    for(var i=0;i<11;i++){
//       for(var j=0;j<11;j++){
//          for(var k=0;k<16;k++){
//             bn_2.in[i][j][k] <== conv2d_2.out[i][j][k];
//          }
//       }
//    } 

//    for(var i=0;i<16;i++){
//       bn_2.a[i] <== bn_2_a[i];
//    }

//    for(var i=0;i<16;i++){
//       bn_2.b[i] <== bn_2_b[i];
//    }

//    for(var i=0;i<11;i++){
//       for(var j=0;j<11;j++){
//          for(var k=0;k<16;k++){
//             component poly_2 = Poly(10**6);
//             poly_2.in <== bn_2.out[i][j][k];
//             avg_2.in[i][j][k] <== poly_2.out;
//          }
//       }
//    }

//    for(var i=0;i<5;i++){
//       for(var j=0;j<5;j++){
//          for(var k=0;k<16;k++){
//             global_avg.in[i][j][k] <== avg_2.out[i][j][k];
//          }
//       }
//    }

//    component dense = Dense(16, 10);


//    for(var i=0;i<16;i++){
//       dense.in[i] <== global_avg.out[i];
//    }

//    for(var i=0;i<16;i++){
//       for(var j=0;j<10;j++){
//          dense.weights[i][j] <== dense_weights[i][j];
//       }
//    }

//    for(var i=0;i<10;i++){
//       dense.bias[i] <== dense_bias[i];
//    }

//    component softmax = Softmax(10);

//    for(var i=0;i<10;i++){
//       softmax.in[i] <== dense.out[i];
//    }

   out[0] <== conv2d_1.out[0][0][0];
   
}

// component main = ImageRecognitionSimple(28, 28);
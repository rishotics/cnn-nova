pragma circom 2.0.0;
include "../node_modules/circomlib-ml/circuits/Conv2D.circom";
include "../node_modules/circomlib-ml/circuits/Dense.circom";
include "../node_modules/circomlib-ml/circuits/ArgMax.circom";
include "../node_modules/circomlib-ml/circuits/Poly.circom";
include "../node_modules/circomlib-ml/circuits/AveragePooling2D.circom";
include "../node_modules/circomlib-ml/circuits/BatchNormalization2D.circom";
include "../node_modules/circomlib-ml/circuits/Flatten2D.circom";


/*This circuit template checks that c is the multiplication of a and b.*/  

template ImageRecognitionSimple (n, m) {  
   signal input in[797*8];
   signal input conv2d_1_weights[3][3][1][4];
   signal input conv2d_1_bias[4];
   signal input bn_1_a[4];
   signal input bn_1_b[4];

   signal output out[13][13][4];

   // out <== 1 ;

   component pixels[n][m][1];

   for (var i=0; i<28; i++) {
        for (var j=0; j<28; j++) {
            pixels[i][j][0] = Bits2Num(8);
            for (var k=0; k<8; k++) {
                pixels[i][j][0].in[k] <== in[13*8+i*28*8+j*8+k]; // the pgm header is 13 bytes
            }
        }
    }

//                      Conv2D (nRows, nCols, nChannels, nFilters, kernelSize, strides)
   component conv2d_1 = Conv2D(28, 28, 1, 4, 3, 1);
   component bn_1 = BatchNormalization2D(26, 26, 4);
   component avg_1 = AveragePooling2D(26, 26, 4, 2, 2, 25);


   for(var i=0; i<n; i++) {
         for(var j=0; j<28; j++) {
            conv2d_1.in[i][j][0] <== in[i*128+j];
         }
   }

   for(var i=0;i<3;i++){
      for(var j=0;j<3;j++){
         for(var k=0;k<4;k++){
            conv2d_1.weights[i][j][0][k] <== conv2d_1_weights[i][j][0][k];
         }
      }
   }

   for(var i=0;i<4;i++){
      conv2d_1.bias[i] <== conv2d_1_bias[i];
   }

   for(var i=0;i<4;i++){
      bn_1.a[i] <== bn_1_a[i];
   }

   for(var i=0;i<4;i++){
      bn_1.b[i] <== bn_1_b[i];
      for(var j=0;j<26;j++){
         for(var k=0;k<26;k++){
            bn_1.in[j][k][i] <== conv2d_1.out[j][k][i];
         }
      }
   }

   component poly_1[26][26][4];

   for(var i=0;i<26;i++){
      for(var j=0;j<26;j++){
         for(var k=0;k<4;k++){
            poly_1[i][j][k] = Poly(10**6);
            poly_1[i][j][k].in <== bn_1.out[i][j][k];
            avg_1.in[i][j][k] <== poly_1[i][j][k].out;
         }
      }
   }

   for(var i=0;i<13;i++){
      for(var j=0;j<13;j++){
         for(var k=0;k<4;k++){
            out[i][j][k] <== avg_1.out[i][j][k];
         }
      }
   }

   
}

component main = ImageRecognitionSimple(28, 28);
pragma circom 2.0.0;
include "../node_modules/circomlib-ml/circuits/Conv2D.circom";
include "../node_modules/circomlib-ml/circuits/Dense.circom";
include "../node_modules/circomlib-ml/circuits/ArgMax.circom";
include "../node_modules/circomlib-ml/circuits/Poly.circom";
include "../node_modules/circomlib-ml/circuits/AveragePooling2D.circom";
include "../node_modules/circomlib-ml/circuits/BatchNormalization2D.circom";
include "../node_modules/circomlib-ml/circuits/Flatten2D.circom";


/*This circuit template checks that c is the multiplication of a and b.*/  

template ImageRecognitionSimple (n) {  
   signal input in[n*n];
   signal input conv2d_1_weights[3][3][1][4];
   signal input conv2d_1_bias[4];
   signal input bn_1_a[4];
   signal input bn_1_b[4];

   component pixels[n][n][1];

   for(var i=0;i<n;i++){
      for(var j=0;j<m;j++){
         pixels[i][j][0] = in[i*n+j];
      }
   }

//                      Conv2D (nRows, nCols, nChannels, nFilters, kernelSize, strides)
   component conv2d_1 = Conv2D(28, 28, 1, 1, 3, 1);
   component bn_1 = BatchNormalization2D(26, 26, 1);
   component avg_1 = AveragePooling2D(26, 26, 1, 2, 2, 25);


   for(var i=0; i<n; i++) {
         for(var j=0; j<28; j++) {
            conv2d_1.in[i][j][0] <== pixels[i*28+j];
         }
   }

   for(var i=0;i<3;i++){
      for(var j=0;j<3;j++){
         for(var k=0;k<4;k++){
            conv2d_1.weights <== conv2d_1_weights[i][j][0][k];
         }
      }
   }

   for(var i=0;i<4;i++){
      conv2d_1.bias <== conv2d_1_bias[i];
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

   component poly_1[n][n][1];

   for(var i=0;i<n;i++){
      for(var j=0;j<n;j++){
         for(var k=0;k<1;k++){
            pol_1[i][j][k] = Poly(10**6);
            avg_1[i][j][k] = pol_1[i][j][k].out;

         }
      }
   }

   





   

    
}

component main = ImageRecognitionSimple(28);
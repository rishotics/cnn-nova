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
   signal input in[n*m];
   signal input conv2d_1_weights[3][3];
   signal input conv2d_1_bias[4];
   signal input bn_1_a[4];

   component pixels[28][28][1];

   for(var i=0;i<n;i++){
      for(var j=0;j<m;j++){
         pixels
      }
   }

//                      Conv2D (nRows, nCols, nChannels, nFilters, kernelSize, strides)
   component conv2d_1 = Conv2D(28, 28, 1, 1, 3, 1);
   component bn_1 = BatchNormalization2D(26, 26, 1);


   for(var i=0; i<28; i++) {
         for(var j=0; j<28; j++) {
            conv2d_1.in[i][j][0] <== in[i*28+j];
         }
   } 



   

    
}

component main = ImageRecognitionSimple();
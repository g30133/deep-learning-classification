% shared variables
nn1 = {};
nn1{1} = [12 2];
cache1 = {};
cache1{1} = [14 14];
deltas1 = {};
deltas1{1} = [6];

nn2 = {};
nn2{1} = [13 23 3];
cache2 = {};
cache2{1} = [62 62];
deltas2 = {};
deltas2{1} = [-32];

nn3 = {};
nn3{1} = [13 23 3; 14 24 4];
cache3 = {};
cache3{1} = [62 62; 66 66];
deltas3 = {};
deltas3{1} = [-32; -26];

nn4 = {};
nn4{1} = [13 23 3; 14 24 4];
nn4{2} = [35 45 5];
cache4 = {};
cache4{1} = [62 62; 66 66];
cache4{2} = [5145 5145];
deltas4 = {};
deltas4{1} = [35*(-5095); 45*(-5095)];
deltas4{2} = [50-5145];

nn5 = {};
nn5{1} = [13 23 3; 14 24 4];
nn5{2} = [35 45 5; 36 46 6];
cache5 = {};
cache5{1} = [62 62; 66 66];
cache5{2} = [5145 5145; 5274 5274];
deltas5 = {};
deltas5{1} = [35*(50-5145) + 36*(60-5274); 45*(50-5145) + 46*(60-5274)];
deltas5{2} = [50-5145; 60-5274];

nn6 = {};
nn6{1} = [13 23 3; 14 24 4];
nn6{2} = [35 45 5; 36 46 6];
nn6{3} = [57 67 7];
cache6 = {};
cache6{1} = [62 62; 66 66];
cache6{2} = [5145 5145; 5274 5274];
cache6{3} = [646630 646630];
deltas6 = {};
deltas6{1} = [35*57*(70-646630) + 36*67*(70-646630); 45*57*(70-646630) + 46*67*(70-646630)];
deltas6{2} = [57*(70-646630); 67*(70-646630)];
deltas6{3} = [70-646630];

%% test 1: one input, one neuron network

updatedNN = update(nn1, [1], cache1, deltas1, 0.01);
w12 = updatedNN{1}(1,1);
assert(w12 == 12.06, 'neuron 2 w12 failed');
b2 = updatedNN{1}(1,2);
assert(b2 == 2.06, 'neuron 2 bias failed');

%% test 2: two input, one neuron network

updatedNN = update(nn2, [1 2], cache2, deltas2, 0.01);
w13 = updatedNN{1}(1,1);
w23 = updatedNN{1}(1,2);
b3 = updatedNN{1}(1,3);
assert(w13 == 12.68, 'neuron 3 w13 failed');
assert(w23 == 22.36, 'neuron 3 w23 failed');
assert(b3 == 2.68, 'neuron 3 bias failed');

%% test 3: two input, two neuron network

updatedNN = update(nn3, [1 2], cache3, deltas3, 0.01);
w13 = updatedNN{1}(1,1);
w23 = updatedNN{1}(1,2);
b3 = updatedNN{1}(1,3);
w14 = updatedNN{1}(2,1);
w24 = updatedNN{1}(2,2);
b4 = updatedNN{1}(2,3);
assert(w13 == 12.68, 'neuron 3 w13 failed');
assert(w23 == 22.36, 'neuron 3 w23 failed');
assert(b3 == 2.68, 'neuron 3 bias failed');
assert(w14 == 13.74, 'neuron 4 w14 failed');
assert(w24 == 23.48, 'neuron 4 w24 failed');
assert(b4 == 3.74, 'neuron 4 bias failed');


%% test 4: two input, layer 1 two neuron, layer 2 one neuron network
%{
 1=>[1]-- w13 --[3]
      \      /    \
       \   w23     w35
        \ /          \
         X            [5]=>50
        / \          /
       /   w14    w45
      /      \    /
 2=>[2]-- w24 --[4]

  d5 = g'(in5) * (y5 - a5) = 50 - 5145; deltas{2} = [ d5 ]
  d3 = g'(in3) * w35 * d5; deltas{layerIx} = [ d3 ];
  d4 = g'(in4) * w45 * d5; deltas{layerIx} = [ d3; d4 ];

  **** on output layer loop ****
    ...

  **** on hidden layer loop ****
  for layerIx = numHiddenLayers decrement by one for each layer
    for neuronIx = 1 to numNeuronsInTheLayer increment by one for each neuron
      calculate delta for the neuron, then put it in deltas
%}
updatedNN = update(nn4, [1 2], cache4, deltas4, 0.01);
w13 = updatedNN{1}(1,1);
w23 = updatedNN{1}(1,2);
b3 = updatedNN{1}(1,3);
w14 = updatedNN{1}(2,1);
w24 = updatedNN{1}(2,2);
b4 = updatedNN{1}(2,3);
w35 = updatedNN{2}(1,1);
w45 = updatedNN{2}(1,2);
b5 = updatedNN{2}(1,3);

assert(vpa(w13) == 13-(0.01*1*35*5095), 'neuron 3 w13 failed');
assert(vpa(w23) == 23-(0.01*2*35*5095), 'neuron 3 w23 failed');
assert(vpa(b3) == 3-(0.01*1*35*5095), 'neuron 3 bias failed');
assert(vpa(w14) == 14-(0.01*1*45*5095), 'neuron 4 w14 failed');
assert(vpa(w24) == 24-(0.01*2*45*5095), 'neuron 4 w24 failed');
assert(vpa(b4) == 4-(0.01*1*45*5095), 'neuron 4 bias failed');
assert(vpa(w35) == 35-(0.01*62*5095), 'neuron 5 w35 failed');
assert(vpa(w45) == 45-(0.01*66*5095), 'neuron 5 w45 failed');
assert(vpa(b5) == 5-(0.01*1*5095), 'neuron 5 bias failed');

%% test 5: two input, layer 1 two neuron, layer 2 two neuron network
%{
 1=>[1]-- w13 --[3]-- w35 --[5]=>50
      \      /     \      /
       \   w23      \   w45
        \ /          \ /
         X            X
        / \          / \
       /   w14      /   w36
      /      \     /      \
 2=>[2]-- w24 --[4]-- w46 --[6]=>60

  d5 = g'(in5)*(y5-a5) = 50 - 5145; deltas{2} = [ d5 ]
  d6 = g'(in6)*(y6-a6) = 60 - 5274; deltas{2} = [ d5; d6 ]
  d3 = g'(in3)*w35*d5 + g'(in3)*w36*d6; deltas{layerIx} = [ d3 ];
  d4 = g'(in4)*w45*d5 + g'(in4)*w46*d6; deltas{layerIx} = [ d3; d4 ];

  **** on output layer loop ****
    ...

  **** on hidden layer loop ****
  for layerIx = numHiddenLayers decrement by one for each layer
    for neuronIx = 1 to numNeuronsInTheLayer increment by one for each neuron
      calculate delta for the neuron, then put it in deltas
%}

updatedNN = update(nn5, [1 2], cache5, deltas5, 0.01);
w13 = updatedNN{1}(1,1);
w23 = updatedNN{1}(1,2);
b3 = updatedNN{1}(1,3);
w14 = updatedNN{1}(2,1);
w24 = updatedNN{1}(2,2);
b4 = updatedNN{1}(2,3);
w35 = updatedNN{2}(1,1);
w45 = updatedNN{2}(1,2);
b5 = updatedNN{2}(1,3);
w36 = updatedNN{2}(2,1);
w46 = updatedNN{2}(2,2);
b6 = updatedNN{2}(2,3);

assert(w13 == 13-(0.01*1*366029), 'neuron 3 w13 failed');
assert(w23 == 23-(0.01*2*366029), 'neuron 3 w23 failed');
assert(b3 == 3-(0.01*1*366029), 'neuron 3 bias failed');

assert(w14 == 14-(0.01*1*469119), 'neuron 4 w14 failed');
assert(w24 == 24-(0.01*2*469119), 'neuron 4 w24 failed');
assert(b4 == 4-(0.01*1*469119), 'neuron 4 bias failed');

assert(w35 == 35-(0.01*62*5095), 'neuron 5 w35 failed');
assert(w45 == 45-(0.01*66*5095), 'neuron 5 w45 failed');
assert(b5 == 5-(0.01*1*5095), 'neuron 5 bias failed');

assert(w36 == 36-(0.01*62*5214), 'neuron 6 w36 failed');
assert(w46 == 46-(0.01*66*5214), 'neuron 6 w46 failed');
assert(b6 == 6-(0.01*1*5214), 'neuron 6 bias failed');

%% test 6: two input, layer 1 two neuron, layer 2 two neuron network
%{
 1=>[1]-- w13 --[3]-- w35 --[5]
      \      /     \      /    \
       \   w23      \   w45     w57
        \ /          \ /         \
         X            X          [7]=>70
        / \          / \         /
       /   w14      /   w36     w67
      /      \     /      \    /
 2=>[2]-- w24 --[4]-- w46 --[6]

  d7 = g'(in7)*(y7-a7) = 70 - 646630; deltas{3} = [ d7 ]
  d5 = g'(in5)*w57*d7; deltas{layerIx} = [ d5 ];
  d6 = g'(in6)*w67*d7; deltas{layerIx} = [ d5; d6 ];
  d3 = g'(in3)*w35*d5 + g'(in3)*w36*d6; deltas{layerIx} = [ d3 ];
  d4 = g'(in4)*w45*d5 + g'(in4)*w46*d6; deltas{layerIx} = [ d3; d4 ];
%}

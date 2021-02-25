% shared variables
nn1 = {};
nn1{1} = [12 2];
cache1 = {};
cache1{1} = [14 14];

nn2 = {};
nn2{1} = [13 23 3];
cache2 = {};
cache2{1} = [62 62];

nn3 = {};
nn3{1} = [13 23 3; 14 24 4];
cache3 = {};
cache3{1} = [62 62; 66 66];


nn4 = {};
nn4{1} = [13 23 3; 14 24 4];
nn4{2} = [35 45 5];
cache4 = {};
cache4{1} = [62 62; 66 66];
cache4{2} = [5145 5145];

nn5 = {};
nn5{1} = [13 23 3; 14 24 4];
nn5{2} = [35 45 5; 36 46 6];
cache5 = {};
cache5{1} = [62 62; 66 66];
cache5{2} = [5145 5145; 5274 5274];

nn6 = {};
nn6{1} = [13 23 3; 14 24 4];
nn6{2} = [35 45 5; 36 46 6];
nn6{3} = [57 67 7];
cache6 = {};
cache6{1} = [62 62; 66 66];
cache6{2} = [5145 5145; 5274 5274];
cache6{3} = [646630 646630];


%% test 1: one input, one neuron network

deltas = backward(nn1, [20], cache1);
assert(deltas{1}(1, 1) == 6, 'neuron 2 delta failed');

%% test 2: two input, one neuron network

deltas = backward(nn2, [30], cache2);
assert(deltas{1}(1, 1) == -32, 'neuron 3 delta failed');

%% test 3: two input, two neuron network

deltas = backward(nn3, [30 40], cache3);
assert(deltas{1}(1, 1) == (30-62), 'neuron 3 delta failed');
assert(deltas{1}(2, 1) == (40-66), 'neuron 4 delta failed');

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

deltas = backward(nn4, [50], cache4);
d3 = deltas{1}(1,1);
d4 = deltas{1}(2,1);
d5 = deltas{2}(1,1);
disp('--- d3 ---');
disp(d3);
disp('--- d4 ---');
disp(d4);
disp('--- d5 ---');
disp(d5);
assert(d5 == (50-5145), 'neuron 5 delta failed');
assert(d3 == (35*(-5095)), 'neuron 3 delta failed');
assert(d4 == (45*(-5095)), 'neuron 4 delta failed');

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
deltas = backward(nn5, [50 60], cache5);
d3 = deltas{1}(1,1);
d4 = deltas{1}(2,1);
d5 = deltas{2}(1,1);
d6 = deltas{2}(2,1);
assert(d5 == (50-5145), 'neuron 5 delta failed');
assert(d6 == (60-5274), 'neuron 6 delta failed');
assert(d3 == (1*35*d5 + 1*36*d6), 'neuron 3 delta failed');
assert(d4 == (1*45*d5 + 1*46*d6), 'neuron 4 delta failed');

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
deltas = backward(nn6, [70], cache6);
d3 = deltas{1}(1,1);
d4 = deltas{1}(2,1);
d5 = deltas{2}(1,1);
d6 = deltas{2}(2,1);
d7 = deltas{3}(1,1);
assert(d7 == (70-646630), 'neuron 7 delta failed');
assert(d5 == (1*57*d7), 'neuron 5 delta failed');
assert(d6 == (1*67*d7), 'neuron 6 delta failed');
assert(d3 == (1*35*d5 + 1*36*d6), 'neuron 3 delta failed');
assert(d4 == (1*45*d5 + 1*46*d6), 'neuron 4 delta failed');
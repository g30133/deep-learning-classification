% shared variables
nn1 = {};
nn1{1} = [12 2];

nn2 = {};
nn2{1} = [13 23 3];

nn3 = {};
nn3{1} = [13 23 3; 14 24 4];

nn4 = {};
nn4{1} = [13 23 3; 14 24 4];
nn4{2} = [35 45 5];

nn5 = {};
nn5{1} = [13 23 3; 14 24 4];
nn5{2} = [35 45 5; 36 46 6];

nn6 = {};
nn6{1} = [13 23 3; 14 24 4];
nn6{2} = [35 45 5; 36 46 6];
nn6{3} = [57 67 7];

%% test 1: one input, one neuron network
cache1 = forward(nn1, [1]);
assert(cache1{1}(1, 1) == 14, 'neuron 2 input failed');
assert(cache1{1}(1, 2) == 14, 'neuron 2 output failed');

%% test 2: two input, layer 1 one neuron
cache2 = forward(nn2, [1 2]);
assert(cache2{1}(1, 1) == 62, 'neuron 3 input failed');
assert(cache2{1}(1, 2) == 62, 'neuron 3 output failed');

%% test 3: two input, layer 1 two neuron
cache3 = forward(nn3, [1 2]);
assert(cache3{1}(1, 1) == 62, 'neuron 3 input failed');
assert(cache3{1}(1, 2) == 62, 'neuron 3 output failed');
assert(cache3{1}(2, 1) == 66, 'neuron 4 input failed');
assert(cache3{1}(2, 2) == 66, 'neuron 4 output failed');

%% test 4: two input, layer 1 two neuron, layer 2 one neuron
cache4 = forward(nn4, [1 2]);
assert(cache4{1}(1, 1) == 62, 'neuron 3 input failed');
assert(cache4{1}(1, 2) == 62, 'neuron 3 output failed');
assert(cache4{1}(2, 1) == 66, 'neuron 4 input failed');
assert(cache4{1}(2, 2) == 66, 'neuron 4 output failed');
assert(cache4{2}(1, 1) == 5145, 'neuron 5 input failed');
assert(cache4{2}(1, 2) == 5145, 'neuron 5 output failed');

%% test 5: two input, layer 1 two neuron, layer 2 two neuron
cache5 = forward(nn5, [1 2]);
assert(cache5{1}(1, 1) == 62, 'neuron 3 input failed');
assert(cache5{1}(1, 2) == 62, 'neuron 3 output failed');
assert(cache5{1}(2, 1) == 66, 'neuron 4 input failed');
assert(cache5{1}(2, 2) == 66, 'neuron 4 output failed');
assert(cache5{2}(1, 1) == 5145, 'neuron 5 input failed');
assert(cache5{2}(1, 2) == 5145, 'neuron 5 output failed');
assert(cache5{2}(2, 1) == 5274, 'neuron 6 input failed');
assert(cache5{2}(2, 2) == 5274, 'neuron 6 output failed');

%% test 6: two input, layer 1 two neuron, layer 2 two neuron, layer 3 one neuron
cache6 = forward(nn6, [1 2]);
x1 = 1;
x2 = 2;
in3 = x1*13 + x2*23 + 3;
a3 = in3;
in4 = x1*14 + x2*24 + 4;
a4 = in4;
in5 = a3*35 + a4*45 + 5;
a5 = in5;
in6 = a3*36 + a4*46 + 6;
a6 = in6;
in7 = a5*57 + a6*67 + 7;
a7 = in7;
assert(cache6{1}(1, 1) == in3, 'neuron 3 input failed');
assert(cache6{1}(1, 2) == a3, 'neuron 3 output failed');
assert(cache6{1}(2, 1) == in4, 'neuron 4 input failed');
assert(cache6{1}(2, 2) == a4, 'neuron 4 output failed');
assert(cache6{2}(1, 1) == in5, 'neuron 5 input failed');
assert(cache6{2}(1, 2) == a5, 'neuron 5 output failed');
assert(cache6{2}(2, 1) == in6, 'neuron 6 input failed');
assert(cache6{2}(2, 2) == a6, 'neuron 6 output failed');
assert(cache6{3}(1, 1) == in7, 'neuron 7 input failed');
assert(cache6{3}(1, 2) == a7, 'neuron 7 output failed');
% shared variables
nn3 = {};
nn3{1} = [13 23 3; 14 24 4];
cache3 = {};
cache3{1} = [62 62; 66 66];
deltas3 = {};
deltas3{1} = [-32; -26];

nn5 = {};
nn5{1} = [13 23 3; 14 24 4];
nn5{2} = [35 45 5; 36 46 6];
cache5 = {};
cache5{1} = [62 62; 66 66];
cache5{2} = [5145 5145; 5274 5274];
deltas5 = {};
deltas5{1} = [35*(50-5145) + 36*(60-5274); 45*(50-5145) + 46*(60-5274)];
deltas5{2} = [50-5145; 60-5274];

%% test 1: two input, two neuron network
totalloss = totalloss(nn3, [1 2 30 40]);
assert(totalloss == (32^2)+(26^2), 'totalloss failed');

%% test 2: two input, two layer, two neuron network
totalloss = totalloss(nn5, [1 2 50 60]);
assert(totalloss == (5095^2)+(5214^2), 'totalloss 2 failed');
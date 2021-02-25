%{
    n: size of training data (expecting a positive even number)
    ni: number of input neurons
    nhn: number of neurons in a hidden layer
    nhl: number of hidden layers
    non: number of output neurons 
    stepsize: stepsize
    delay: in seconds
%}
function neuralnet = tfex(n, ni, nhn, nhl, non, stepsize, batchsize, nepoch, delay, threshold)

    trainingset = gencorerims(n);
    %trainingset = genspirals(n);
    %disptrainingset(trainingset);
    
    neuralnet = genneuralnet(ni, nhn, nhl, non);
    %celldisp(neuralnet);
    
    learningbp(trainingset, neuralnet, stepsize, batchsize, nepoch, delay, threshold);
end

function updatedNN = learningbp(examples, network, stepsize, batchsize, nepoch, delay, threshold)
    network0 = network;
    for n=1:nepoch
        %for ei = 1:size(examples, 1)
        for bi = 1: batchsize
            % stochastic: picking only one training data
            ei = randi(size(examples, 1));
            %disp(['training data picked']);
            %disp(examples(ei,:));
            
            input = examples(ei,1:2);
            output = examples(ei, 3:4);
            
            % forward phase
            cache = forward(network, input);
            
            % backward phase
            deltas = backward(network, output, cache);
            
            % update weights
            updatedNN = update(network, input, cache, deltas, stepsize);
            network = updatedNN;

        end
        
        % TODO: print training loss like playground tensorflow
        % CODE HERE
        
        testl = testloss(network, examples, threshold);
        disp(['epoch:', num2str(n), ' test loss:', num2str(testl)]);
        pause(delay);
    end
    disp(['epoch:', num2str(n), ' test loss:', num2str(testl)]);
    disp('----------------');
    celldisp(network0);
    disp('================');
    celldisp(network);
end

function y = relu(x)
    if x > 0
        y = x;
    else
        y = 0;
    end
end

function y = reluprime(x)
    if x > 0
        y = 1;
    else
        y = 0;
    end
end

function sum = weightedsum(weights, values)
    sum = 0;
    for i = 1:size(values, 2)
        sum = sum + weights(i) * values(i);
    end
    
    if size(weights, 1) > size(values, 1)
        sum = sum + weights(size(weights, 2));
    end
    disp('---------------------------------');
    disp('weights:');
    disp(weights);
    disp('values:');
    disp(values);
    disp(['sum: ', num2str(sum)]);
    disp('---------------------------------');
end

function disptrainingset(trainingset)
    
    disp(trainingset);
    for ri = 1:size(trainingset, 1)
        if trainingset(ri, 3) == 1
            plot(trainingset(ri, 1), trainingset(ri, 2), '*b');
            hold on;
        else
            plot(trainingset(ri, 1), trainingset(ri, 2), '*r');
        end
    end
    ylim([-6 6]);
    xlim([-6 6]);
end


% ni: number of input nodes
% nhn: number of neurons in a hidden layer
% nhl: number of hidden layers
% non: number of output neurons
function neuralnet = genneuralnet(ni, nhn, nhl, non)
    neuralnet = {};
    for i = 1:nhl
        if i == 1
            neuralnet{i} = -1 + 2 * rand(nhn, ni+1);
        else
            neuralnet{i} = -1 + 2 * rand(nhn, nhn+1);   
        end
    end
    neuralnet{nhl+1} = rand(non, nhn+1);
end

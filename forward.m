%{
    @network: cell type with each cell as a matrix of weights
        * one row takes weights belonging to a neuron
        * bias takes the last weight on a row
    @input: input values as a row vector
%}
function cache = forward(network, input)
    % TODO
    cache = {};
    %cache{1} = [14 14];
    for li = 1:size(network, 2)
        layer = network{li};
        calculations = [];
        for ni = 1:size(layer, 1)
            weights = layer(ni, :);
            if li == 1
                ws = weightedsum(weights, input);
            else
                lc = cache{li-1};
%                disp('WEIGHTS');
%                disp(weights);
%                disp('VALUES');
%                disp(lc(:,2));
                ws = weightedsum(weights, transpose(lc(:,2)));
%                disp(ws);
            end
            a = relu(ws);
            calculations(size(calculations, 1) + 1, :) = [ws a];
        end
        cache{li} = calculations;
    end
end

%{
function cache = forward(network, examples, ei)
    cache = {};
           
    for li = 1:size(network, 2)
               
        layer = network{li};
        cals = [];
        for ni = 1:size(layer, 1)
            weights = layer(ni, :);
            %disp(node);
            if li == 1
                ws = weightedsum(weights, examples(ei, 1:2));
                %disp(['sum:', num2str(sum)]);
                a = relu(ws);
                cals(size(cals, 1) + 1, :) = [ws a];
            else
                %disp(['rimax;', num2str(rimax), 'rimin:', num2str(rimin)]);
                lc = cache{li-1};
                ws = weightedsum(weights, lc(:,2));
                %disp(['sum:', num2str(sum)]);
                a = relu(ws);
                cals(size(cals, 1) + 1, :) = [ws a];
            end
        end
        cache{li} = cals;
    end
    disp('-------------------');
    celldisp(cache); 
    disp('-------------------');
end
%}

function sum = weightedsum(weights, values)
    sum = 0;
    for i = 1:size(values, 2)
        sum = sum + weights(i) * values(i);
    end    
    
    if size(weights, 2) > size(values, 2)
        sum = sum + weights(size(weights, 2));
    end
%{    
    disp('---------------------------------');
    disp('weights:');
    disp(weights);
    disp('values:');
    disp(values);
    disp(['sum: ', num2str(sum)]);
    disp('---------------------------------');
%}
end

function y = relu(x)
    if x > 0
        y = x;
    else
        y = 0;
    end
end

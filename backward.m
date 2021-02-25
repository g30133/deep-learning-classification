%{
    @network: neural network as a cell type
    @output: output of a training data as a row vector
    @cache: cell of matrix of input and output values for each neuron
%}
function deltas = backward(network, output, cache)    
    deltas = {};
    layerdeltas = [];
    
    outputlayerix = size(network, 2);
    outputlayer = network{outputlayerix};
    lcache = cache{size(cache, 2)};
    
    for nodeix = 1 : size(outputlayer, 1)
        y = output(nodeix);
        a = lcache(nodeix, 2);
%        disp('y:');
%        disp(y);
%        disp('a:');
%        disp(a);
        c = cache{outputlayerix}(nodeix, 1);
%        disp('c:');
%        disp(c);
        delta = reluprime(c) * (y - a);
%        disp('delta:');
%        disp(delta);
        layerdeltas(size(layerdeltas, 1) + 1, :) = delta;
    end
    deltas{outputlayerix} = layerdeltas;
    %disp('========================');
    %celldisp(deltas);
    %disp('========================');
    
    for layerix = outputlayerix - 1: -1: 1
        layer = cache{layerix};
        rlayer = deltas{layerix+1};
        rweight = network{layerix+1};
        %{
        disp('layer:');
        disp(layer);
        disp('rlayer:');
        disp(rlayer);
        disp('rweight:');
        disp(rweight);
        disp('LAYER SIZE:')
        disp(size(layer, 1));
        %}
        for neuronix = 1 : size(layer, 1)
            %disp(['neuronIx:', num2str(neuronix)])
            rw = rweight(:, neuronix);
            %{
            disp('W:EOFSDFNOFNWOEFUNW:DSKFNWf');
            disp(rw);
            delta = weightedsum(rw, rlayer);
            disp('delta:');
            disp(delta);
            %}
%            layerdeltas(layerix, neuronix) = delta;
            layerdeltas(neuronix, :) = delta;
        end
        deltas{layerix} = layerdeltas;
        %disp('+++++++++++++++++++++++')
        %celldisp(deltas);
    end
end
%{
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
%}

function sum = weightedsum(weights, values)
    sum = 0;
    for i = 1:size(values, 1)
        sum = sum + weights(i) * values(i);
    end
    
    if size(weights, 1) > size(values, 1)
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


function y = reluprime(x)
    if x > 0
        y = 1;
    else
        y = 0;
    end
end


%{
function deltas = backward(network, examples, ei, cache)
    deltas = {};
            
    layerdeltas = [];
          
    outputlayerix = size(network, 2);
    outputlayer = network{outputlayerix};
    lc = cache{size(cache, 2)};
    for ni = 1 : size(outputlayer, 1)
        y = examples(ei, ni+2);
        a = lc(ni,2);
        oc = cache{outputlayerix};
        in = oc(ni, 1);
        delta = reluprime(in) * (y - a);
        layerdeltas(size(layerdeltas, 1) + 1, :) = delta;
    end
    deltas{outputlayerix} = layerdeltas;
    disp('=================');
    celldisp(deltas);
    disp('=================');

    
    for li = outputlayerix-1:-1:1
        layer = cache{li};
        rlayer = deltas{li+1};

        rweight = network{li+1};
        rx = rweight(:, 1);
        for ri = 1 : size(rlayer)
            disp('rlayer at RI');
            disp(rlayer(ri));
            disp('weight values');
            disp(rx(ri));
        end
        weightedsum(rx, rlayer);

%        for ni = 1 : size(layer, 1)
%            in = layer(ni, 1);
%            delta = reluprime(in) * sum;
%        end
    end
    
    
end
%}
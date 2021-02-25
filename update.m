function updatedNN = update(network, input, cache, deltas, stepsize)
    %disp("updateNN >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    updatedNN = {};
    for li = 1:size(network, 2)
        updatedNN{li} = [];
        %disp(['layerIx:', num2str(li)]);
        layer = network{li};
        %disp('layer:');
        %disp(layer);
        for ni = 1:size(layer, 1)
            %disp(['  ni:', num2str(ni)]);
            weights = layer(ni, :);
            for wi = 1:size(weights, 2)
                %{
                disp(['wi:', num2str(wi)]);
                disp(weights(wi));
                disp('CACHE');
                celldisp(cache);
                disp(cache{li}(ni, 2));
                disp('DELTAS');
                disp(deltas{li}(ni));
                disp('INPUT');
                %}

                a = 1;
                if wi ~= size(weights, 2)
                    if li == 1
                        a = input(wi);
                    else
                        %disp('cache value:');
                        %disp(cache{li-1}(wi, 2))
                        a = cache{li-1}(wi, 2);
                    end
                end
                
                d = deltas{li}(ni);
                
                change = stepsize * a * d;
                %{
                if change == 0
                    disp(['        step:', num2str(stepsize), ' a:', num2str(a), ' d:', num2str(d)]);
                else
                    disp(['        ###########################################']);
                end
                %}
                weights(wi) = weights(wi) + change;                                        
            end
            %{
            disp('===========================');
            disp('new weights:')
            disp(weights);
            disp(['li:', num2str(li)]);
            disp('updatedNN:');
            celldisp(updatedNN);
            %}
            nextRowIx = size(updatedNN{li}, 1) + 1;
            %disp(['nextRowIx:', num2str(nextRowIx)]);
            updatedNN{li}(nextRowIx,:) = weights;
        end
    end
    %disp('now updatedNN is...');
    %celldisp(updatedNN);
    %disp("updateNN |||||||||||||||||||||||||||||||||||||||||");
end


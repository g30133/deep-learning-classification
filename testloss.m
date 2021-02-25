%{
    Assuming 2 input 2 output network
%}
function tl = testloss(network, examples, threshold)
    tl = 0;
    bxs = [];
    bys = [];
    rxs = [];
    rys = [];
    gxs = [];
    gys = [];
    
    %celldisp(network);
    for ei=1: size(examples, 1)
        input = examples(ei, 1:2);
        desired_output = examples(ei, 3:4);
        cache = forward(network, input);
        real_output = cache{size(cache, 2)}(:,2)';
        loss = (desired_output - real_output) * (desired_output - real_output)';
        %disp('----');
        %disp(input);
        %disp(desired_output);
        %disp(real_output);
        %disp(['ei:', num2str(ei), ' loss:', num2str(loss)]);
        tl = tl + loss;
        
        if desired_output == [1 -1] % blue
            if loss < threshold
                bxs(size(bxs, 2) + 1) = input(1);
                bys(size(bys, 2) + 1) = input(2);
            else % green
                gxs(size(gxs, 2) + 1) = input(1);
                gys(size(gys, 2) + 1) = input(2);  
            end
        elseif desired_output == [-1 1] % red
            if loss < threshold
                rxs(size(rxs, 2) + 1) = input(1);
                rys(size(rys, 2) + 1) = input(2);
            else % green
                gxs(size(gxs, 2) + 1) = input(1);
                gys(size(gys, 2) + 1) = input(2);  
            end
        else
            disp('ERROR!!!');
        end
    end
    
    tl = tl / size(examples, 1);
   
    %disp(['bxs:', num2str(size(bxs, 2)), ' | rxs:', num2str(size(rxs, 2)), ' | gxs:', num2str(size(gxs, 2))]);
    %hold on;
    plot(bxs, bys, '*b', rxs, rys, '*r', gxs, gys, '*g');
end

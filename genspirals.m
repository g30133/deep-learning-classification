function pts = genspirals(n)

    rpts = genspiral(n/2, 1, -1, 0);
    bpts = genspiral(n/2, -1, 1, pi);
    
    pts = [rpts; bpts];
    display(pts);
end

function pts = genspiral(n, output1, output2, theta0)
    pts = [];
    for i=1:n
        
        theta = i * pi/16 + theta0;
        rho = i;
        
        [x, y] = pol2cart(theta, rho);
        pts(size(pts, 1) + 1,:) = [x y output1 output2];
    end
end

function display(pts)
    bxs = [];
    bys = [];
    rxs = [];
    rys = [];
   
    for i=1: size(pts, 1)
        input = pts(i, 1:2);
        output = pts(i, 3:4);
        
        if output == [1 -1] % blue
            bxs(size(bxs, 2) + 1) = input(1);
            bys(size(bys, 2) + 1) = input(2);
        elseif output == [-1 1] % red
            rxs(size(rxs, 2) + 1) = input(1);
            rys(size(rys, 2) + 1) = input(2);
        else
            disp('ERROR!!!');
        end
    end
    
    disp(['bxs:', num2str(size(bxs, 2)), ' | rxs:', num2str(size(rxs, 2))]);
    %hold on;
    plot(bxs, bys, '*b', rxs, rys, '*r');
    ylim([-100 100]);
    xlim([-100 100]);
end
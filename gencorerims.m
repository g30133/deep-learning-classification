function trainingset = gencorerims(n)

    cpts = gencore(n/2, 2);
    rpts = genrim(n/2, 3, 5);
    
    trainingset = [cpts; rpts];
end

function pts = gencore(n, rmax)  
    xs = -rmax + 2 * rmax * rand(10*n, 1);
    ys = -rmax + 2 * rmax * rand(10*n, 1);
    
    pts = [];
    npts = 0;
    
    for i=1:size(xs)
        x = xs(i);
        y = ys(i);
%       disp(['x: ', num2str(x), ' y:', num2str(y)]);

        if (x*x)+(y*y) < rmax*rmax
            npts = npts + 1;
            pts(npts, :) = [x y 1 -1];
        end
        if npts == n
            break
        end
    end
end

function pts = genrim(n, rmin, rmax)
    xs = -rmax + 2 * rmax * rand(10*n, 1);
    ys = -rmax + 2 * rmax * rand(10*n, 1);

    pts = [];
    npts = 0;
    
    for i=1:size(xs)
        x = xs(i);
        y = ys(i);
        l = (x*x)+(y*y);
        if l > rmin*rmin && l < rmax*rmax
            npts = npts + 1;
            pts(npts, :) = [x y -1 1];
        end
        if npts == n
            break
        end
    end
end
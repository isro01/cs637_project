
function ind = computeClosestPoint(x, y, refTraj)
    n = size(refTraj,1);
    dist = realmax;
    ind = 1;
    for i=1:n
        d = ((y-refTraj(i,2))^2) + ((x-refTraj(i,1))^2);
        if d<=dist
            dist = d;
            ind = i;
        end
    end
end
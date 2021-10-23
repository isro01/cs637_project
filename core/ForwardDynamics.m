
function [x_upd, k_upd, map] = ForwardDynamics(affsys, params, map, t)
    ind = ComputeClosestPoint(map.ego(1), map.ego(2), map.refTraj);
    x_upd = subs(affsys.x) + (params.dt * subs(affsys.xdot));
        
    [u,v] = updateCoordinates(ind, x_upd, map.refTraj, map.ego(1), map.ego(2), params);
    map.ego(1) = u;
    map.ego(2) = v;
    ind_n = ComputeClosestPoint(map.ego(1), map.ego(2), map.refTraj);
    k_upd =  map.curvature(ind_n);
    
    n = size(map.instanceList, 1);
    for i = 1:n
        map.instanceList(i).x = map.instanceList(i).trajectory(t, 1);
        map.instanceList(i).y = map.instanceList(i).trajectory(t, 2);
    end
end

function [x_n,y_n] = updateCoordinates(ind, state, refTraj, x, y, params)
    if size(refTraj, 1) == ind
       phi = (refTraj(ind, 2) - refTraj(ind-1, 2))/(refTraj(ind, 1) - refTraj(ind-1,1));
    else
       phi = (refTraj(ind, 2) - refTraj(ind+1, 2))/(refTraj(ind, 1) - refTraj(ind+1,1));
    end
    
   phi = atan(phi);

   theta = phi + state(3);

   x_n = subs(x + cos(theta) * state(4) * params.dt); 
   y_n = subs(y + sin(theta) * state(4) * params.dt);
end
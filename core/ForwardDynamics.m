
function [x_upd, k_upd, xCl_upd, yCl_upd] = ForwardDynamics(affsys, params, map, t)

    x_upd = double(subs(affsys.x)) + (params.dt * double(subs(affsys.xdot)));	
    xCl_upd = map.refTraj(t,1);
    yCl_upd = map.refTraj(t, 2);
    k_upd =  map.curvature(t);
    
    n = size(map.instanceList, 1);
    for i = 1:n
        map.instanceList(i).x = map.instanceList(i).trajectory(t, 1);
        map.instanceList(i).y = map.instanceList(i).trajectory(t, 2);
    end
end

% function [x_n,y_n] = updateCoordinates(ind, state, refTraj, x, y, params)
%     if size(refTraj, 1) == ind
%        phi = (refTraj(ind, 2) - refTraj(ind-1, 2))/(refTraj(ind, 1) - refTraj(ind-1,1));
%     else
%        phi = (refTraj(ind, 2) - refTraj(ind+1, 2))/(refTraj(ind, 1) - refTraj(ind+1,1));
%     end
%     
%    phi = atan(phi);
% 
%    theta = phi + state(3);
% 
%    x_n = subs(x + cos(theta) * state(4) * params.dt); 
%    y_n = subs(y + sin(theta) * state(4) * params.dt);
% end
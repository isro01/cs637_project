
function [xp, yp] = UpdatePedestrian(map, x_curr, y_curr)
    d_minf = realmax;
    ind = 1;
        for i=1:length(map.instanceList)
            if map.instanceList(i).type == "pedestrian"
                d_minf_i = sqrt( (x_curr - map.instanceList(i).x)^2 + (y_curr - map.instanceList(i).y )^2 );
                if d_minf_i <= d_minf
                    d_minf = d_minf_i;
                    ind = i;
                end
            end
        end
     xp = map.instanceList(ind).x;
     yp = map.instanceList(ind).y;
end
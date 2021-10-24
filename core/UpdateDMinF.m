
function d_lane = UpdateDMinF(x_curr, y_curr, map, x_traj, y_traj)

    d_minf = realmax;
    for i=1:length(map.instanceList)
        if map.instanceList(i).type == "pedestrian"
            d_minf_i = sqrt( (x_curr - map.instanceList(i).x)^2 + (y_curr - map.instanceList(i).y )^2 );
            if d_minf_i <= d_minf
                d_minf = d_minf_i;
            end
        end
    end
    d_minf_sym = sym(d_minf);
    
    d_temp = sqrt( (x_curr-x_traj)^2 + (y_curr - y_traj)^2 );
    if d_temp < (map.laneWidth/2)
        d_lane = 0;
    end
    if d_temp >= (map.laneWidth/2)
        d_lane = 2*d_temp;
    end
    

end
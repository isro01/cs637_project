
function d_minf = UpdateDMinF(x_curr, y_curr, map)
    d_minf = realmax;
    for i=1:length(map.instanceList)
        if map.instanceList(i).type == "pedestrian"
            d_minf_i = sqrt( (x_curr - map.instanceList(i).x)^2 + (y_curr - map.instanceList(i).y )^2 );
            if d_minf_i <= d_minf
                d_minf = d_minf_i;
            end
        end
    end
end
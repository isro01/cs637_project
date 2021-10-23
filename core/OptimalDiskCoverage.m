%% Optimal Disc Coverage -  sets clearance values for each instance on the basis of type


function clearance = OptimalDiskCoverage(params, instance)
    if instance.type == "pedestrian"
        clearance = params.d_ped;
    end
    if instance.type == "vehicle"
        if instance.state == "active"
            clearance = params.d_veh * params.k_active * instance.speed;
        end
        if instance.state == "passive"
            clearance = params.d_veh;
        end
    end
end



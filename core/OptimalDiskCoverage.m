%% Optimal Disc Coverage -  sets clearance values for each instance on the basis of type

classdef OptimalDiskCoverage
    properties
       clear; 
    end
    
    methods
        function self = OptimalDiskCoverage(params, instance)
            if instance.type == "pedestrian"
                instance.clearance = params.d_ped;
            end
            if instance.type == "vehicle"
                if intance.state == "active"
                    instance.clearance = params.d_veh * params.k_actve * instance.speed;
                end
                if instance.state == "passive"
                    instance.clearance = params.d_veh;
                end
            end
            
            self.clear = instance.clearance;
        end
    end
end


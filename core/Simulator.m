classdef Simulator
    properties
        ego_vehicle;
        active_vehicles; % list of active vehicles
        inactive_vehicles; % list of inactive vehicles
        pedestrians; % list of pedestrians
        lanes;
        dt;
    end
    methods
        function self = Simulator(lanes, ego_vehicle, active_vehicles, inactive_vehicles, pedestrians, dt)
            self.ego_vehicle = ego_vehicle;
            self.active_vehicles = active_vehicles;
            self.inactive_vehicles = inactive_vehicles;
            self.pedestrians = pedestrians;
            self.lanes = lanes;
            self.dt = dt;
        end
        
        function [state_log, input_log] = startSimuation(self, simulation_time)
            num_iterations = simulation_time / self.dt;
            for i = 1 : num_iterations
                figure(1); % It ensures that we are using the same figure in all the iterations
                set(gcf, 'Current_Position', [0, 0, 2500, 1300]); % Set graphics object properties; Values needs to be reconsidered
                clf;
                self.lanes.plot_lanes; % plotting lanes
                hold on;

                num_active_vehicles = size(self.active_vehicles, 1);
                num_inactive_vehicles = size(self.inactive_vehicles, 1);
                num_pedestrians = size(self.pedestrians, 1);

                if num_active_vehicles >= 1
                    for k = 1 : num_active_vehicles
                        self.active_vehicles(k).plot_vehicle; % plot active vehicles
                        self.active_vehicles(k).update; % update state of active vehicles
                    end
                end
                if num_inactive_vehicles >= 1
                    for k = 1 : num_inactive_vehicles
                        self.inactive_vehicles(k).plot_vehicle; % plot inactive vehicles
                        self.inactive_vehicles(k).update; % update state of inactive vehicles
                    end
                end
                if pedestrians >= 1
                    for k = 1 : pedestrians
                        self.pedestrians(k).plot_vehicle; % plot pedestrians
                        self.pedestrians(k).update; % update state of pedestrians
                    end
                end

                self.ego_vehicle.plot_vehicle; % plot ego_vehicle
                self.ego_vehicle.update; % update state of ego_vehicle
            end
            state_log = self.ego_vehicle.state_log; % update state history
            input_log = self.ego_vehicle.input_log; % update input history
        end
    end
end
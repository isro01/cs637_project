classdef SimulatorRandomTest
    properties
        ego_vehicle;
        active_vehicles; % list of active vehicles
        inactive_vehicles; % list of inactive vehicles
        pedestrians; % list of pedestrians
        lanes;
        dt;
        controller;
    end
    methods
        function self = SimulatorRandomTest(lanes, ego_vehicle, active_vehicles, inactive_vehicles, pedestrians, dt, controller)
            self.ego_vehicle = ego_vehicle;
            self.active_vehicles = active_vehicles;
            self.inactive_vehicles = inactive_vehicles;
            self.pedestrians = pedestrians;
            self.lanes = lanes;
            self.dt = dt;
            self.controller = controller;
        end
        function [complete_time] = startSimulation(self, simulation_time)
            try
                num_iterations = simulation_time / self.dt;
                lane_count = 0; % determines how long has the ego vehicle been in the target lane continuously
                for i = 1 : num_iterations
                    num_active_vehicles = size(self.active_vehicles, 1);
                    num_inactive_vehicles = size(self.inactive_vehicles, 1);
                    num_pedestrians = size(self.pedestrians, 1);

                    if num_active_vehicles >= 1
                        for k = 1 : num_active_vehicles
                            self.active_vehicles(k).update; % update state of active vehicles
                        end
                    end
                    if num_inactive_vehicles >= 1
                        for k = 1 : num_inactive_vehicles
                            self.inactive_vehicles(k).update; % update state of inactive vehicles
                        end
                    end
                    if pedestrians >= 1
                        for k = 1 : pedestrians
                            self.pedestrians(k).update; % update state of pedestrians
                        end
                    end

                    self.ego_vehicle.update; % update ego-vehicle's state
                    if self.ego_vehicle.lane_id == self.ego_vehicle.initial_lane_id + self.ego_vehicle.direction_flag
                        lane_count++;
                    else
                        lane_count = 0;
                    end
                    if lane_count >= 150 % if the ego vehicle is in the target lane for 1.5s continuously
                        break
                    end
                end
                complete_time = i * self.dt;
            catch
                complete_time = 100; % if the ego vehicle can not meet the safety-critical constraint, the time will be set to 100s
            end
        end
    end
end
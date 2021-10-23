classdef Instance
    properties
        type;
        x;
        y;
        clearance;
        state;
        trajectory;
        speed;
    end
    methods
        function self = Instance(x, y, type, state, trajectory, speed)
            self.x = x;
            self.y = y;
            self.type = type;
            self.state = state;
            self.trajectory = trajectory;
            self.speed = speed;
        end
    end
end
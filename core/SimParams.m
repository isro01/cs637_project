classdef SimParams
    properties
        v_max = 10; % Maximum speed
        v_min = 0; % Minimum speed
        a_max = 5.5; % Maximum acceleration
        a_min = -5.5; % Minimum acceleration
        u_j_max = 8; % Maximum control input for jerk
        u_j_min = -8; % Minimum control input for jerk
        delta_max = 1; % Maximum steering angle
        delta_min = -1; % Minimum steering angle
        w_max = 0.5; % Maximum steering rate
        w_min = -0.5; % Minimum steering rate
        u_s_max = 2; % Maximum control input for steering
        u_s_min = -2; % Minimum control input for steering
        w = 1.8; % width of ego's footprint
        l = 4; % length of ego's footprint
        lf = 2; % length of the ego vehicle from the head to the CoG
        lr = 2; % length of the ego vehicle from the tail to the CoG
        d_1 = 5; % fixed distance based on which clearance threshold(in case of pedestrians) is given
        eta_1 = 0.097 % the rate at which the above distance d_1 increases linearly
        v_max_s = 7; % Maximum speed in a scenario s which varies for different road types
        v_min_s = 3; % Minimum speed in a scenario s which varies for different road types
        a_max_s = 2.5; % maximum acceleration in a scenario s
        a_lat_m = 2.5; % maximum feasible lateral acceleration of the vehicle
        a_lat_s = 1.75; % allowed lateral acceleration in a scenario s
        d_7 = 0.3; % fixed distance based on which clearance threshold(in case of parked vehicles) is given
        eta_7 = 0.13; % the rate at which the above distance d_7 increases linearly
        d_8_l = 0.5; % distance between footprints of ego and an active vehicle on left based on which clearance threshold is given
        d_8_r = 0.5; % distance between footprints of ego and an active vehicle on right based on which clearance threshold is given
        d_8_f = 1; % distance between footprints of ego and an active vehicle on front based on which clearance threshold is given
        eta_8_r = 0.036; % the rate at which the above distance d_8_r increases linearly
        eta_8_l = 0.036; % the rate at which the above distance d_8_l increases linearly
        eta_8_f = 2; % the rate at which the above distance d_8_f increases linearly
        vd = 1; % desired speed
        beta = 2; % a variable which is defined to be equal to arctan((lr * tan(delta))/(lr + lf))
        
        eps = 0.01; % epsilon : very small positive constant, used in stablizing the error states to 0
        umin = [-8; -8]; % Minimum values of quantities in the control constraint set
        umax = [8; 8]; % Maximum values of quantities in the control constraint set
        c0 = 1; % A positive constant used in defining the CLF
        udim = 2; % dimension of the control input
        slack_dim = 15; % dimension of HOCBF relaxations
        slack_weight = eye(15); % HOCBF relaxations
        x_dim = 7; % dimension of state of the vehicle
        k1=1; % A positive constant used in defining the CLF
        dt=0.01; % instantaneous change in time
        N=6400; % number of iterations
        d_veh=5; % distance of vehicle from ego
        k_active=0.1; % a constant used to define the clearance from active vehicles
        d_max = 1; %  maximum infringement distance
        
        p1=0.01;
        p2=1;
        p3=1;
        p4=1;
        
        p5=100;
    end
end

        
        
        
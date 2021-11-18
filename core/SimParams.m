classdef SimParams
    properties
        v_max = 10;
        v_min = 0;
        a_max = 5.5; 
        a_min = -5.5;
        u_j_max = 8;
        u_j_min = -8;
        delta_max = 1;
        delta_min = -1;
        w_max = 0.5;
        w_min = -0.5;
        u_s_max = 2;
        u_s_min = -2;
        w = 1.8;
        l = 4;
        lf = 2;
        lr = 2;
        d_1 = 5;
        eta_1 = 0.097
        v_max_s = 7;
        v_min_s = 3;
        a_max_s = 2.5;
        a_lat_m = 2.5;
        a_lat_s = 1.75;
        d_7 = 0.3;
        eta_7 = 0.13;
        d_8_l = 0.5;
        d_8_r = 0.5;
        d_8_f = 1;
        eta_8_r = 0.036;
        eta_8_l = 0.036;
        eta_8_f = 2;
        vd = 1; % desired vel
        beta = 2;
        
        eps = 0.01;
        umin = [-8; -8];
        umax = [8; 8];
        c0 = 1;
        udim = 2;
        slack_dim = 15;
        slack_weight = eye(15);
        x_dim = 7;
        k1=1;
        dt=0.01;
        N=6400;
        d_veh=5;
        k_active=0.1;
        d_max = 1;
        
        p1=0.01;
        p2=1;
        p3=1;
        p4=1;
        
        p5=100;
    end
end

        
        
        